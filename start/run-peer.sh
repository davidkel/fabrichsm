docker run -it --rm
    -v $PWD/start/peer:/etc/hyperledger/fabric \
	-v $PWD/start/hsm/shared:/shared \
	-v /var/run/docker.sock:/host/var/run/docker.sock \
	-e "CORE_PEER_ID=peer.example.com" \
        -e "CORE_PEER_ADDRESS=peer.example.com:7051" \
	-e "CORE_PEER_LISTENADDRESS=0.0.0.0:7051" \
	-e "CORE_PEER_CHAINCODE_ADDRESS=peer.example.com:7052" \
	-e "CORE_PEER_CHAINCODELISTENADDRESS=0.0.0.0:7052" \
	-e "CORE_PEER_GOSSIP_BOOTSTRAP=peer.example.com" \
	-e "CORE_PEER_GOSSIP_EXTERNALENDPOINT=peer.example.com" \
	-e "CORE_PEER_LOCALMSPID=Org1MSP" \
	-e "CORE_VM_DOCKER_HOSTCONFIG_NETWORKMODE=bridge" \
	-e "CORE_VM_ENDPOINT=unix:///host/var/run/docker.sock" \
	-p 7051:7051 \
	peerhsm:2.2.3 /bin/sh
