#!/bin/bash
# Which tx in block 257,343 spends the coinbase output of block 256,128?
hash=$(bitcoin-cli getblockhash 256128)
coinbaseTx=$(bitcoin-cli getblock $hash | jq --raw-output '.tx[0]' || tr -d '"')

hash=$(bitcoin-cli getblockhash 257343)
txArray=($(bitcoin-cli getblock $hash | jq --raw-output '.tx' | tr -d '"' | tr -d '[]' | tr -d ','))

for tx in ${txArray[@]}; do
    txsinblock=($(bitcoin-cli getrawtransaction $tx 'true' | jq --raw-output '.vin[].txid' | tr -d '"' | tr -d '[]' | tr -d ','))

    for txid in ${txsinblock[@]}; do
        if [[ "$txid" = "$coinbaseTx" ]] 
        then 
            echo $tx  # Found the tx that has the coinbase txid for the vin !!!
        fi     
    done

done

