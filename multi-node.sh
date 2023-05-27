#!/bin/bash

rm -rf data/node0
rm -rf data/node1
rm -rf data/node2

sequencerd init node0 --chain-id testnet_9000-1 --home data/node0
sequencerd init node1 --chain-id testnet_9000-1 --home data/node1
sequencerd init node2 --chain-id testnet_9000-1 --home data/node2

sequencerd keys add dev0
sequencerd keys add dev1
sequencerd keys add dev2

# Change parameter token denominations to aseq
cat data/node0/config/genesis.json | jq '.app_state["evm"]["params"]["evm_denom"]="aseq"' > data/node0/config/tmp_genesis.json && mv data/node0/config/tmp_genesis.json data/node0/config/genesis.json
cat data/node0/config/genesis.json | jq '.app_state["staking"]["params"]["bond_denom"]="aseq"' > data/node0/config/tmp_genesis.json && mv data/node0/config/tmp_genesis.json data/node0/config/genesis.json
cat data/node0/config/genesis.json | jq '.app_state["crisis"]["constant_fee"]["denom"]="aseq"' > data/node0/config/tmp_genesis.json && mv data/node0/config/tmp_genesis.json data/node0/config/genesis.json
cat data/node0/config/genesis.json | jq '.app_state["gov"]["deposit_params"]["min_deposit"][0]["denom"]="aseq"' > data/node0/config/tmp_genesis.json && mv data/node0/config/tmp_genesis.json data/node0/config/genesis.json
cat data/node0/config/genesis.json | jq '.app_state["inflation"]["params"]["mint_denom"]="aseq"' > data/node0/config/tmp_genesis.json && mv data/node0/config/tmp_genesis.json data/node0/config/genesis.json

cat data/node1/config/genesis.json | jq '.app_state["evm"]["params"]["evm_denom"]="aseq"' > data/node1/config/tmp_genesis.json && mv data/node1/config/tmp_genesis.json data/node1/config/genesis.json
cat data/node1/config/genesis.json | jq '.app_state["staking"]["params"]["bond_denom"]="aseq"' > data/node1/config/tmp_genesis.json && mv data/node1/config/tmp_genesis.json data/node1/config/genesis.json
cat data/node1/config/genesis.json | jq '.app_state["crisis"]["constant_fee"]["denom"]="aseq"' > data/node1/config/tmp_genesis.json && mv data/node1/config/tmp_genesis.json data/node1/config/genesis.json
cat data/node1/config/genesis.json | jq '.app_state["gov"]["deposit_params"]["min_deposit"][0]["denom"]="aseq"' > data/node1/config/tmp_genesis.json && mv data/node1/config/tmp_genesis.json data/node1/config/genesis.json
cat data/node1/config/genesis.json | jq '.app_state["inflation"]["params"]["mint_denom"]="aseq"' > data/node1/config/tmp_genesis.json && mv data/node1/config/tmp_genesis.json data/node1/config/genesis.json

cat data/node2/config/genesis.json | jq '.app_state["evm"]["params"]["evm_denom"]="aseq"' > data/node2/config/tmp_genesis.json && mv data/node2/config/tmp_genesis.json data/node2/config/genesis.json
cat data/node2/config/genesis.json | jq '.app_state["staking"]["params"]["bond_denom"]="aseq"' > data/node2/config/tmp_genesis.json && mv data/node2/config/tmp_genesis.json data/node2/config/genesis.json
cat data/node2/config/genesis.json | jq '.app_state["crisis"]["constant_fee"]["denom"]="aseq"' > data/node2/config/tmp_genesis.json && mv data/node2/config/tmp_genesis.json data/node2/config/genesis.json
cat data/node2/config/genesis.json | jq '.app_state["gov"]["deposit_params"]["min_deposit"][0]["denom"]="aseq"' > data/node2/config/tmp_genesis.json && mv data/node2/config/tmp_genesis.json data/node2/config/genesis.json
cat data/node2/config/genesis.json | jq '.app_state["inflation"]["params"]["mint_denom"]="aseq"' > data/node2/config/tmp_genesis.json && mv data/node2/config/tmp_genesis.json data/node2/config/genesis.json



#sequencerd add-genesis-account evmos1muejcvu6m8ntsl3a4lmjukg0wdlm8ewd6d5res 10000000000000000000000000000aseq --home data/node0
#sequencerd add-genesis-account evmos127sdadcyzemwa0rtdde65hqksnmwmmrp0dkgcl 10000000000000000000000000000aseq --home data/node0
#sequencerd add-genesis-account evmos1x9kfp967y749w34tjrdkgvszyr296e5e0r6e73 100000000000000000000000000aseq --home data/node0


sequencerd add-genesis-account dev0 100000000000000000000aseq --home data/node0
sequencerd add-genesis-account dev1 100000000000000000000aseq --home data/node1
sequencerd add-genesis-account dev2 100000000000000000000aseq --home data/node2


sequencerd gentx  dev0 100000000000000000000aseq --home data/node0  --node-id $(sequencerd tendermint show-node-id --home data/node0) --chain-id testnet_9000-1
sequencerd gentx  dev1  100000000000000000000aseq --home data/node1  --node-id $(sequencerd tendermint show-node-id --home data/node1) --chain-id testnet_9000-1
sequencerd gentx  dev2 100000000000000000000aseq --home data/node2  --node-id $(sequencerd tendermint show-node-id --home data/node2) --chain-id testnet_9000-1



sequencerd collect-gentxs --home data/node0
sequencerd collect-gentxs --home data/node1
sequencerd collect-gentxs --home data/node2


#TRACE=""
#
## Start the node (remove the --pruning=nothing flag if historical queries are not needed)
#sequencerd start --metrics "$TRACE" --log_level="info" --minimum-gas-prices=0.0001aseq --json-rpc.api eth,txpool,personal,net,debug,web3 --api.enable --home data/node0
#sequencerd start --metrics "$TRACE" --log_level="info" --minimum-gas-prices=0.0001aseq --json-rpc.api eth,txpool,personal,net,debug,web3 --api.enable --home data/node1
#sequencerd start --metrics "$TRACE" --log_level="info" --minimum-gas-prices=0.0001aseq --json-rpc.api eth,txpool,personal,net,debug,web3 --api.enable --home data/node2