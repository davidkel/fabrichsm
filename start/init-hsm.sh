#mkdir -p $HOME/.config/softhsm2
#cp /etc/softhsm2.conf $HOME/.config/softhsm2/softhsm2.conf
#sed -i s+var/lib+/home/ubuntu/start/hsm/shared+g $HOME/.config/softhsm2/softhsm2.conf

HSM_SHARED=~/start/hsm/shared
rm -fr $HSM_SHARED
mkdir -p $HSM_SHARED/softhsm/tokens
chmod 777  $HSM_SHARED
chmod 777 $HSM_SHARED/softhsm/tokens
softhsm2-util --init-token --slot 0 --label "ForFabric" --so-pin 1234 --pin 98765432
