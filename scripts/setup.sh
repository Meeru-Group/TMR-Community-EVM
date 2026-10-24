#!/usr/bin/env bash
set -euo pipefail
command -v npx >/dev/null 2>&1 || { echo "ERROR: Node.js/npm (npx) required."; exit 1; }
command -v docker >/dev/null 2>&1 || { echo "ERROR: Docker required."; exit 1; }
docker compose version >/dev/null 2>&1 || { echo "ERROR: Docker Compose v2 required."; exit 1; }
[ ! -e ./besu-test-network ] || { echo "ERROR: ./besu-test-network already exists; refusing to overwrite it."; exit 1; }
echo "Generating an official Besu private QBFT development network."
echo "This is a LOCAL TEST network, not the existing TMR chain (reported chain ID 1327)."
npx @consensys-software/besu-dev-quickstart --networkType private --outputPath ./besu-test-network --otel false --chainlens false
echo "Generated ./besu-test-network. Read its README before starting."
echo "Common next step: cd besu-test-network && ./run.sh"
