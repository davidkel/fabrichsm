# Simple Fabric using softHSM

You will need to start by building fabric 2.2.3 images from source setting GO_TAGS=pkcs11
The docker images here will then use the locally built images to add softhsm into them

In Fabric Repo
git checkout v2.2.3
make docker-clean
GO_TAGS=pkcs11 make docker

Fabric CA 1.5.0 docker image appears to be pkcs11 enabled by default



cd start
docker build -f docker/fabric-peer/Dockerfile -t peerhsm:2.2.3 .
docker build -f docker/fabric-orderer/Dockerfile -t ordererhsm:2.2.3 .
docker build -f docker/fabric-ca/Dockerfile -t cahsm:1.5.0 .

need to have a version of softhsm locally as well.


I think I need to revise this as it isn't in a great state and needs more setup capability like creating a channel, deploying chaincode and an application to test it.

## What it requires to stand up a fabric network

This describes what is needed for a simple network that would be HSM enabled (and TLS, could use solo orderer and no TLS)
Single orderer only otherwise we need at least 3

1. HSM Enabled CA (use http rather than https to avoid some complications ?) for each Org (Peer Orgs and Orderer Org) with a registrar identity enrolled
2. Non HSM Enabled CA for TLS Certificates with a registrar identity enrolled
3. Generate HSM managed Local MSP Identity using the CA for each Peer and Orderer (OU=peer, orderer)
4. Generate a TLS Certificate NON HSM MANGED Using the TLS CA for each Peer and Orderer
5. provide an appropriate core.yaml for each peer (ensure PKCS11 is enabled in BCCSP)
6. provide an appropriate orderer.yaml for each orderer (ensure PKCS11 is enabled in BCCSP)
7. enable OU support by adding a config.yaml to each Local MSP Identity folder (if not already there)
8. create Public (Channel) MSPs for each of the orgs (TLS CA Certs, CA Certs. There are no revoked or intermediate CAs) - copy of Local MSP but remove all keys and all signing identities
9. create a channel genesis block (for use with the new channel participation mechanism)
10. create an Admin (OU=admin) for each org including the orderer org which are HSM Managed
11. create a NON HSM Managed TLS identity for the Admin using the orderer org TLS Server
12. submit that channel genesis block to an orderer using osnadmin (which will join that orderer to the channel) using the orderer Admin TLS identity for mutual TLS
13. join the peers to the channel using peer channel join (setGlobals to org of peer)
14. define an anchor peer for each org (only needs to be signed by the admin of each org) but requires a special script as it isn't a simple operation - whoever submits this update automatically signs it (peer channel update) so no extra signatures required.
15. deploy chaincode - this is again a complex operation requiring
  - packaging of chaincode using peer lifecycle chaincode package
  - installing chaincode using peer lifecycle chaincode install (setglobals to target individual peers) - can use queryinstalled to check first
  - approve a definition for each org (setglobals) (the definition must be identical, also need package-id from above but it is optional apparently) peer lifecycle chaincode approveformyorg
  - commit the chaincode definition on just 1 org (setglobals) (the definition must be identical) peer lifecycle chaincode commit
1.  channel update (this update needs to be signed usually by a majority of the peer orgs)


Question where would we require orderer admin signatures ? The could be part of the majority policy



setglobals
CORE_PEER_LOCALMSPID=Org MSPID
CORE_PEER_TLS_ROOTCERT_FILE=Org TLS CA
CORE_PEER_MSPCONFIGPATH=Org Admin MSP
CORE_PEER_ADDRESS=Peer Address
CORE_PEER_TLS_ENABLED=true

(only for mutualTLS, heaven forbid....)
CORE_PEER_TLS_CERT_FILE
CORE_PEER_TLS_KEY_FILE


what is a chaincode definition ?
- sequence number
- collection config
- endorsement policy
- chaincode name
- chaincode version
- whether it requires init to be called