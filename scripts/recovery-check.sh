#!/usr/bin/env bash
set -euo pipefail
command -v docker >/dev/null 2>&1 || { echo "ERROR: Docker required."; exit 1; }
NETWORK_DIR="${1:-./besu-test-network}"
[ -d "$NETWORK_DIR" ] || { echo "ERROR: directory not found: $NETWORK_DIR"; exit 1; }
echo "== Docker containers =="
docker ps -a --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}' || true
echo
echo "== Compose services =="
(cd "$NETWORK_DIR" && docker compose ps) || true
echo
echo "== Recent logs =="
(cd "$NETWORK_DIR" && docker compose logs --tail=80) || true
echo
echo "Read-only check completed. It does not delete volumes or reset chain data."
echo "Do not run 'docker compose down -v', delete data folders, or regenerate validator keys as routine recovery."
