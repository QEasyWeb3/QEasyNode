#!/bin/bash
node_rpc_port=8545
metrics_port=9660
personal_import_key="80ee817f7915ab08723277d8cba438009b642bf7e7fb7f67521919e6e22952bd"
personal_address="0xd502b3B6B5D11C8E174FC21F7A2A0C980fEff930"
password="@ujPj4!%vE6rVHH1"
echo -e "kill node \n";
kill -15 `lsof -t -i:$node_rpc_port`

echo -e "update node$node_index bin \n";
cd ./node

if [ ! -d "./data/" ];then
  echo -e "init node data \n";
  ./geth --datadir ./data init genesis.json
  echo $password > ./.password
  echo $personal_import_key  > ./.privatekey
  ./geth --config ./geth_bp.toml account import --password ./.password ./.privatekey
  rm -rf ./.privatekey
fi

echo -e "Starting node$node_index \n";
sleep 5
nohup ./geth --config geth_bp.toml --mine --nodekeyhex $nodekeyhex --unlock $personal_address --cache 8192 --networkid 9528 --password ./.password --metrics --metrics.addr 0.0.0.0 --metrics.port $metrics_port --verbosity 3 2>> ./geth.log &

cd ..
