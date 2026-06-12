#!/usr/bin/env bash
set -euo pipefail

TARGET="${1:-.}"

echo "Scanning for common sensitive configuration patterns in: $TARGET"

grep -RInE \
  "password|secret|token|BEGIN PRIVATE KEY|sk_live|smtp|license|api[_-]?key" \
  "$TARGET" \
  --exclude-dir=.git \
  --exclude-dir=node_modules \
  --exclude-dir=vendor || true

echo
echo "Review all matches manually. False positives are possible."
