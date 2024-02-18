#!/bin/bash
# How many new outputs were created by block 123,456?
hash=$(bitcoin-cli getblockhash 123456)
block=$(bitcoin-cli getblock $hash | jq --raw-output '.tx' | tr -d '"' | tr -d '[]' | tr -d ',')

count=0
for tx in ${block[@]}; do
    vouts=$(bitcoin-cli getrawtransaction $tx true | jq --raw-output '.vout[].n')
    for vout in ${vouts[@]}; do
        let count++
    done
done
echo $count
