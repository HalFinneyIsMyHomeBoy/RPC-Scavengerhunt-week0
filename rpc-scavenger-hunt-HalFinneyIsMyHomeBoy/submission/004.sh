#!/bin/bash
# Using descriptors, compute the 100th taproot address derived from this extended public key:
#   `xpub6Cx5tvq6nACSLJdra1A6WjqTo1SgeUZRFqsX5ysEtVBMwhCCRa4kfgFqaT2o1kwL3esB1PsYr3CUdfRZYfLHJunNWUABKftK2NjHUtzDms2`
descriptor="tr(xpub6Cx5tvq6nACSLJdra1A6WjqTo1SgeUZRFqsX5ysEtVBMwhCCRa4kfgFqaT2o1kwL3esB1PsYr3CUdfRZYfLHJunNWUABKftK2NjHUtzDms2/100)"
#the /100 at the end tells it to get the 100th address. No need for full dev path

descriptorWithChecksum=$(bitcoin-cli getdescriptorinfo $descriptor | jq '.descriptor' | tr -d '"' )
#get the full descriptor with checksum at the end

result=$(bitcoin-cli deriveaddresses $descriptorWithChecksum | jq '.[-1]' | tr -d '"')
#select the only (or first) item from the array and remove the quotes
echo $result