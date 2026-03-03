#!/usr/bin/env bash
# ==============================================================================
# full-backup.sh — Pre-Snapshot DB Flush, Cache Sync & Git Push
# Purpose: Flush databases and sync SSD cache to disk immediately before 
#          snapshots, then push the stack config to GitHub.
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

# --- EMBY CACHE PATHS ---
# Corrected 'cashe' to 'cache' based on your system's mount points
EMBY_CACHE_SRC="/mnt/ssd-cache/emby"
EMBY_CACHE_DEST="/mnt/backup/ssd-cache-mirror/emby" 

echo "============================================================"
echo " Pre-Snapshot Flush & Sync — $DATE"
echo "============================================================"

# ==============================================================================
# 1. POSTGRES CHECKPOINT
# ==============================================================================
echo "--- [1/4] Postgres CHECKPOINT ---"
docker exec "${PROJECT_NAME}-postgres-1" \
  psql -U "${MASTER_USER}" -d postgres -c "CHECKPOINT;" \
  && echo "  ✅ Postgres checkpoint complete." \
  || echo "  ⚠️  Postgres checkpoint failed."

# ==============================================================================
# 2. MARIADB FLUSH
# ==============================================================================
echo "--- [2/4] MariaDB FLUSH TABLES ---"
docker exec "${PROJECT_NAME}-nginx-db-1" \
  mariadb -u root -p"${NPM_MYSQL_ROOT_PASSWORD}" -e "FLUSH TABLES;" \
  && echo "  ✅ MariaDB flush complete." \
  || echo "  ⚠️  MariaDB flush failed."

# ==============================================================================
# 3. SYNC EMBY CACHE TO BACKUP POOL
# ==============================================================================
echo "--- [3/4] Rsync Emby Cache to Backup Tank ---"
if [[ -d "$EMBY_CACHE_SRC" ]]; then
  mkdir -p "$EMBY_CACHE_DEST"
  # Using -a (archive) and --delete to keep an exact mirror
  rsync -a --delete "$EMBY_CACHE_SRC/" "$EMBY_CACHE_DEST/"
  echo "  ✅ Emby cache synced to $EMBY_CACHE_DEST."
else
  echo "  ⚠️  Emby cache source ($EMBY_CACHE_SRC) not found — skipping."
fi

# ==============================================================================
# 4. GIT PUSH — Stack config offsite to GitHub
# ==============================================================================
echo "--- [4/4] Git push /opt → GitHub ---"

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
