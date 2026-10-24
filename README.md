# TMR Community EVM — Recovery Starter Kit

**Status:** development/testnet starter kit. It is not production-ready and is not connected to your existing TMR EVM chain.

This kit generates a local Hyperledger Besu QBFT demo network and includes RPC health/recovery checks. It does not create a blockchain with zero nodes; validators must run somewhere.

## Contents
- `scripts/setup.sh` — generate a Besu QBFT private development network.
- `scripts/health-check.sh` — check `eth_chainId`, `eth_blockNumber`, `net_peerCount`.
- `scripts/recovery-check.sh` — inspect containers/logs without deleting chain data.
- `docs/RECOVERY-RUNBOOK.md` — safe restart/recovery steps.
- `docs/COMMUNITY-DEPLOYMENT.md` — independent community node plan.

## Requirements
Computer/server with Docker Engine + Docker Compose v2, Node.js/npm (`npx`), `curl`, and enough RAM. Besu's official quickstart recommends allowing Docker around 6 GB RAM.

## Quick start
```bash
unzip TMR-Community-EVM-Starter.zip
cd TMR-Community-EVM-Starter
chmod +x scripts/*.sh
./scripts/setup.sh
```
When generation completes, follow the generated directory's README. Common next command:
```bash
cd besu-test-network
./run.sh
```
Then run the health check from the starter-kit folder:
```bash
./scripts/health-check.sh http://localhost:8545
```
Use the endpoint printed by the generated network if different.

## Critical limitations
1. This is a local demo network, not your existing TMR EVM chain (reported chain ID 1327). Do not edit genesis or chain ID after nodes start and assume it remains the same chain.
2. Multiple validators on one computer are not independent or decentralized failure domains.
3. QBFT requires a supermajority; if more than one-third of validators stop participating, block production can stall.
4. Never commit validator private keys, seed phrases, RPC passwords, or API tokens to GitHub.
5. Do not use for real funds. Production requires security review and operational testing.

Android-only note: this is source/configuration, not an APK. Running several Besu nodes directly on a phone is not recommended. Community operators can run nodes on supported computers.

## Existing TMR EVM diagnosis
Collect the actual public RPC URL (redact credentials), `eth_chainId`, `eth_blockNumber`, client/version, consensus type, validator count, and genesis configuration hash. A UUID-style wallet request ID is not a standard EVM transaction hash. Do not retry a failed send until broadcast status is checked.
