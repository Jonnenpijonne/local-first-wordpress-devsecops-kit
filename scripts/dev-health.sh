#!/usr/bin/env bash
set -euo pipefail

echo "Docker Compose version:"
docker compose version

echo
echo "Container status:"
docker compose ps

echo
echo "Database health:"
docker compose exec db mariadb-admin ping -h localhost -uroot -p"${MYSQL_ROOT_PASSWORD:-root}" || true

echo
echo "Recent logs:"
docker compose logs --tail=50
