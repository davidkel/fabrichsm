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
