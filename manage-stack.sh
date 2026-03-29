#!/usr/bin/env bash
# ==============================================================================
# manage-stack.sh — Media Stack Manager
# Instant hotkey TUI + ZFS snapshot helpers + diagnostics
# ==============================================================================

# Docker socket check (fail fast before set -e kicks in)
if ! docker info >/dev/null 2>&1; then
  echo "Docker not accessible for user: $(id -un). Add user to 'docker' group."
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
ZFS_POOLS=("media-tank" "music-tank")   # All pools to snapshot on up/down/update
PROFILES=(--profile media --profile ops)

# How many days to retain manual (non-Sanoid, non-Syncoid) snapshots.
# Sanoid autosnap_ and syncoid_ snapshots are never touched by prune_manual_snapshots.
MANUAL_SNAP_RETAIN_DAYS="${MANUAL_SNAP_RETAIN_DAYS:-7}"

PGUSER="${MASTER_USER:-admin}"
PGDATABASE="postgres"
DISCORD_WEBHOOK="${DISCORD_WEBHOOK_URL:-}"

# ==============================================================================
# COLORS
# ==============================================================================
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
CYAN='\033[0;36m'; BOLD='\033[1m'; NC='\033[0m'

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
    local ts
    ts=$(date +%Y%m%d-%H%M%S)
    for pool in "${ZFS_POOLS[@]}"; do
      local snap="${pool}@${tag}-${ts}"
      echo -e "  ${CYAN}snapshot${NC}: $snap"
      sudo zfs snapshot -r "$snap" 2>/dev/null || echo -e "  ${YELLOW}warning${NC}: snapshot failed for $pool (check permissions)"
    done
  fi
}

# ------------------------------------------------------------------------------
# prune_manual_snapshots — destroy manual snapshots older than MANUAL_SNAP_RETAIN_DAYS
#
# Never touches:
#   - autosnap_* (Sanoid-managed)
#   - *syncoid*  (Syncoid incremental base — destroying these forces a full resend)
#
# Uses `zfs list -p` for parseable Unix epoch creation timestamps so date math
# is reliable regardless of locale or date format.
# ------------------------------------------------------------------------------
prune_manual_snapshots() {
  if ! command -v zfs >/dev/null 2>&1; then return; fi

  local days="${1:-$MANUAL_SNAP_RETAIN_DAYS}"
  local cutoff
  cutoff=$(( $(date +%s) - days * 86400 ))
  local pruned=0

  echo -e "  ${CYAN}pruning${NC}: manual snapshots older than ${days} days..."

  while IFS=$'\t' read -r name creation; do
    # Never touch Sanoid autosnaps or Syncoid incremental bases
    [[ "$name" == *autosnap_* ]] && continue
    [[ "$name" == *syncoid*   ]] && continue

    if (( creation < cutoff )); then
      echo -e "  ${YELLOW}destroy${NC}: $name"
      sudo zfs destroy "$name" 2>/dev/null || echo -e "  ${YELLOW}warning${NC}: could not destroy $name"
      (( pruned++ )) || true
    fi
  done < <(zfs list -H -t snapshot -o name,creation -p 2>/dev/null)

  if (( pruned == 0 )); then
    echo -e "  ${GREEN}no manual snapshots older than ${days} days found.${NC}"
  else
    echo -e "  ${GREEN}pruned ${pruned} snapshot(s).${NC}"
  fi
}

wait_for_keypress() {
  echo -e "\nPress any key to return to menu..."
  read -r -n 1 -s
}

# Print a section header
header() {
  echo -e "\n${BOLD}--- $1 ---${NC}"
}

# ==============================================================================
# CORE ACTIONS
# ==============================================================================
action_up_all() {
  ensure_network
  header "Pre-Up Snapshots"
  snapshot_zfs "pre-up"
  echo -e "\n${GREEN}Starting stack${NC}: $PROJECT_NAME"
  dc up -d
  header "Pruning old manual snapshots"
  prune_manual_snapshots
}

action_down_all() {
  header "Pre-Down Snapshots"
  snapshot_zfs "pre-down"
  echo -e "\n${RED}Stopping stack${NC}: $PROJECT_NAME"
  dc down
  header "Pruning old manual snapshots"
  prune_manual_snapshots
}

action_update() {
  header "Pre-Update Snapshots"
  snapshot_zfs "pre-update"
  echo -e "\n${CYAN}Pulling images...${NC}"
  dc pull
  echo -e "${CYAN}Recreating changed containers...${NC}"
  dc up -d --remove-orphans
  header "Pruning old manual snapshots"
  prune_manual_snapshots
  echo -e "\n${GREEN}Update complete.${NC} Checking health..."
  sleep 5
  action_health_check
}

action_checkpoint() {
  echo "Checkpointing Postgres..."
  if dc exec -T postgres psql -U "$PGUSER" -d "$PGDATABASE" -c "CHECKPOINT;" >/dev/null 2>&1; then
    echo -e "${GREEN}Checkpoint complete.${NC}"
  else
    echo -e "${RED}Checkpoint failed${NC} — is Postgres running?"
  fi
}

action_pg_shell() {
  echo "Connecting to Postgres shell..."
  docker exec -it postgres sh -lc "psql -U \"$PGUSER\" -d \"$PGDATABASE\""
}

action_prune() {
  echo -e "${YELLOW}This will remove stopped containers and unused images (not volumes).${NC}"
  read -r -p "Confirm? [y/N]: " confirm
  if [[ "${confirm,,}" == "y" ]]; then
    docker system prune -f
    echo -e "${GREEN}Pruned.${NC} Unused pulled images preserved (use 'docker image prune -a' to remove all)."
  else
    echo "Aborted."
  fi
}

# ==============================================================================
# DIAGNOSTICS
# ==============================================================================
action_health_check() {
  header "Container Health"
  local unhealthy=0
  while IFS=$'\t' read -r name status health; do
    health="${health:-N/A}"
    if [[ "$health" == "healthy" ]]; then
      printf "  ${GREEN}%-20s${NC} %s\n" "$name" "$health"
    elif [[ "$health" == "unhealthy" ]]; then
      printf "  ${RED}%-20s${NC} %s\n" "$name" "$health"
      ((unhealthy++))
    elif [[ "$status" == *"Exited (0)"* ]]; then
      printf "  ${CYAN}%-20s${NC} %s\n" "$name" "exited (init container)"
    else
      printf "  ${YELLOW}%-20s${NC} %s\n" "$name" "${health} (${status})"
    fi
  done < <(docker ps -a --filter "label=com.docker.compose.project=$PROJECT_NAME" \
    --format "{{.Names}}\t{{.Status}}\t{{.Label \"org.opencontainers.image.health\"}}" 2>/dev/null || \
    docker ps -a --format "{{.Names}}\t{{.Status}}" 2>/dev/null | while IFS=$'\t' read -r n s; do
      h="unknown"
      [[ "$s" == *"(healthy)"* ]] && h="healthy"
      [[ "$s" == *"(unhealthy)"* ]] && h="unhealthy"
      [[ "$s" == *"Exited"* ]] && h="exited"
      printf "%s\t%s\t%s\n" "$n" "$s" "$h"
    done)

  if [[ "$unhealthy" -gt 0 ]]; then
    echo -e "\n  ${RED}${unhealthy} unhealthy container(s)${NC}"
  else
    echo -e "\n  ${GREEN}All containers healthy.${NC}"
  fi
}

action_disk_report() {
  header "ZFS Pool Status"
  zpool list -o name,size,alloc,free,frag,cap,health 2>/dev/null || echo "  zpool not available"

  header "ZFS ARC"
  if command -v arcstat >/dev/null 2>&1; then
    arcstat 1 1 2>/dev/null || echo "  arcstat unavailable"
  else
    local arc_size arc_max
    arc_size=$(awk '/^size/ {printf "%.1f GB", $3/1073741824}' /proc/spl/kstat/zfs/arcstats 2>/dev/null || echo "N/A")
    arc_max=$(awk '/^c_max/ {printf "%.1f GB", $3/1073741824}' /proc/spl/kstat/zfs/arcstats 2>/dev/null || echo "N/A")
    echo "  ARC size: $arc_size  |  ARC max: $arc_max"
  fi

  header "SSD Cache (/mnt/ssd-cache)"
  df -h /mnt/ssd-cache 2>/dev/null | awk 'NR==2 {printf "  Used: %s / %s (%s)\n", $3, $2, $5}' || echo "  Not mounted"

  header "Docker Disk Usage"
  docker system df 2>/dev/null || echo "  Docker not available"
}

action_db_status() {
  header "Postgres"
  if docker ps --format '{{.Names}}' | grep -q '^postgres$'; then
    echo "  Connections:"
    dc exec -T postgres psql -U "$PGUSER" -d "$PGDATABASE" -t -c \
      "SELECT count(*) AS total, count(*) FILTER (WHERE state = 'active') AS active, count(*) FILTER (WHERE state = 'idle') AS idle FROM pg_stat_activity;" 2>/dev/null | \
      awk -F'|' '{gsub(/^ +| +$/,"",$1); gsub(/^ +| +$/,"",$2); gsub(/^ +| +$/,"",$3); printf "    Total: %s  Active: %s  Idle: %s\n", $1, $2, $3}'

    echo "  Database sizes:"
    dc exec -T postgres psql -U "$PGUSER" -d "$PGDATABASE" -t -c \
      "SELECT datname, pg_size_pretty(pg_database_size(datname)) AS size FROM pg_database WHERE datistemplate = false ORDER BY pg_database_size(datname) DESC;" 2>/dev/null | \
      while IFS='|' read -r db size; do
        db=$(echo "$db" | xargs)
        size=$(echo "$size" | xargs)
        [[ -n "$db" ]] && printf "    %-25s %s\n" "$db" "$size"
      done
  else
    echo -e "  ${YELLOW}Postgres is not running.${NC}"
  fi

  header "PgBouncer"
  if docker ps --format '{{.Names}}' | grep -q '^pgbouncer$'; then
    echo "  Pool stats:"
    dc exec -T pgbouncer psql -U "$PGUSER" -h localhost -p 5432 -d pgbouncer -t -c \
      "SHOW POOLS;" 2>/dev/null | head -20 || echo "  Could not query PgBouncer stats"
  else
    echo -e "  ${YELLOW}PgBouncer is not running.${NC}"
  fi

  header "MariaDB (nginx-db)"
  if docker ps --format '{{.Names}}' | grep -q '^nginx-db$'; then
    dc exec -T nginx-db mariadb -u root -p"${NPM_MYSQL_ROOT_PASSWORD:-}" -e \
      "SELECT table_schema AS 'Database', ROUND(SUM(data_length + index_length) / 1024 / 1024, 2) AS 'Size (MB)' FROM information_schema.TABLES GROUP BY table_schema;" 2>/dev/null | \
      awk 'NR>1 {printf "    %-25s %s MB\n", $1, $2}' || echo "  Could not query MariaDB"
  else
    echo -e "  ${YELLOW}nginx-db is not running.${NC}"
  fi
}

action_backup_status() {
  header "Last Syncoid Run"
  local synclog="/var/log/media-backup/syncoid.log"
  if [[ -f "$synclog" ]]; then
    echo "  Log: $synclog"
    echo "  Last 5 lines:"
    tail -5 "$synclog" 2>/dev/null | sed 's/^/    /'
  else
    echo "  No syncoid log found."
  fi

  header "Latest Snapshots (per pool)"
  for pool in media-tank music-tank backup-tank; do
    local latest
    latest=$(zfs list -t snapshot -o name,creation -s creation -r "$pool" 2>/dev/null | tail -1)
    if [[ -n "$latest" ]]; then
      printf "  %-15s %s\n" "$pool:" "$latest"
    else
      printf "  %-15s %s\n" "$pool:" "(no snapshots)"
    fi
  done

  header "Snapshot Counts (autosnap / manual / syncoid)"
  for pool in media-tank music-tank backup-tank; do
    local total autosnap manual syncoid
    total=$(zfs list -t snapshot -r "$pool" -H 2>/dev/null | wc -l)
    autosnap=$(zfs list -t snapshot -r "$pool" -H -o name 2>/dev/null | grep -c 'autosnap_' || true)
    syncoid=$(zfs list -t snapshot -r "$pool" -H -o name 2>/dev/null | grep -c 'syncoid' || true)
    manual=$(( total - autosnap - syncoid ))
    printf "  %-15s total: %-5s  autosnap: %-5s  syncoid: %-5s  manual: %s\n" \
      "$pool:" "$total" "$autosnap" "$syncoid" "$manual"
  done

  header "Snapshot Space Usage"
  zfs list -o name,usedbysnapshots -r media-tank music-tank backup-tank 2>/dev/null | \
    awk 'NR==1 || $2 != "0B" {printf "  %-40s %s\n", $1, $2}' || echo "  Could not query"
}

action_network_check() {
  header "Listening Ports (host-bound)"
  docker ps --format '{{.Names}}\t{{.Ports}}' | while IFS=$'\t' read -r name ports; do
    [[ -z "$ports" ]] && continue
    # Highlight anything bound to 0.0.0.0
    if echo "$ports" | grep -q '0\.0\.0\.0'; then
      printf "  ${YELLOW}%-20s${NC} %s\n" "$name" "$ports"
    else
      printf "  ${GREEN}%-20s${NC} %s\n" "$name" "$ports"
    fi
  done

  header "Docker Network"
  docker network inspect "$EXTERNAL_NET" --format '{{range .Containers}}  {{.Name}}: {{.IPv4Address}}{{"\n"}}{{end}}' 2>/dev/null || echo "  Network not found"
}

action_generate_report() {
  local report_script="${SCRIPT_DIR}/generate_report.sh"
  if [[ -x "$report_script" ]]; then
    echo "Generating system report..."
    bash "$report_script"
  else
    echo -e "${YELLOW}generate_report.sh not found or not executable.${NC}"
  fi
}

action_logs_all() {
  echo "Tailing all container logs (Ctrl+C to stop)..."
  dc logs -f --tail=50
}

action_rollback() {
  # Build the candidate list across ALL managed pools, not just media-tank.
  # Snapshots that share a timestamp across pools are grouped so rolling back
  # one is rolling back all — keeping the pools consistent with each other.
  header "Available Pre-Update/Pre-Up Snapshots (all pools)"

  declare -A snap_times   # tag-timestamp -> "pool1 pool2 ..."
  for pool in "${ZFS_POOLS[@]}"; do
    while IFS=$'\t' read -r name _creation; do
      # Strip pool prefix to get the snapshot tag (e.g. pre-up-20260316-182306)
      local tag="${name##*@}"
      snap_times["$tag"]+="$pool "
    done < <(zfs list -H -t snapshot -o name,creation -s creation -r "$pool" 2>/dev/null | \
               grep -E '@(pre-update|pre-up)' | tail -10)
  done

  if [[ ${#snap_times[@]} -eq 0 ]]; then
    echo "  No pre-update or pre-up snapshots found."
    return
  fi

  # Display sorted list
  local -a tags
  mapfile -t tags < <(printf '%s\n' "${!snap_times[@]}" | sort)

  local i=1
  for tag in "${tags[@]}"; do
    printf "  [%2d] %s  (pools: %s)\n" "$i" "$tag" "${snap_times[$tag]}"
    ((i++))
  done
  echo "  [b]  Back"
  echo -n "  Select snapshot to rollback to: "
  read -r snap_choice

  [[ "${snap_choice,,}" == "b" ]] && return

  if ! [[ "$snap_choice" =~ ^[0-9]+$ ]] || (( snap_choice < 1 || snap_choice > ${#tags[@]} )); then
    echo "Invalid selection."; return
  fi

  local selected_tag="${tags[$((snap_choice - 1))]}"
  local affected_pools="${snap_times[$selected_tag]}"

  echo -e "\n${RED}WARNING: This will rollback the following pools to snapshot tag: $selected_tag${NC}"
  echo -e "  Pools: ${affected_pools}"
  echo "This is destructive — all data written after this snapshot will be lost."
  read -r -p "Type 'ROLLBACK' to confirm: " confirm
  if [[ "$confirm" == "ROLLBACK" ]]; then
    echo "Stopping stack..."
    dc down
    for pool in $affected_pools; do
      local snap="${pool}@${selected_tag}"
      echo "Rolling back $snap ..."
      sudo zfs rollback -r "$snap" || { echo -e "${RED}Rollback failed for $snap.${NC}"; return; }
    done
    echo -e "${GREEN}Rollback complete.${NC} Restarting stack..."
    action_up_all
  else
    echo "Aborted."
  fi
}

# ==============================================================================
# TERMINAL UI
# ==============================================================================
gui_menu() {
  while true; do
    clear
    echo -e "${BOLD}================================================================${NC}"
    echo -e " ${BOLD}Media Stack Manager${NC}: $PROJECT_NAME"
    echo -e "${BOLD}================================================================${NC}"
    echo ""
    echo -e " ${BOLD}Stack${NC}                             ${BOLD}Diagnostics${NC}"
    echo " [1] Up   — Start full stack         [h] Health check"
    echo " [2] Down — Stop full stack          [d] Disk & ZFS report"
    echo " [3] Restart full stack              [b] Backup & snapshot status"
    echo " [4] Update (pull + up)              [n] Network & ports"
    echo " [5] Status (show containers)        [l] Tail all logs"
    echo " [6] Live stats (CPU/RAM)            [r] Generate system report"
    echo ""
    echo -e " ${BOLD}Services${NC}                           ${BOLD}Database${NC}"
    echo " [7] Manage single service           [c] Checkpoint Postgres"
    echo " [8] Prune system (cleanup)          [p] Postgres shell (psql)"
    echo " [9] Validate config                 [s] DB status & sizes"
    echo ""
    echo -e " ${BOLD}Recovery${NC}"
    echo " [R] Rollback to snapshot"
    echo " [P] Prune manual snapshots now"
    echo ""
    echo " [0] Exit"
    echo -e "${BOLD}================================================================${NC}"
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
      9) dc config -q && echo -e "${GREEN}Config valid.${NC}" ;;
      h) action_health_check ;;
      d) action_disk_report ;;
      b) action_backup_status ;;
      n) action_network_check ;;
      l) action_logs_all ;;
      r) action_generate_report ;;
      c) action_checkpoint ;;
      p) action_pg_shell ;;
      s) action_db_status ;;
      R) action_rollback ;;
      P) prune_manual_snapshots ;;
      0)
        echo "Exiting..."
        break
        ;;
      *) echo "Invalid option." ;;
    esac

    wait_for_keypress
  done

  clear
  return 0
}

gui_manage_single() {
  mapfile -t services < <(dc config --services 2>/dev/null | sort)

  if [[ ${#services[@]} -eq 0 ]]; then
    echo "No services found. Is docker-compose.yml valid?"
    wait_for_keypress
    return
  fi

  echo "--- Service List ---"
  local i=1
  for svc in "${services[@]}"; do
    # Show running status next to each service
    local state
    state=$(docker ps --filter "name=^${svc}$" --format "{{.Status}}" 2>/dev/null | head -1)
    if [[ -n "$state" ]]; then
      printf " [%2d] ${GREEN}%-20s${NC} %s\n" "$i" "$svc" "$state"
    else
      printf " [%2d] ${RED}%-20s${NC} %s\n" "$i" "$svc" "not running"
    fi
    ((i++))
  done
  echo " [b]  Back"
  echo -n " Choice: "
  read -r svc_choice

  [[ "${svc_choice,,}" == "b" ]] && return

  if ! [[ "$svc_choice" =~ ^[0-9]+$ ]]; then
    echo "Invalid input. Please enter a number."; wait_for_keypress; return
  fi

  local idx=$(( svc_choice - 1 ))
  if (( idx < 0 || idx >= ${#services[@]} )); then
    echo "Invalid selection."; wait_for_keypress; return
  fi

  local selected="${services[$idx]}"

  echo "--- $selected ---"
  echo " [1] Logs (tail 200)  [2] Start  [3] Stop  [4] Restart"
  echo " [5] Shell            [6] Inspect (env/mounts/ports)"
  read -r -n 1 act
  echo -e "\n"

  case "$act" in
    1) dc logs -f --tail=200 "$selected" ;;
    2) dc start "$selected" ;;
    3) dc stop "$selected" ;;
    4) dc restart "$selected" ;;
    5) dc exec "$selected" /bin/sh ;;
    6) action_inspect_service "$selected" ;;
    *) echo "Invalid." ;;
  esac

  wait_for_keypress
}

action_inspect_service() {
  local svc="$1"
  local cid
  cid=$(docker ps -q --filter "name=^${svc}$" 2>/dev/null | head -1)

  if [[ -z "$cid" ]]; then
    echo -e "${YELLOW}$svc is not running.${NC}"
    return
  fi

  header "Container: $svc"
  docker inspect "$cid" --format '
  Image:    {{.Config.Image}}
  Created:  {{.Created}}
  Status:   {{.State.Status}}
  PID:      {{.State.Pid}}
  RestartN: {{.RestartCount}}' 2>/dev/null

  header "Port Bindings"
  docker inspect "$cid" --format '{{range $p, $conf := .NetworkSettings.Ports}}  {{$p}} -> {{range $conf}}{{.HostIp}}:{{.HostPort}}{{end}}{{"\n"}}{{end}}' 2>/dev/null

  header "Mounts"
  docker inspect "$cid" --format '{{range .Mounts}}  {{.Type}}: {{.Source}} -> {{.Destination}} ({{.Mode}}){{"\n"}}{{end}}' 2>/dev/null

  header "Resource Limits"
  docker inspect "$cid" --format '  Memory Limit: {{.HostConfig.Memory}}  CPUs: {{.HostConfig.NanoCpus}}' 2>/dev/null
}

# ==============================================================================
# ENTRYPOINT — supports subcommands for scripting
# ==============================================================================
main() {
  local cmd="${1:-gui}"
  cmd="${cmd,,}"
  shift 2>/dev/null || true

  case "$cmd" in
    gui)        gui_menu ;;
    up)         action_up_all ;;
    down)       action_down_all ;;
    update)     action_update ;;
    restart)    action_down_all && action_up_all ;;
    status)     dc ps ;;
    health)     action_health_check ;;
    disk)       action_disk_report ;;
    backup)     action_backup_status ;;
    network)    action_network_check ;;
    db)         action_db_status ;;
    checkpoint) action_checkpoint ;;
    prune)      action_prune ;;
    prune-snaps) prune_manual_snapshots "${1:-}" ;;
    report)     action_generate_report ;;
    logs)       action_logs_all ;;
    validate)   dc config -q && echo "Config valid." ;;
    help)
      echo "Usage: $(basename "$0") [command]"
      echo ""
      echo "Commands:"
      echo "  gui             Interactive TUI (default)"
      echo "  up              Start full stack"
      echo "  down            Stop full stack"
      echo "  restart         Stop + start full stack"
      echo "  update          Pull images + recreate"
      echo "  status          Show containers"
      echo "  health          Health check all containers"
      echo "  disk            ZFS & disk report"
      echo "  backup          Backup & snapshot status"
      echo "  network         Port bindings & Docker network"
      echo "  db              Database status & sizes"
      echo "  checkpoint      Postgres CHECKPOINT"
      echo "  prune           Clean stopped containers/images"
      echo "  prune-snaps [N] Destroy manual snapshots older than N days (default: $MANUAL_SNAP_RETAIN_DAYS)"
      echo "  report          Generate system report"
      echo "  logs            Tail all container logs"
      echo "  validate        Validate compose config"
      echo "  help            Show this help"
      ;;
    *)          gui_menu ;;
  esac
}

main "${@:-}"
exit 0
