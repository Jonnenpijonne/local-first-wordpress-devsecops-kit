#!/usr/bin/env bash
set -euo pipefail

echo "WARNING: this will remove local containers and volumes."
echo "Local database data will be deleted."
read -r -p "Type RESET to continue: " confirm

if [[ "$confirm" != "RESET" ]]; then
  echo "Aborted."
  exit 1
fi

docker compose down -v
docker compose up -d --build
docker compose ps
