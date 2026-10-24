# Recovery Runbook

## Expected behavior
- If enough validators are healthy and connected, block production can continue.
- If too many validators are offline, QBFT can stall. The wallet should show `CHAIN PAUSED`/unavailable, not claim a transaction is confirmed.
- On return, nodes should reconnect, sync, and resume only when consensus safety conditions are met.
- Recovery cannot be guaranteed if all data is lost, keys are lost, state is corrupted, or validators disagree on history.

## Before restart
1. Record last block number and timestamp.
2. Save logs and exact RPC error.
3. Check original data directories and validator keys still exist.
4. Confirm chain ID and genesis configuration match across nodes.
5. Check clocks and peer connectivity.
6. Never copy one validator key to multiple operators.
7. Never delete node data, regenerate keys, or edit genesis to fix a stall.

## Restart
1. Ask operators to restart their original nodes using the client's normal procedure.
2. Inspect logs for genesis mismatch, database corruption, peer discovery, and quorum errors.
3. Allow peers to reconnect and synchronize.
4. Query `eth_chainId`, `eth_blockNumber`, and `net_peerCount` from independent RPC endpoints if possible.
5. Compare block heights 10–15 seconds apart. If height does not advance, investigate quorum/logs; do not repeatedly restart all validators at once.
6. Send only a small test transaction after block production and receipts are verified.

## Transaction diagnosis
A standard EVM hash is `0x` plus 64 hexadecimal characters. A UUID shown by a custom wallet is not proof that an EVM transaction was broadcast. If `eth_sendRawTransaction` returns a valid hash, query `eth_getTransactionReceipt` against the same chain and another endpoint if available. A null receipt can mean pending, unknown to that endpoint, or a chain/RPC mismatch; it does not alone prove failure.
