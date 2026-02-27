#!/usr/bin/env bash
# ==============================================================================
# manage-stack.sh — Media Stack Manager
# Interactive (whiptail) and CLI interface for docker compose operations.
#
# CHANGES FROM REVIEW (all annotated with [FIX]):
#   M-6   action_stats: guards against empty container list (hangs when stack down)
#   L-4   gui_menu: added visible "Checkpoint Postgres" entry to whiptail menu
# ==============================================================================

# =============================
# Docker Socket Access Check
# =============================
if ! docker info >/dev/null 2>&1; then
  echo "Docker is not accessible for user: $(id -un) (uid=$(id -u))."
  exit 1
fi

set -Eeuo pipefail
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# ==============================================================================
# CONFIGURATION
# ==============================================================================
PROJECT_NAME="${PROJECT_NAME:-media-stack}"
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
COMPOSE_FILE="${COMPOSE_FILE:-${SCRIPT_DIR}/docker-compose.yml}"
EXTERNAL_NET="${EXTERNAL_NET:-media_network}"
ZFS_POOL="${ZFS_POOL:-media-tank}"
PROFILES=(--profile media --profile ops)
PGUSER="${PGUSER:-${MASTER_USER:-postgres}}"
PGDATABASE="${PGDATABASE:-postgres}"

# ==============================================================================
# UTILITIES
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

zfs_available() {
  command -v zfs >/dev/null 2>&1 && command -v zpool >/dev/null 2>&1
}

snapshot_zfs() {
  local tag="$1"
  if zfs_available; then
    local snap="${ZFS_POOL}@${tag}-$(date +%Y%m%d-%H%M%S)"
    echo "Creating ZFS snapshot: $snap"
    zfs snapshot -r "$snap" || true
  fi
}

show_status() {
  dc ps
}

# ==============================================================================
# ACTIONS (Full Stack)
# ==============================================================================
action_up_all() {
  ensure_network
  snapshot_zfs "pre-up" || true
  echo "Bringing up the stack..."
  dc up -d
  snapshot_zfs "post-up" || true
  show_status
}

action_down_all() {
  snapshot_zfs "pre-down" || true
  echo "Stopping stack..."
  dc down
  snapshot_zfs "post-down" || true
}

action_restart() {
  snapshot_zfs "pre-restart" || true
  dc down
  action_up_all
  snapshot_zfs "post-restart" || true
}

action_pull_update() {
  ensure_network
  snapshot_zfs "pre-update" || true
  echo "Pulling images..."
  dc pull
  echo "Applying updates..."
  dc up -d --remove-orphans
  snapshot_zfs "post-update" || true
  show_status
}

action_validate() {
  echo "Validating compose config..."
  dc config -q && echo "OK: Compose file is valid."
}

action_checkpoint() {
  echo "Checkpointing Postgres..."
  dc exec -T postgres psql -U "$PGUSER" -d "$PGDATABASE" -c "CHECKPOINT;" >/dev/null
  echo "Done."
}

# [FIX M-6] Guard against empty container list. Previously `docker stats $(dc ps -q)`
# would hang indefinitely if dc ps -q returned nothing (stack fully down, partial
# failure, or wrong profile). Now exits cleanly with an informative message.
action_stats() {
  local ids
  ids=$(dc ps -q 2>/dev/null || true)
  if [[ -z "$ids" ]]; then
    echo "No running containers found for project '$PROJECT_NAME'."
    echo "Start the stack first with: $(basename "$0") up"
    return 0
  fi
  echo "Loading live container stats. Press Ctrl+C to exit."
  sleep 1
  # shellcheck disable=SC2086
  docker stats $ids
}

# ==============================================================================
# ACTIONS (System Maintenance)
# ==============================================================================
action_prune_images() {
  echo "Pruning unused/dangling images..."
  docker image prune -af
}

action_prune_system() {
  echo "Pruning unused containers, networks, and images..."
  docker system prune -af
}

action_prune_volumes() {
  echo "Pruning unused local volumes..."
  docker volume prune -f
}

# ==============================================================================
# ACTIONS (Single Container)
# ==============================================================================
action_logs()     { dc logs -f --tail=200 "${1:-}"; }
action_start()    { dc start "${1:-}"; }
action_stop()     { dc stop "${1:-}"; }
action_restart_single() { dc restart "${1:-}"; }
action_recreate() { dc up -d --force-recreate "${1:-}"; }
action_exec()     {
  echo "Opening shell in ${1:-}. Type 'exit' to return."
  # Use /bin/sh as it's more universally available than bash in alpine images
  dc exec "${1:-}" /bin/sh || echo "Could not open shell. Container might not be running or lacks /bin/sh."
}

# ==============================================================================
# GUI MENU (Whiptail)
# ==============================================================================
get_service_choice() {
  local action_title="$1"
  mapfile -t services < <(dc config --services 2>/dev/null | sort)

  if [ ${#services[@]} -eq 0 ]; then
    whiptail --msgbox "No services found in compose file." 10 40 3>&1 1>&2 2>&3
    return 1
  fi

  local menu_items=()
  for svc in "${services[@]}"; do
    menu_items+=("$svc" "")
  done

  whiptail --title "Select Service" --menu "$action_title" 20 60 12 "${menu_items[@]}" 3>&1 1>&2 2>&3
}

gui_manage_single() {
  local svc
  svc=$(get_service_choice "Choose a service to manage:")

  [[ -z "$svc" ]] && return 0

  while true; do
    local action
    action=$(whiptail --title "Manage: $svc" --menu "Select action for $svc:" 18 55 7 \
      "1" "View Logs (Tail)" \
      "2" "Start" \
      "3" "Stop" \
      "4" "Restart" \
      "5" "Re-create (Force)" \
      "6" "Open Shell (Exec)" \
      "7" "Back to Main Menu" 3>&1 1>&2 2>&3)

    [[ $? -ne 0 ]] && break

    clear
    case "$action" in
      1) action_logs "$svc" ;;
      2) action_start "$svc" ;;
      3) action_stop "$svc" ;;
      4) action_restart_single "$svc" ;;
      5) action_recreate "$svc" ;;
      6) action_exec "$svc" ;;
      7) break ;;
    esac

    echo
    read -n 1 -s -r -p "Press any key to continue..."
  done
}

gui_maintenance() {
  while true; do
    local action
    action=$(whiptail --title "System Maintenance" --menu "Select cleanup task:" 16 65 5 \
      "1" "Prune Unused Images" \
      "2" "Prune System (Stopped Containers/Networks)" \
      "3" "Prune Unused Volumes (DANGEROUS)" \
      "4" "Back to Main Menu" 3>&1 1>&2 2>&3)

    [[ $? -ne 0 ]] && break

    clear
    case "$action" in
      1) action_prune_images ;;
      2) action_prune_system ;;
      3)
         if whiptail --title "WARNING" --yesno "This will delete ALL local Docker volumes not currently attached to a running container. Are you sure?" 10 60; then
           action_prune_volumes
         else
           echo "Volume prune cancelled."
         fi
         ;;
      4) break ;;
    esac

    echo
    read -n 1 -s -r -p "Press any key to continue..."
  done
}

# [FIX L-4] Added "c" Checkpoint Postgres as a visible whiptail menu entry.
# Previously the hotkey existed in the case statement but was absent from the
# displayed menu — users had no way to discover it.
# Menu height bumped from 22→23 and item count from 11→12 to accommodate.
gui_menu() {
  if ! command -v whiptail >/dev/null 2>&1; then
    echo "Error: 'whiptail' is not installed. Falling back to CLI mode."
    usage
    exit 1
  fi

  while true; do
    CHOICE=$(whiptail --title "Media Stack Manager" --menu "Select an action to perform:" 23 65 12 \
      "1" "Up (Start Full Stack)" \
      "2" "Down (Stop Full Stack)" \
      "3" "Restart Full Stack" \
      "4" "Update (Pull & Recreate)" \
      "5" "Status (Show Containers)" \
      "6" "Live Stats (CPU/RAM/Net)" \
      "7" "Manage Single Service..." \
      "8" "System Maintenance (Prune)..." \
      "9" "Validate Compose Config" \
      "c" "Checkpoint Postgres (WAL flush)" \
      "0" "Exit" 3>&1 1>&2 2>&3)

    if [ $? -ne 0 ]; then
      clear
      exit 0
    fi

    clear
    case "$CHOICE" in
      1) action_up_all; read -n 1 -s -r -p "Press any key to return..." ;;
      2) action_down_all; read -n 1 -s -r -p "Press any key to return..." ;;
      3) action_restart; read -n 1 -s -r -p "Press any key to return..." ;;
      4) action_pull_update; read -n 1 -s -r -p "Press any key to return..." ;;
      5) show_status; echo; read -n 1 -s -r -p "Press any key to return..." ;;
      6) action_stats ;; # Returns naturally when user hits Ctrl+C
      7) gui_manage_single ;;
      8) gui_maintenance ;;
      9) action_validate; echo; read -n 1 -s -r -p "Press any key to return..." ;;
      c) action_checkpoint; echo; read -n 1 -s -r -p "Press any key to return..." ;;
      0) exit 0 ;;
    esac
  done
}

# ==============================================================================
# MAIN ROUTING
# ==============================================================================
usage() {
  cat <<EOF
Usage: $(basename "$0") [command] [args...]

Run without arguments to launch the interactive GUI menu.

Full Stack Commands:
  up                 Bring up the full stack
  down               Stop the stack
  restart            Down then up
  update             Pull + up -d --remove-orphans
  status             Show compose ps
  stats              Show live CPU/RAM usage (guards against empty stack)
  validate           Validate docker compose config
  checkpoint         Run a Postgres CHECKPOINT (WAL flush)

Maintenance Commands:
  prune-images       Remove unused/dangling images
  prune-system       Remove unused containers, networks, and images
  prune-volumes      Remove all unattached volumes

Single Container Commands:
  logs <service>     Tail logs for a specific service
  start <service>    Start a specific service
  stop <service>     Stop a specific service
  recreate <service> Force recreate a specific service
  exec <service>     Open a /bin/sh shell in a specific service

Notes:
  - pull_policy is 'if_not_present' on all services. Run 'update' (not 'up')
    to pull new image versions. 'up' will NOT re-pull existing images.
  - All up/down/restart/update operations create ZFS snapshots automatically.
EOF
}

main() {
  local cmd="${1:-gui}"
  shift || true

  case "$cmd" in
    up) action_up_all ;;
    down) action_down_all ;;
    restart) action_restart ;;
    update) action_pull_update ;;
    status) show_status ;;
    stats) action_stats ;;
    validate) action_validate ;;
    checkpoint) action_checkpoint ;;
    prune-images) action_prune_images ;;
    prune-system) action_prune_system ;;
    prune-volumes) action_prune_volumes ;;
    logs) action_logs "$1" ;;
    start) action_start "$1" ;;
    stop) action_stop "$1" ;;
    recreate) action_recreate "$1" ;;
    exec) action_exec "$1" ;;
    gui) gui_menu ;;
    -h|--help|help) usage ;;
    *) echo "Unknown command: $cmd"; echo; usage; exit 1 ;;
  esac
}

main "$@"
