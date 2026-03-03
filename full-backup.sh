#!/usr/bin/env bash
# ==============================================================================
# full-backup.sh — Cache Sync & Git Push
# Purpose: Sync SSD cache to the backup pool and push configs to GitHub.
# Schedule: Run via Cron at 03:50 AM (10 mins before Sanoid snapshots).
# ==============================================================================
set -Eeuo pipefail

LOG_DIR="/var/log/media-backup"
DATE=$(date '+%Y-%m-%d %H:%M:%S UTC')

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
REPO_URL="git@github.com:rogerworkman1972/media-server.git"
BRANCH="main"
SOURCE_DIR="/opt"
WORK_DIR="/tmp/media_server_git_$$"
COMMIT_MSG="chore: daily sync — $(date '+%Y-%m-%d')"

cleanup() { [[ -d "$WORK_DIR" ]] && rm -rf "$WORK_DIR"; }
trap cleanup EXIT

if command -v git >/dev/null 2>&1 && command -v rsync >/dev/null 2>&1 && [[ -d "$SOURCE_DIR" ]]; then
  git clone --depth=1 --branch "$BRANCH" "$REPO_URL" "$WORK_DIR" 2>&1 | sed 's/^/  /'

  find "$WORK_DIR" -mindepth 1 -maxdepth 1 ! -name '.git' -exec rm -rf {} +
  
  # Crucial: Excludes /opt/.env from being copied to the git repo
  rsync -a --exclude='.env' --exclude='.git' "$SOURCE_DIR/" "$WORK_DIR/"

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
  echo "  ⚠️  git/rsync not found or $SOURCE_DIR missing — skipping push."
fi

echo "============================================================"
echo " Finished: $(date '+%Y-%m-%d %H:%M:%S UTC')"
echo "============================================================"
