#!/bin/bash

COUNTER=0; 
for DEV in $(ifconfig | grep flags | cut -d":" -f1)
	do 
		COUNTER=$((COUNTER+1)) && echo $COUNTER.- $DEV; done | tee /tmp/choose.txt

echo "Type the device number: "
read TYPED

OPTION=$(cat /tmp/choose.txt | grep "$TYPED.-" | cut -d"-" -f2)

echo "Type the IP to be assigned to that device: "
read IP

ifconfig $OPTION down
ifconfig $OPTION $IP
ifconfig $OPTION up

echo "Running ifconfig. Check that all is set as needed"
sleep 1
clear
ifconfig
exit 0
