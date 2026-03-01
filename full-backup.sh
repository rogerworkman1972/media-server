#!/usr/bin/env bash
# ==============================================================================
# full-backup.sh — Pre-Syncoid DB Flush + Git Push
# Purpose: Flush databases to disk before syncoid snapshots, then push
#          the stack config to GitHub for offsite config backup.
#
# Syncoid handles all ZFS replication and snapshot retention automatically.
# This script only does what syncoid cannot: DB consistency + config push.
#
# Systemd/Cron schedule: Run 15 minutes BEFORE syncoid (e.g. 03:15 UTC)
#   Cron example:  15 3 * * * /opt/media-stack/full-backup.sh >> /var/log/media-backup/daily.log 2>&1
#   Syncoid runs:  30 3 * * * (via syncoid.timer)
# ==============================================================================
set -Eeuo pipefail

STACK_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
LOG_DIR="/var/log/media-backup"
DATE=$(date '+%Y-%m-%d %H:%M:%S UTC')

mkdir -p "$LOG_DIR"

# Load .env
if [[ -f "$STACK_DIR/.env" ]]; then
  set -a; source "$STACK_DIR/.env"; set +a
else
  echo "❌ ERROR: .env not found at $STACK_DIR/.env" >&2
  exit 1
fi

: "${MASTER_USER:?MASTER_USER not set in .env}"
: "${NPM_MYSQL_ROOT_PASSWORD:?NPM_MYSQL_ROOT_PASSWORD not set in .env}"

PROJECT_NAME="${PROJECT_NAME:-media-stack}"

echo "============================================================"
echo " Pre-Syncoid Flush — $DATE"
echo "============================================================"

# ==============================================================================
# 1. POSTGRES CHECKPOINT
#    Flushes dirty WAL buffers to the ZFS dataset (/mnt/media/postgres)
#    so syncoid's snapshot captures a clean, consistent state.
# ==============================================================================
echo "--- [1/3] Postgres CHECKPOINT ---"
docker exec -t "${PROJECT_NAME}-postgres-1" \
  psql -U "${MASTER_USER}" -d postgres -c "CHECKPOINT;" \
  && echo "  ✅ Postgres checkpoint complete." \
  || echo "  ⚠️  Postgres checkpoint failed — syncoid will still snap, may catch dirty pages."

# ==============================================================================
# 2. MARIADB FLUSH
#    No read lock needed — syncoid takes the ZFS snapshot, not us.
#    FLUSH TABLES is enough to get clean table files on disk.
# ==============================================================================
echo "--- [2/3] MariaDB FLUSH TABLES ---"
docker exec -t "${PROJECT_NAME}-nginx-db-1" \
  mariadb -u root -p"${NPM_MYSQL_ROOT_PASSWORD}" \
  -e "FLUSH TABLES;" \
  && echo "  ✅ MariaDB flush complete." \
  || echo "  ⚠️  MariaDB flush failed — check container health."

# ==============================================================================
# 3. GIT PUSH — Stack config offsite to GitHub
#    Pushes /opt to rogerworkman1972/media-server (branch: main).
#    Sensitive values stay in .env which should be in .gitignore.
# ==============================================================================
echo "--- [3/3] Git push /opt → GitHub ---"

REPO_URL="https://github.com/rogerworkman1972/media-server.git"
BRANCH="main"
SOURCE_DIR="/opt"
WORK_DIR="/tmp/media_server_git_$$"
COMMIT_MSG="chore: daily sync — $(date '+%Y-%m-%d')"

cleanup() { [[ -d "$WORK_DIR" ]] && rm -rf "$WORK_DIR"; }
trap cleanup EXIT

if command -v git >/dev/null 2>&1 && [[ -d "$SOURCE_DIR" ]]; then
  git clone --depth=1 --branch "$BRANCH" "$REPO_URL" "$WORK_DIR" 2>&1 | sed 's/^/  /'

  find "$WORK_DIR" -mindepth 1 -maxdepth 1 ! -name '.git' -exec rm -rf {} +
  cp -a "$SOURCE_DIR"/. "$WORK_DIR/"

  git -C "$WORK_DIR" add -A

  if git -C "$WORK_DIR" diff --cached --quiet; then
    echo "  ℹ️  No config changes — nothing to push."
  else
    git -C "$WORK_DIR" diff --cached --stat | sed 's/^/  /'
    git -C "$WORK_DIR" commit -m "$COMMIT_MSG"
    git -C "$WORK_DIR" push --force origin "$BRANCH"
    echo "  ✅ Config pushed to GitHub."
  fi
else
  echo "  ⚠️  git not found or $SOURCE_DIR missing — skipping push."
fi

# ==============================================================================
# SUMMARY
# ==============================================================================
echo ""
echo "============================================================"
echo " ✅ DB flush complete — syncoid will snapshot at 03:30 UTC"
echo " ✅ Config pushed to rogerworkman1972/media-server"
echo " ℹ️  ZFS replication & retention managed by syncoid/sanoid"
echo " Finished: $(date '+%Y-%m-%d %H:%M:%S UTC')"
echo "============================================================"
