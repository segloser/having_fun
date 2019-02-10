#!/bin/bash
clear
echo "Type the IP to measure incoming and outgoing traffic:"
read IP

#Checking IP format
if [[ $(echo $IP | grep -oE "\b((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\b") == $IP ]]
then
        :
else
        echo "Incorrect IP format. Exiting now."
        exit 
fi

echo
echo "Press ENTER when ready for zeroing and flushing IPTABLES"
read -n1
iptables --zero
iptables --flush

echo "Configuring IPTABLES to measure traffic"
iptables -I INPUT 1 -s $IP -j ACCEPT
iptables -I OUTPUT 1 -d $IP -j ACCEPT

echo "Incoming and Outgoing Traffic ready to be measured"
clear
echo "Press ENTER to see the traffic when your Nmap finishes"
read -n1
echo
echo "Listing IPTABLES:"
echo "================"
iptables -nv -L
echo
echo "Tasks finished"
echo "Exiting now"
exit 0
