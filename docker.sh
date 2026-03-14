#!/usr/bin/env bash
# docker.sh — Quick Postgres shell access
# Usage: ./docker.sh

# Source the .env file if it exists so we have the right credentials
if [[ -f "/opt/.env" ]]; then
  source "/opt/.env"
fi

# Fallback to 'admin' if MASTER_USER is empty
USER=${MASTER_USER:-admin}

docker exec -it postgres sh -lc "psql -U \"$USER\" -d postgres"
