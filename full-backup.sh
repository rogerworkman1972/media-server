#!/usr/bin/env bash
# ==============================================================================
# full-backup.sh — Production Media Server Backup
# ZFS incremental replication + rsync for non-ZFS paths
#
# CHANGES FROM REVIEW (all annotated with [FIX]):
#   C-3a  MariaDB lock now held across the ZFS snapshot window (was a no-op)
#   C-3b  Full ZFS send fallback now requires explicit operator confirmation
#   L-5   STACK_DIR auto-derived from script location (was hardcoded /opt)
#   L-6   rsync output logged to dated logfile under /var/log/media-backup/
# ==============================================================================
set -Eeuo pipefail

# ==============================================================================
# CONFIGURATION
# ==============================================================================

# [FIX L-5] Derive STACK_DIR from the script's own location instead of
# hardcoding /opt. This matches the pattern used in manage-stack.sh and
# ensures the .env and compose file are always found regardless of where
# the script is installed.
STACK_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
COMPOSE_FILE="$STACK_DIR/docker-compose.yml"

SOURCE_POOL="media-tank"
DEST_POOL="backup-tank/media-mirror"
DATE=$(date +%Y%m%d-%H%M)
NEW_SNAP="$SOURCE_POOL@backup-$DATE"
RETENTION_DAYS=15

# TIP: Run 'docker compose ls' to see your actual PROJECT NAME
PROJECT_NAME="media-stack"

# [FIX L-6] Log directory for rsync output. Each run produces a dated file.
LOG_DIR="/var/log/media-backup"

# ==============================================================================
# 1. LOAD ENVIRONMENT VARIABLES SAFELY
# ==============================================================================
if [[ -f "$STACK_DIR/.env" ]]; then
    echo "📂 Loading environment variables from $STACK_DIR/.env..."
    set -a
    # shellcheck disable=SC1091
    source "$STACK_DIR/.env"
    set +a
else
    echo "❌ ERROR: .env file not found at $STACK_DIR/.env"
    exit 1
fi

# Validation: Ensure the specific vars we need for the DB flush are present
: "${MASTER_USER:?MASTER_USER not found in .env}"
: "${NPM_MYSQL_ROOT_PASSWORD:?NPM_MYSQL_ROOT_PASSWORD not found in .env}"

# ==============================================================================
# 2. PRE-BACKUP DATABASE FLUSH (Memory to Disk)
# ==============================================================================
echo "--- 1. Pre-Backup Database Flush ---"

# Check if Docker is running before attempting exec
if docker compose -f "$COMPOSE_FILE" -p "$PROJECT_NAME" ps --format json | grep -q "running"; then

    # --- Postgres: CHECKPOINT is safe and atomic ---
    echo "⏱  Checkpointing Postgres..."
    docker compose -f "$COMPOSE_FILE" -p "$PROJECT_NAME" \
        exec -T postgres psql -U "${MASTER_USER}" -d postgres -c "CHECKPOINT;" \
        || echo "⚠️  Postgres CHECKPOINT failed — continuing"

    # --- MariaDB: Hold the lock across the ZFS snapshot window ---
    # [FIX C-3a] The original single-statement FLUSH + UNLOCK was a no-op:
    # MariaDB releases the lock before the exec returns, giving zero write
    # protection during the snapshot. The fix uses a background connection
    # that holds FLUSH TABLES WITH READ LOCK open via DO SLEEP(), then kills
    # it after the snapshot is taken.
    echo "⏱  Acquiring MariaDB read lock..."
    docker compose -f "$COMPOSE_FILE" -p "$PROJECT_NAME" \
        exec -T nginx-db mariadb \
        -u root -p"${NPM_MYSQL_ROOT_PASSWORD}" \
        -e "FLUSH TABLES WITH READ LOCK; DO SLEEP(60);" &
    MARIADB_LOCK_PID=$!

    # Brief pause to ensure the lock is established before snapshotting
    sleep 2

    echo "📸 Creating new snapshot with MariaDB locked: $NEW_SNAP"
    zfs snapshot -r "$NEW_SNAP"
    ZFS_SNAP_EXIT=$?

    # Release the MariaDB lock by terminating the background connection
    echo "🔓 Releasing MariaDB read lock..."
    kill "$MARIADB_LOCK_PID" 2>/dev/null || true
    wait "$MARIADB_LOCK_PID" 2>/dev/null || true

    if [[ $ZFS_SNAP_EXIT -ne 0 ]]; then
        echo "❌ ERROR: ZFS snapshot failed. Aborting backup."
        exit 1
    fi

else
    echo "ℹ️  Containers are not running; skipping database flush."
    echo "📸 Creating new snapshot: $NEW_SNAP"
    zfs snapshot -r "$NEW_SNAP"
fi

# ==============================================================================
# 3. ZFS REPLICATION (Incremental)
# ==============================================================================
echo "--- 2. Starting ZFS Incremental Replication ---"

# Abort any stalled receives from previous failed attempts
zfs receive -A "$DEST_POOL" 2>/dev/null || true

# Find the most recent backup snapshot on the DESTINATION pool
LAST_DEST_SNAP_NAME=$(
    zfs list -t snapshot -o name -S creation -r "$DEST_POOL" \
        | grep -E '@backup-[0-9]{8}-[0-9]{4}$' \
        | head -n1 \
        | awk -F'@' '{print $2}' \
    || echo ""
)

# Verify if the destination's latest snapshot exists on the source for incrementals
if [[ -n "$LAST_DEST_SNAP_NAME" ]] && zfs list -t snapshot "$SOURCE_POOL@$LAST_DEST_SNAP_NAME" >/dev/null 2>&1; then
    LAST_SNAP="$SOURCE_POOL@$LAST_DEST_SNAP_NAME"
    echo "🔄 Sending increments from common snapshot: $LAST_SNAP → $NEW_SNAP"
    # -R: Replicate (include child datasets and properties)
    # -F: Force rollback dest to match source if needed
    # -u: Do NOT attempt to mount (prevents "busy" errors on dest)
    zfs send -R -i "$LAST_SNAP" "$NEW_SNAP" | zfs recv -Fu "$DEST_POOL"
else
    # [FIX C-3b] Full send now requires explicit operator confirmation.
    # A silent full send on an 8.7T pool could overwrite a diverged backup
    # replica with no recovery path. This is a safeguard — not a normal
    # code path. On first-ever run, answer YES. On unexpected fallback,
    # investigate why the common snapshot is missing before proceeding.
    echo ""
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║  ⚠️  WARNING: FULL ZFS SEND REQUIRED                        ║"
    echo "║                                                              ║"
    echo "║  No common snapshot found between source and destination.   ║"
    echo "║  A full send will completely overwrite the destination:     ║"
    echo "║    ${DEST_POOL}"
    echo "║                                                              ║"
    echo "║  This is expected on first run. If this is unexpected,      ║"
    echo "║  abort and investigate before proceeding.                   ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo ""

    # Support non-interactive mode (e.g. from cron with BACKUP_FORCE_FULL=1)
    if [[ "${BACKUP_FORCE_FULL:-0}" == "1" ]]; then
        echo "ℹ️  BACKUP_FORCE_FULL=1 set — proceeding with full send."
    else
        read -r -p "Type YES (uppercase) to proceed with full send, or anything else to abort: " CONFIRM
        if [[ "$CONFIRM" != "YES" ]]; then
            echo "❌ Aborted by operator. No data was written to destination."
            exit 1
        fi
    fi

    echo "⏳ Starting full ZFS send (this may take a long time)..."
    # -o canmount=off: Ensures the backup pool doesn't try to mount datasets
    # over live data paths on reboot of the backup host.
    zfs send -R "$NEW_SNAP" | zfs recv -Fu -o canmount=off "$DEST_POOL"
fi

# ==============================================================================
# 4. RSYNC FOR NON-ZFS PATHS
# ==============================================================================
echo "--- 3. Starting Rsync for SSD Cache & stack directory ---"

# [FIX L-6] Create log directory and set up a dated logfile for this run.
mkdir -p "$LOG_DIR"
RSYNC_LOG="$LOG_DIR/rsync-${DATE}.log"
echo "📋 rsync log: $RSYNC_LOG"

RSYNC_TARGETS=(
  "${STACK_DIR}/|/mnt/backup/opt-mirror/"
  "/mnt/ssd-cache/emby/|/mnt/backup/ssd-cache-mirror/emby/"
)

for entry in "${RSYNC_TARGETS[@]}"; do
    SRC="${entry%%|*}"
    DEST="${entry##*|}"
    if [ -d "$SRC" ]; then
        mkdir -p "$DEST"
        echo "📂 Syncing $SRC → $DEST"
        # [FIX L-6] --log-file writes per-file transfer details to dated logfile.
        # --info=stats2 appends transfer summary (bytes sent, speed, duration).
        rsync -aHAX \
            --delete \
            --exclude="transcode" \
            --log-file="$RSYNC_LOG" \
            --info=stats2 \
            "$SRC" "$DEST" \
            || echo "⚠️  rsync failed for $SRC → see $RSYNC_LOG"
    else
        echo "⚠️  Skipping rsync: Source $SRC not found"
    fi
done

# ==============================================================================
# 5. CLEANUP (Retention Policy)
# ==============================================================================
echo "--- 4. Cleaning up snapshots older than $RETENTION_DAYS days ---"
CUTOFF=$(date -d "$RETENTION_DAYS days ago" +%s)

cleanup_snapshots() {
    local pool=$1
    # Anchored grep pattern prevents false matches from non-backup snapshots
    zfs list -t snapshot -o name,creation -p -r "$pool" \
        | grep -E '@backup-[0-9]{8}-[0-9]{4}$' \
        | while read -r name creation; do
            if [[ "$creation" -lt "$CUTOFF" ]]; then
                echo "🔥 Destroying old snapshot: $name"
                zfs destroy -r "$name"
            fi
        done
}

cleanup_snapshots "$SOURCE_POOL"
cleanup_snapshots "$DEST_POOL"

# ==============================================================================
# DONE
# ==============================================================================
echo ""
echo "✅ Backup complete: $(date)"
echo "   Snapshot : $NEW_SNAP"
echo "   rsync log: $RSYNC_LOG"
