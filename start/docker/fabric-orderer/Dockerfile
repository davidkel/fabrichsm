FROM hyperledger/fabric-orderer:2.2.3

# install alpine tools
RUN apk add --update alpine-sdk openssl-dev

# install softhsm
RUN wget https://dist.opendnssec.org/source/softhsm-2.5.0.tar.gz && \
    mkdir $HOME/softhsm && \
    tar -C $HOME/softhsm -xf softhsm-2.5.0.tar.gz && \
    cd $HOME/softhsm/softhsm-2.5.0 && \
    ./configure --disable-gost && \
    make && \
    make install

# Configure a shared softhsm on a shared mount
RUN mkdir -p $HOME/.config/softhsm2 && \
    cp /etc/softhsm2.conf $HOME/.config/softhsm2/softhsm2.conf && \
    sed -i s+var/lib+shared+g $HOME/.config/softhsm2/softhsm2.conf
    

