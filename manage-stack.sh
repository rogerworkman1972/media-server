#!/usr/bin/env bash
# ==============================================================================
# manage-stack.sh — Media Stack Manager
# Instant hotkey TUI + ZFS snapshot helpers
# ==============================================================================

# Docker socket check (fail fast before set -e kicks in)
if ! docker info >/dev/null 2>&1; then
  echo "❌ Docker not accessible for user: $(id -un). Add user to 'docker' group."
  exit 1
fi

set -Eeuo pipefail
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# ==============================================================================
# CONFIGURATION
# ==============================================================================
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

# Load .env so MASTER_USER, PUID, etc. are available
if [[ -f "${SCRIPT_DIR}/.env" ]]; then
  set -a; source "${SCRIPT_DIR}/.env"; set +a
fi

# Match project name to directory name to avoid compose "media-stack" split
PROJECT_NAME="${PROJECT_NAME:-$(basename "$SCRIPT_DIR")}"
COMPOSE_FILE="${COMPOSE_FILE:-${SCRIPT_DIR}/docker-compose.yml}"
EXTERNAL_NET="${EXTERNAL_NET:-media_network}"
ZFS_POOL="${ZFS_POOL:-media-tank}"
PROFILES=(--profile media --profile ops)

PGUSER="${MASTER_USER:-admin}"
PGDATABASE="postgres"

# ==============================================================================
# HELPERS
# ==============================================================================
dc() {
  docker compose -f "$COMPOSE_FILE" -p "$PROJECT_NAME" "${PROFILES[@]}" "$@"
}

ensure_network() {
  if ! docker network inspect "$EXTERNAL_NET" >/dev/null 2>&1; then
    echo "Creating external network: $EXTERNAL_NET"
    docker network create "$EXTERNAL_NET" >/dev/null
  fi
}

snapshot_zfs() {
  local tag="$1"
  if command -v zfs >/dev/null 2>&1; then
    local snap="${ZFS_POOL}@${tag}-$(date +%Y%m%d-%H%M%S)"
    echo "📸 ZFS snapshot: $snap"
    zfs snapshot -r "$snap" || echo "⚠️  ZFS snapshot failed (check permissions)."
  fi
}

pause() {
  echo -e "\nPress any key to return to menu..."
  read -r -n 1 -s
}

# ==============================================================================
# ACTIONS
# ==============================================================================
action_up_all() {
  ensure_network
  snapshot_zfs "pre-up"
  echo "🚀 Bringing up stack: $PROJECT_NAME"
  dc up -d
  snapshot_zfs "post-up"
}

action_down_all() {
  snapshot_zfs "pre-down"
  echo "🛑 Stopping stack: $PROJECT_NAME"
  dc down
}

action_update() {
  snapshot_zfs "pre-update"
  dc pull
  dc up -d --remove-orphans
  snapshot_zfs "post-update"
}

action_checkpoint() {
  echo "⏱  Checkpointing Postgres..."
  dc exec -T postgres psql -U "$PGUSER" -d "$PGDATABASE" -c "CHECKPOINT;" >/dev/null
  echo "✅ Checkpoint complete."
}

action_pg_shell() {
  echo "🐘 Connecting to Postgres shell..."
  docker exec -it postgres sh -lc "psql -U \"$PGUSER\" -d \"$PGDATABASE\""
}

action_prune() {
  echo "⚠️  This will remove all stopped containers, unused images, networks, and volumes."
  read -r -p "Confirm? [y/N]: " confirm
  [[ "${confirm,,}" == "y" ]] && docker system prune -af || echo "Aborted."
}

# ==============================================================================
# TERMINAL UI
# ==============================================================================
gui_menu() {
  while true; do
    clear
    echo "================================================================"
    echo " 🎬 Media Stack Manager: $PROJECT_NAME"
    echo "================================================================"
    echo " [1] Up   — Start full stack         [7] Manage single service"
    echo " [2] Down — Stop full stack          [8] Prune system (cleanup)"
    echo " [3] Restart full stack              [9] Validate config"
    echo " [4] Update (pull + up)              [c] Checkpoint Postgres"
    echo " [5] Status (show containers)        [p] Postgres Shell (psql)"
    echo " [6] Live stats (CPU/RAM)"
    echo " "
    echo " [0] Exit"
    echo "================================================================"
    echo -n " Select: "
    read -r -n 1 CHOICE
    echo -e "\n"

    case "$CHOICE" in
      1) action_up_all ;;
      2) action_down_all ;;
      3) action_down_all && action_up_all ;;
      4) action_update ;;
      5) dc ps ;;
      6) dc ps -q | xargs -r docker stats ;;
      7) gui_manage_single; continue ;;
      8) action_prune ;;
      9) dc config -q && echo "✅ Config valid." ;;
      c) action_checkpoint ;;
      p) action_pg_shell ;;
      0) 
        echo "Exiting..."
        break 
        ;;
      *) echo "Invalid option." ;;
    esac

    pause
  done
  
  clear
  return 0
}

gui_manage_single() {
  mapfile -t services < <(dc config --services 2>/dev/null | sort)

  echo "--- Service List ---"
  local i=1
  for svc in "${services[@]}"; do
    printf " [%2d] %s\n" "$i" "$svc"
    ((i++))
  done
  echo " [b]  Back"
  echo -n " Choice: "
  read -r svc_choice

  [[ "${svc_choice,,}" == "b" ]] && return

  if ! [[ "$svc_choice" =~ ^[0-9]+$ ]]; then
    echo "Invalid input. Please enter a number."; pause; return
  fi

  local idx=$(( svc_choice - 1 ))
  local selected="${services[$idx]:-}"

  if [[ -z "$selected" ]]; then
    echo "Invalid selection."; pause; return
  fi

  echo "--- $selected ---"
  echo " [1] Logs (tail 200)  [2] Start  [3] Stop  [4] Restart  [5] Shell"
  read -r -n 1 act
  echo -e "\n"

  case "$act" in
    1) dc logs -f --tail=200 "$selected" ;;
    2) dc start "$selected" ;;
    3) dc stop "$selected" ;;
    4) dc restart "$selected" ;;
    5) dc exec "$selected" /bin/sh ;;
    *) echo "Invalid." ;;
  esac

  pause
}

# ==============================================================================
# ENTRYPOINT
# ==============================================================================
main() {
  # Handle unbound $1 safely with ${1:-}
  local input_arg="${1:-gui}"
  local cmd="${input_arg,,}"

  case "$cmd" in
    gui)   gui_menu ;;
    up)    action_up_all ;;
    down)  action_down_all ;;
    *)     gui_menu ;;
  esac
}

# Call main with all arguments safely
main "${@:-}"

# Ensure complete script termination
exit 0
