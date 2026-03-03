#!/usr/bin/env bash
# ==============================================================================
# db-flush.sh — Sanoid Pre-Snapshot Hook
# Purpose: Flushes ONLY the database currently being snapshotted by Sanoid.
# ==============================================================================
set -Eeuo pipefail

# Load .env for credentials directly from /opt
if [[ -f "/opt/.env" ]]; then
  source "/opt/.env"
else
  echo "❌ ERROR: .env not found at /opt/.env" >&2
  exit 1
fi

TARGET="${SANOID_TARGET:-unknown}"

# 1. If Sanoid is snapping Postgres...
if [[ "$TARGET" == *"postgres"* ]]; then
  echo "Sanoid target is $TARGET — Checkpointing Postgres..."
  docker exec postgres \
    psql -U "${MASTER_USER}" -d postgres -c "CHECKPOINT;" || true

# 2. If Sanoid is snapping MySQL/MariaDB...
elif [[ "$TARGET" == *"mysql"* ]]; then
  echo "Sanoid target is $TARGET — Flushing MariaDB..."
  docker exec nginx-db \
    mariadb -u root -p"${NPM_MYSQL_ROOT_PASSWORD}" -e "FLUSH TABLES;" || true

else
  echo "Ignoring target: $TARGET"
fi
