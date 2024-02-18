# Which public key signed input 0 in this tx:
#   `e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163`
originalTx='e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163'
hex=$(bitcoin-cli getrawtransaction $originalTx 'true' | jq --raw-output '.hex' | tr -d '"' | tr -d '[]' | tr -d ',')

pubKey=$(bitcoin-cli decoderawtransaction $hex | jq -r '.vin[].txinwitness[2]')
pubKey=${pubKey::-84} #remove the last 84 characters
echo ${pubKey:4} # remove the first 4 characters which are IF operators according to BIP144