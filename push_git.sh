#!/usr/bin/env bash
# ==============================================================================
# push_git.sh — Sync /opt to GitHub (rogerworkman1972/media-server, branch: main)
#
# Usage:
#   ./push_git.sh                        # auto commit message
#   ./push_git.sh -m "my commit message" # custom message
# ==============================================================================
set -euo pipefail

# ------------------------------------------------------------------------------
# Config
# ------------------------------------------------------------------------------
REPO_URL="https://github.com/rogerworkman1972/media-server.git"
BRANCH="main"
SOURCE_DIR="/opt"
WORK_DIR="/tmp/media_server_sync_$$"
COMMIT_MSG="chore: sync /opt — $(date '+%Y-%m-%d %H:%M:%S')"

while getopts "m:" opt; do
  case $opt in
    m) COMMIT_MSG="$OPTARG" ;;
    *) echo "Usage: $0 [-m 'commit message']"; exit 1 ;;
  esac
done

# ------------------------------------------------------------------------------
# Colors / logging
# ------------------------------------------------------------------------------
GREEN='\033[0;32m'; YELLOW='\033[1;33m'; RED='\033[0;31m'; NC='\033[0m'
info() { echo -e "${GREEN}[INFO]${NC}  $*"; }
warn() { echo -e "${YELLOW}[WARN]${NC}  $*"; }
die()  { echo -e "${RED}[ERROR]${NC} $*" >&2; exit 1; }

# ------------------------------------------------------------------------------
# Pre-flight checks
# ------------------------------------------------------------------------------
command -v git >/dev/null 2>&1 || die "git is not installed."
[[ -d "$SOURCE_DIR" ]] || die "Source directory '$SOURCE_DIR' does not exist."

# ------------------------------------------------------------------------------
# Cleanup on exit
# ------------------------------------------------------------------------------
cleanup() { [[ -d "$WORK_DIR" ]] && rm -rf "$WORK_DIR"; }
trap cleanup EXIT

# ------------------------------------------------------------------------------
# Clone → sync → push
# ------------------------------------------------------------------------------
info "Cloning rogerworkman1972/media-server (branch: $BRANCH)…"
git clone --depth=1 --branch "$BRANCH" "$REPO_URL" "$WORK_DIR"

info "Clearing existing tracked content…"
find "$WORK_DIR" -mindepth 1 -maxdepth 1 ! -name '.git' -exec rm -rf {} +

info "Copying $SOURCE_DIR → repo…"
cp -a "$SOURCE_DIR"/. "$WORK_DIR/"

git -C "$WORK_DIR" add -A

if git -C "$WORK_DIR" diff --cached --quiet; then
  info "No changes detected — nothing to push."
  exit 0
fi

info "Changed files:"
git -C "$WORK_DIR" diff --cached --stat

git -C "$WORK_DIR" commit -m "$COMMIT_MSG"

info "Pushing to GitHub…"
git -C "$WORK_DIR" push --force origin "$BRANCH"

info "✅ /opt successfully pushed to rogerworkman1972/media-server."
