#!/bin/bash
# This scrips assumes you have a user named cuckoo
clear
read -p "Press ENTER to install ssh"
sudo apt install ssh

read -p "Press ENTER to update and upgrade the system"
sudo apt update -y
sudo apt upgrade -y
echo
read -p "Pres ENTER to install some needed software. This will take a while"
echo
sudo apt install git python python-dev python-pip python-m2crypto libmagic1 swig libvirt-dev upx-ucl libssl-dev wget unzip p7zip-full geoip-database libgeoip-dev libjpeg-dev mono-utils ssdeep libfuzzy-dev exiftool curl openjdk-11-jre-headless xfce4 xfce4-goodies postgresql postgresql-contrib libpq-dev wkhtmltopdf xvfb xfonts-100dpi tcpdump libcap2-bin clamav clamav-daemon clamav-freshclam python-pil suricata libboost-all-dev qemu-kvm libvirt-clients libvirt-daemon virt-manager htop tmux gdebi-core tor privoxy libssl-dev libjansson-dev libmagic-dev automake apparmor-utils libvirt-bin ubuntu-vm-builder libguac-client-rdp0 libguac-client-vnc0 libguac-client-ssh0 guacd -y
echo
read -p "Press ENTER to add Mongo sources and key to your system"
echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb.list
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4
echo
read -p "New sources, new update... Press ENTER to execute it"
sudo apt update
echo
read -p "Press ENTER to install mongodb-org"
sudo apt install mongodb-org
echo
echo -e "Press ENTER to install the following"
echo -e "===================================="
read -e "psycopg2 \ndistorm3 \npycrypto \nopenpyxl \npydeep \nvolatility \npyopenssl"
sudo -H pip install psycopg2 distorm3 pycrypto openpyxl
sudo -H pip install git+https://github.com/kbandla/pydeep.git
sudo -H pip install git+https://github.com/volatilityfoundation/volatility.git
sudo -H pip install pyopenssl -U
echo
read -p "Press ENTER to add the current user to kvm and libvirt groups"
sudo usermod -a -G kvm $USER && sudo usermod -a -G libvirt $USER
echo
read -p "Press ENTER to disable AppArmor to avoid issues with tcpdump"
sudo aa-disable /usr/sbin/tcpdump
echo
read -p "Press ENTER to add the group pcap, and add to it the user cuckoo"
sudo groupadd pcap
sudo usermod -a -G pcap cuckoo
echo
read -p "Press ENTER to change /usr/sbin/tcpdump to pcap group and change capabilities"
sudo chgrp pcap /usr/sbin/tcpdump
sudo setcap cap_net_raw,cap_net_admin=eip /usr/sbin/tcpdump
echo
read -p "Press ENTER to proceed to install cuckoo==2.0.7"
sudo pip install cuckoo==2.0.7
echo
read -p "Press ENTER to create a Postgress database, user and a password"
# Manual process to create a database, a user and its password in Postgress
#sudo su postgres
#psql=# CREATE USER cuckoo WITH PASSWORD ‘somePassword’;
#psql=# CREATE DATABASE cuckoo;
#psql=# GRANT ALL PRIVILEGES ON DATABASE cuckoo to cuckoo;
sudo -u postgres psql -c "CREATE USER cuckoo WITH PASSWORD 'cuckoo';"
sudo -u postgres psql -c "CREATE DATABASE cuckoo;"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE cuckoo to cuckoo;"

echo
read -p "Press ENTER to install yara"
sudo wget https://github.com/VirusTotal/yara/archive/v3.8.1.zip && sudo unzip v3.8.1.zip && cd yara* && sudo ./bootstrap.sh && sudo ./configure --enable-cuckoo --enable-magic --enable-dotnet && sudo make && sudo make install
echo
read -p "Press ENTER to execute cuckoo for first time. You should only see a first time welcome banner."
cuckoo
echo
echo "If you read this, all is OK, and we are going to install some cuckoo community signatures"
read -p "Press ENTER to install them"
cuckoo community
