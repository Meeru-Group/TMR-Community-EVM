# Community Deployment Plan

## Stage 1 — Local lab
Generate the official Besu Developer Quickstart network. Multiple validators on one computer are only a demo.

## Stage 2 — Independent operators
Recruit at least four independent operators for a QBFT testnet. Each needs a supported always-on device, stable internet, persistent storage, a unique validator identity, secure key handling, and a recovery plan. Multiple containers on one host do not count as independent failure domains.

## Stage 3 — Peer connectivity
Configure multiple peers/bootnodes so discovery is not dependent on one host. Bootnodes help nodes find peers; they do not create blocks unless separately configured as validators.

## Stage 4 — RPC resilience
Provide multiple RPC endpoints run by different operators. Verify that endpoints serve the same chain ID/genesis before wallet failover. Never submit transactions to an endpoint merely because it responds.

## Stage 5 — Recovery drill
1. Stop one validator and check whether the chain continues.
2. Stop enough validators to remove quorum and verify the chain stalls.
3. Restore original validators with persistent data.
4. Verify peers reconnect and block production resumes.
5. Compare block hashes and transaction receipts across nodes.

## Honest uptime statement
Do not promise 100% uptime. If every validator is offline, new blocks cannot be committed. Say: “The network is designed to resume automatically when enough healthy validators return with consistent state and valid keys; recovery time depends on connectivity, sync time, and consensus health.”
