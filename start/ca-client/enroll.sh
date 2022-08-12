./fabric-ca-client enroll -c ./fabric-ca-client-config.yaml -u http://$1:$2@localhost:7054 --mspdir $3 --csr.hosts example.com
