#!/bin/bash

echo "Disabling PermitRootLogin yes and PasswordAuthentication yes"

sed -i 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config
sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config

echo "Restarting ssh service"
service ssh restart
