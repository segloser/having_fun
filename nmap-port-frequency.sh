#!/bin/bash

# Short script to help students to understand the functions in Bash

clear
echo -e "This program provides the port position in the Nmap frequent services list.\n"
echo -n "Type the number of the port: "
read PORT

# Sanitizing port number
while [[ $PORT != [0-9]* ]];
do
	echo -n "The port must be a number from 0 to 65535. Try again: "
	read PORT
done

echo -n "Select the protocol (TCP or UDP): "
read PROTOCOL

# Sanitizing protocol input
while [[ ${PROTOCOL,,} != "tcp" ]] && [[ ${PROTOCOL,,} != "udp" ]];
do
	echo -n "Protocol incorrectly typed. Type it again (TCP or UDP): "
	read PROTOCOL
done 

# Defining sorting function - It sorts all ports according to frequency and filter according to two parameters (PORT/PROTOCOL)
function sorting {
	POS=$(cat /usr/share/nmap/nmap-services | sort -rk 3,3 | awk {'print $2'} | grep "/" | grep -v http | grep -ni "$1/$2" | grep ":$1/")
	echo -n "The port $1/$2 is in position: "
	echo $POS | cut -d":" -f1
}

# Calling sorting function
sorting $PORT ${PROTOCOL,,}
