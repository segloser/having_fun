#!/bin/bash

apt-get update
apt install python
wget -q https://packages.microsoft.com/config/ubuntu/16.04/packages-microsoft-prod.deb
dpkg -i packages-microsoft-prod.deb
apt-get update
apt-get install -y powershell
cd /opt
git clone https://github.com/EmpireProject/Empire.git
cd /opt/Empire/setup
./install.sh
