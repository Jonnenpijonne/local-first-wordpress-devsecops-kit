#!/usr/bin/env bash
set -euo pipefail

echo "Starting local development stack..."
docker compose up -d

echo
echo "Current containers:"
docker compose ps

echo
echo "WordPress should be available at:"
echo "http://localhost:8080"

echo
echo "Mailpit should be available at:"
echo "http://localhost:8025"
