#!/usr/bin/env bash
# ==============================================================================
# syncoid-run.sh — ZFS Replication to backup-tank
# Schedule: Cron at 04:15 AM (after Sanoid snapshots at 04:00 AM)
# ==============================================================================
set -euo pipefail

# Load .env for DISCORD_WEBHOOK_URL
ENV_FILE="/opt/.env"
if [[ -f "$ENV_FILE" ]]; then
  set -a; source "$ENV_FILE"; set +a
fi

WEBHOOK_URL="${DISCORD_WEBHOOK_URL:?DISCORD_WEBHOOK_URL must be set in .env}"
LOG="/var/log/media-backup/syncoid.log"
FAILED=0

# --- 1. Replicate media-tank (Excluding Docker System Files) ---
echo "$(date '+%Y-%m-%d %H:%M:%S') — Starting media-tank replication" >> "$LOG"
if ! /usr/sbin/syncoid -r --exclude=media-tank/docker --no-sync-snap media-tank backup-tank/media-mirror >> "$LOG" 2>&1; then
  FAILED=1
fi

# --- 2. Replicate music-tank ---
echo "$(date '+%Y-%m-%d %H:%M:%S') — Starting music-tank replication" >> "$LOG"
if ! /usr/sbin/syncoid -r --no-sync-snap music-tank backup-tank/music-mirror >> "$LOG" 2>&1; then
  FAILED=1
fi

# --- Alert on failure ---
if [[ "$FAILED" -ne 0 ]]; then
  JSON_PAYLOAD='{"content": "🚨 **URGENT:** Syncoid replication to `backup-tank` FAILED! Please check `/var/log/media-backup/syncoid.log` for details."}'
  curl -s -H "Content-Type: application/json" -d "$JSON_PAYLOAD" "$WEBHOOK_URL"
fi
