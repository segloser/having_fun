#!/bin/bash

clear
echo "Bash scripting exercise for Kali Linux macchanger tool."
echo "This script automates the process for changing your MAC address."
echo
echo "Available Network Interfaces"
echo "============================"
echo

# Extracting network interfaces using ifconfig and formatting output
# temporary network-interfaces.txt file created
ifconfig | grep mtu | cut -d ':' -f1 > /tmp/network-interfaces.txt

# Creating an interfaces menu with numbers to select from
N=1; for INT in $(cat /tmp/network-interfaces.txt); do echo $N.- $INT; N=$((N+1)); done > /tmp/menu-n-interfaces.txt

# Defining filenames and /or paths
NETINT="/tmp/network-interfaces.txt"
MENINT="/tmp/menu-n-interfaces.txt"

# Network interfaces number
INRANGE=$(wc -l $MENINT | cut -d" " -f1)

# Adding Exit to the menu
EXOPT=$((INRANGE + 1))
echo $EXOPT.-Exit >> /tmp/menu-n-interfaces.txt

# Printing the menu (the file could be referred as a variable)
cat $MENINT #/tmp/menu-n-interfaces.txt

# Network interfaces number
INRANGE=$(wc -l $MENINT | cut -d" " -f1)

# Selecting an interface
echo "Choose the number corresponding to the interface network whose  MAC you want to change"
read MENUMBER

if [[ $MENUMBER == "" ]] || [[ $MENUMBER == $EXOPT ]]
then
	echo "You typed exit or nothing. Exiting."
	exit 1

elif [[ $(echo $MENUMBER | grep '[A-Za-z]') == $MENUMBER ]]
then
        echo "Whatever you typed, does not make sense. Exiting"
        exit 1

elif [[ $MENUMBER -gt $INRANGE ]]
then
	echo "Selected number out of range. Exiting."
	exit 1

elif [[ $MENUMBER -le $INRANGE ]]
then
	CHOICE=$(awk -v LINE=${MENUMBER} 'NR==LINE' $MENINT | cut -d' ' -f2)
	echo $CHOICE
fi

# Printing current MAC using ifconfig
CURMAC=$(ifconfig | grep -A 4 wlp | grep ether | cut -d' ' -f10)

clear
echo "Showing current MAC for $CHOICE: $CURMAC"
sleep 2
clear
echo "Randomly chaning the MAC for $CHOICE"

# Disabling the selected inteface
sudo ifconfig $CHOICE down

# Using macchanger to randomly change the MAC
sudo macchanger -r $CHOICE

# Enabling the selected interface
sudo ifconfig $CHOICE up

# Printing new MAC using macchanger -s
macchanger -s $CHOICE
