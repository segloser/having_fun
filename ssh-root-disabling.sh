#!/bin/bash

echo "Disabling PermitRootLogin yes and PasswordAuthentication yes"

sed -i 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config
sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config

# Some checkings
if [[ $(cat /etc/ssh/sshd_config | grep "PermitRootLogin yes") == "" ]] && [[ $(cat /etc/ssh/sshd_config | grep "PermitRootLogin no" | grep -v \#) == "PermitRootLogin no" ]]; then
	echo "PermitRootLogin no -> Correctly set"
else
	echo "Check manually. Something wrong happened"
fi

if [[ $(cat /etc/ssh/sshd_config | grep "PasswordAuthentication yes") == "" ]] && [[ $(cat /etc/ssh/sshd_config | grep "PasswordAuthentication no" | grep -v \#) == "PasswordAuthentication no" ]]; then
        echo "PasswordAuthentication no -> Correctly set"
else
        echo "Check manually. Something wrong happened"
fi

echo "Restarting ssh service"
service ssh restart
