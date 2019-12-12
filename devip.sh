#!/bin/bash
clear
echo -e "This program will show a menu with the network devices and it will provide the assigned IP\n"

COUNTER=0; 
for DEV in $(ifconfig | grep flags | cut -d":" -f1)
        do 
                COUNTER=$((COUNTER+1)) && echo $COUNTER.- $DEV; done | tee /tmp/choose.txt

echo -e "\nType the device number and press ENTER: "
echo -n "> "
read TYPED 

OPTION=$(cat /tmp/choose.txt | grep "$TYPED.-" | cut -d"-" -f2)

echo -e "\nThe IP of the selected device is: "
echo "================================"
ifconfig | grep $OPTION -A 1 | grep inet | cut -d" " -f10
