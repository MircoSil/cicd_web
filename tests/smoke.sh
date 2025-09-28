#!/usr/bin/env bash
set -euo pipefail
IMAGE="$1"        # z.B. ghcr.io/owner/repo:commitsha
PORT=18080

cid=$(docker run -d -p ${PORT}:80 --rm "${IMAGE}")
cleanup() { docker rm -f "$cid" >/dev/null 2>&1 || true; }
trap cleanup EXIT

# Warten bis Nginx antwortet
for i in {1..30}; do
  if curl -fsS "http://localhost:${PORT}" | grep -q "It works"; then
    echo "Smoke test OK"
    exit 0
  fi
  sleep 1
done

echo "Smoke test FAILED"
exit 1
