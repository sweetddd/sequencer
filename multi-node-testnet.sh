#!/bin/bash

rm -rf data/testnet/zkevm-sequencer-0
rm -rf data/testnet/zkevm-sequencer-1
rm -rf data/testnet/zkevm-sequencer-2

sequencerd init node0 --chain-id testnet_8999-1 --home data/testnet/zkevm-sequencer-0
sequencerd init node1 --chain-id testnet_8999-1 --home data/testnet/zkevm-sequencer-1
sequencerd init node2 --chain-id testnet_8999-1 --home data/testnet/zkevm-sequencer-2



jq '.app_state["staking"]["params"]["bond_denom"]="aseq"' data/testnet/zkevm-sequencer-0/config/genesis.json >data/testnet/zkevm-sequencer-0/config/tmp_genesis.json && mv data/testnet/zkevm-sequencer-0/config/tmp_genesis.json data/testnet/zkevm-sequencer-0/config/genesis.json
jq '.app_state["crisis"]["constant_fee"]["denom"]="aseq"' data/testnet/zkevm-sequencer-0/config/genesis.json >data/testnet/zkevm-sequencer-0/config/tmp_genesis.json && mv data/testnet/zkevm-sequencer-0/config/tmp_genesis.json data/testnet/zkevm-sequencer-0/config/genesis.json
jq '.app_state["gov"]["deposit_params"]["min_deposit"][0]["denom"]="aseq"' data/testnet/zkevm-sequencer-0/config/genesis.json >data/testnet/zkevm-sequencer-0/config/tmp_genesis.json && mv data/testnet/zkevm-sequencer-0/config/tmp_genesis.json data/testnet/zkevm-sequencer-0/config/genesis.json
jq '.app_state["evm"]["params"]["evm_denom"]="aseq"' data/testnet/zkevm-sequencer-0/config/genesis.json >data/testnet/zkevm-sequencer-0/config/tmp_genesis.json && mv data/testnet/zkevm-sequencer-0/config/tmp_genesis.json data/testnet/zkevm-sequencer-0/config/genesis.json
jq '.app_state["inflation"]["params"]["mint_denom"]="aseq"' data/testnet/zkevm-sequencer-0/config/genesis.json >data/testnet/zkevm-sequencer-0/config/tmp_genesis.json && mv data/testnet/zkevm-sequencer-0/config/tmp_genesis.json data/testnet/zkevm-sequencer-0/config/genesis.json


sequencerd add-genesis-account testnet0 100000000000000000000000000aseq --keyring-backend os --home data/testnet/zkevm-sequencer-0
sequencerd add-genesis-account testnet1 100000000000000000000000000aseq --keyring-backend os --home data/testnet/zkevm-sequencer-0
sequencerd add-genesis-account testnet2 100000000000000000000000000aseq --keyring-backend os --home data/testnet/zkevm-sequencer-0
sequencerd add-genesis-account testnet1 100000000000000000000000000aseq --keyring-backend os --home data/testnet/zkevm-sequencer-1
sequencerd add-genesis-account testnet2 100000000000000000000000000aseq --keyring-backend os --home data/testnet/zkevm-sequencer-2


sequencerd gentx  testnet0 1000000000000000000000aseq --home data/testnet/zkevm-sequencer-0  --keyring-backend os --chain-id testnet_9000-1
sequencerd gentx  testnet1 1000000000000000000000aseq --home data/testnet/zkevm-sequencer-1  --keyring-backend os --chain-id testnet_9000-1
sequencerd gentx  testnet2 1000000000000000000000aseq --home data/testnet/zkevm-sequencer-2  --keyring-backend os --chain-id testnet_9000-1



sequencerd collect-gentxs --home data/testnet/zkevm-sequencer-0
sequencerd collect-gentxs --home data/testnet/zkevm-sequencer-1
sequencerd collect-gentxs --home data/testnet/zkevm-sequencer-2


#TRACE=""
#
## Start the node (remove the --pruning=nothing flag if historical queries are not needed)
#sequencerd start --metrics "$TRACE" --log_level="info" --minimum-gas-prices=0.0001aseq --json-rpc.api eth,txpool,personal,net,debug,web3 --api.enable --home data/testnet/zkevm-sequencer-0
#sequencerd start --metrics "$TRACE" --log_level="info" --minimum-gas-prices=0.0001aseq --json-rpc.api eth,txpool,personal,net,debug,web3 --api.enable --home data/testnet/zkevm-sequencer-1
#sequencerd start --metrics "$TRACE" --log_level="info" --minimum-gas-prices=0.0001aseq --json-rpc.api eth,txpool,personal,net,debug,web3 --api.enable --home data/testnet/zkevm-sequencer-2