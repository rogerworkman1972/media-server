#!/usr/bin/env bash
# ==============================================================================
# full-backup.sh — Cache Sync & Git Push
# Purpose: Sync SSD cache to the backup pool and push configs to GitHub.
# Schedule: Run via Cron at 03:50 AM (10 mins before Sanoid snapshots).
# ==============================================================================
set -Eeuo pipefail

LOG_DIR="/var/log/media-backup"
DATE=$(date '+%Y-%m-%d %H:%M:%S UTC')
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

mkdir -p "$LOG_DIR"

echo "============================================================"
echo " Cache Sync & Git Push — $DATE"
echo "============================================================"

# --- SYNC EMBY CACHE TO BACKUP POOL ---
EMBY_CACHE_SRC="/mnt/ssd-cache/emby"
EMBY_CACHE_DEST="/mnt/backup/ssd-cache-mirror/emby" 

echo "--- [1/2] Rsync Emby Cache to Backup Tank ---"
if [[ -d "$EMBY_CACHE_SRC" ]]; then
  mkdir -p "$EMBY_CACHE_DEST"
  rsync -a --delete "$EMBY_CACHE_SRC/" "$EMBY_CACHE_DEST/"
  echo "  ✅ Emby cache synced to $EMBY_CACHE_DEST."
else
  echo "  ⚠️  Emby cache source ($EMBY_CACHE_SRC) not found — skipping."
fi

# --- GIT PUSH CONFIGS TO GITHUB ---
echo "--- [2/2] Git push /opt → GitHub ---"
PUSH_SCRIPT="${SCRIPT_DIR}/push_git.sh"

if [[ -x "$PUSH_SCRIPT" ]]; then
  # Execute push_git.sh with a custom daily message, indenting output for neat logs
  "$PUSH_SCRIPT" -m "chore: daily sync — $(date '+%Y-%m-%d')" | sed 's/^/  /'
else
  echo "  ⚠️  $PUSH_SCRIPT not found or not executable. Did you run 'chmod +x'?"
fi

echo "============================================================"
echo " Finished: $(date '+%Y-%m-%d %H:%M:%S UTC')"
echo "============================================================"
