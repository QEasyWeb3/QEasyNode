#!/bin/bash
node_rpc_port=8565
metrics_port=9660

echo -e "kill node \n";
kill -15 `lsof -t -i:$node_rpc_port`

echo -e "update node$node_index bin \n";
cd ./node

if [ ! -d "./data/" ];then
  echo -e "init node data \n";
  ./geth --datadir ./data init genesis.json
fi

echo -e "Starting node$node_index \n";
sleep 5
nohup ./geth --config geth.toml --cache 8192 --networkid 9528 --ipcpath "~/geth.ipc" --txpool.reannouncecheck --metrics --metrics.addr 0.0.0.0 --metrics.port $metrics_port --verbosity 3 2>> ./geth.log &

cd ..
