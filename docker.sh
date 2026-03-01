#!/usr/bin/env bash
# docker.sh — Quick Postgres shell access
# Usage: ./docker.sh
docker exec -it opt-postgres-1 sh -lc 'psql -U "$POSTGRES_USER" -d postgres'
