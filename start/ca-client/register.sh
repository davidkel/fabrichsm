./fabric-ca-client register -c ./fabric-ca-client-config.yaml --mspdir caadmin --id.name $1 --id.secret $2 --id.type $3 --caname DaveCA -H ~/start/ca-client -m example.com -u http://localhost:7054
