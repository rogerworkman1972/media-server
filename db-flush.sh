#!/usr/bin/env bash
# ==============================================================================
# db-flush.sh — Sanoid Pre-Snapshot Hook
# ==============================================================================
set -Eeuo pipefail

ENV_FILE="/opt/.env"

# Load .env for credentials securely
if [[ -f "$ENV_FILE" ]]; then
  set -a; source "$ENV_FILE"; set +a
else
  echo "❌ ERROR: .env not found at $ENV_FILE" >&2
  exit 1
fi

TARGET="${SANOID_TARGET:-unknown}"

is_running() {
  [[ "$(docker inspect -f '{{.State.Running}}' "$1" 2>/dev/null)" == "true" ]]
}

# 1. If Sanoid is snapping Postgres...
if [[ "$TARGET" == *"postgres"* ]]; then
  echo "Sanoid target is $TARGET — Checkpointing Postgres..."
  if is_running "postgres"; then
    docker exec postgres \
      psql -U "${MASTER_USER:-admin}" -d postgres -c "CHECKPOINT;" || echo "⚠️ Postgres checkpoint failed."
  else
    echo "⚠️ Postgres container is not running. Skipping."
  fi

# 2. If Sanoid is snapping MySQL/MariaDB...
elif [[ "$TARGET" == *"mysql"* ]]; then
  echo "Sanoid target is $TARGET — Flushing MariaDB..."
  if is_running "nginx-db"; then
    # Added 30s timeout to prevent Sanoid from hanging/crashing
    if timeout 30s docker exec nginx-db \
      mariadb -u root -p"${NPM_MYSQL_ROOT_PASSWORD}" -e "FLUSH TABLES;"; then
      echo "✅ MariaDB flush successful."
    else
      echo "⚠️ MariaDB flush timed out or failed."
    fi
  else
    echo "⚠️ nginx-db container is not running. Skipping."
  fi

else
  echo "Ignoring target: $TARGET"
fi
