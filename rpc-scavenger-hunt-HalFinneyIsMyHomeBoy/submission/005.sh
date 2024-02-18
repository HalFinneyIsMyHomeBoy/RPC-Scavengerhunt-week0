# Create a 1-of-4 P2SH multisig address from the public keys in the four inputs of this tx:
#   `37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517`

RPC_USER="user_203"
RPC_PASSWORD="iArdUxJT93G9"
RPC_CONNECT="35.209.148.157"

tx='37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517'
pubKeyArray=($(bitcoin-cli getrawtransaction $tx 'true' | jq '.vin[].txinwitness[1]' | tr ' ' ',' ))
CMD=$(bitcoin-cli -rpcuser=${RPC_USER} -rpcpassword=${RPC_PASSWORD} -rpcwallet="" -rpcconnect=${RPC_CONNECT} createmultisig 1 "[${pubKeyArray[0]},${pubKeyArray[1]}, ${pubKeyArray[2]}, ${pubKeyArray[3]}]") 
echo $CMD | jq '.address' | tr -d '"'
