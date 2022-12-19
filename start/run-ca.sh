# docker run -it --rm -v ~/start/ca:/etc/hyperledger/fabric-ca-server -v ~/start/hsm/shared:/shared ca:1.5 /bin/sh

docker run -d \
--name DaveCA \
-v $PWD/start/ca:/etc/hyperledger/fabric-ca-server \
-v $PWD/start/hsm/shared:/shared \
-e FABRIC_CA_SERVER_CA_NAME=DaveCA \
-e FABRIC_CA_SERVER_TLS_ENABLED=false \
-e FABRIC_CA_SERVER_PORT=7054 \
-p 7054:7054 \
cahsm:1.5 \
sh -c 'fabric-ca-server start -b admin:adminpw -d'
