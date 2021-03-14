#!/bin/bash

git checkout etc/casper/1_0_0/config.toml
git pull

TRUSTED_NODE=167.86.77.252
TRUSTED_HASH=$(curl -s http://$TRUSTED_NODE:8888/status | jq -r '.last_added_block_info | .hash')

echo "trusted hash is $TRUSTED_HASH\n"

crudini --set etc/casper/1_0_0/config.toml "network" "public_address" "'$(dig @ns1-1.akamaitech.net ANY whoami.akamai.net +short):35000'"

if [ -z "$TRUSTED_HASH" ]
then
	crudini --del etc/casper/1_0_0/config.toml "node" "trusted_hash"
else
	crudini --set etc/casper/1_0_0/config.toml "node" "trusted_hash" "'${TRUSTED_HASH}'"    
fi

docker-compose up -d --build --force-recreate
