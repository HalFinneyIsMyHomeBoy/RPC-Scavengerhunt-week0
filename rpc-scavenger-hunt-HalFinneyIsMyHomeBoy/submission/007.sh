# Only one single output remains unspent from block 123,321. What address was it sent to?
hash=$(bitcoin-cli getblockhash 123321)
block=($(bitcoin-cli getblock $hash | jq --raw-output '.tx' | tr -d '"' | tr -d '[]' | tr -d ','))

for tx in ${block[@]}; do

    result=$(bitcoin-cli gettxout $tx '0')
    if [ ! -z "$result"  ] 
    then
        echo $result | jq -r '.scriptPubKey.address'
    fi
done