#!/usr/bin/env bash
set -euo pipefail
RPC_URL="${1:-http://localhost:8545}"
rpc() {
  curl --fail --silent --show-error -H 'Content-Type: application/json' \
    --data "{\"jsonrpc\":\"2.0\",\"method\":\"$1\",\"params\":[],\"id\":1}" "$RPC_URL"
}
echo "RPC endpoint: $RPC_URL"
for method in eth_chainId eth_blockNumber net_peerCount; do
  echo "== $method =="
  rpc "$method"
  echo
done
echo "A successful RPC response alone does not prove consensus health."
echo "Compare block height twice, 10-15 seconds apart, and inspect validator logs."
