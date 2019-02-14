#!/bin/bash

########################################################################
# Requirements:
# Interactive Menu and at least 5 user inputs
# Download something from the web
# Find certain information (keywords)
# Alternative input mechanisms: manual or from a file
# Security Note: a Kali Linux VM has been used, so root is employed 
# to assure functionality.
# NEVER DO THAT FOR SECURITY REASONS- YOU CAN USE $USER WHERE APPROPRIATE
# TO CHANGE THIS AND RUN THE SCRIPT WITHOUT ROOT PRIVILEGES
########################################################################

if [ ! -d "/root/Exam" ]; then
	clear;
	echo "Auto-generating the needed directories and files."
	mkdir -p /root/Exam/outputs/robots_txt
	mkdir /root/Exam/run
	echo "run" >/root/Exam/run/run.txt
	echo
	echo "The following directories have been successfully created"
	ls /root/Exam/*
	sleep 3
else
	clear;
	echo "Directory </root/Exam> already exists"
	echo "Checking if you have already run this script before..."
	RUN=$(cat /root/Exam/run/run.txt)
	if [ $RUN == "run" ]; then
		echo
		echo "Perfect! We are going to run the script again"
		sleep 3;
	else
		clear;
		echo "We need to create a directory named outputs inside /root/Exam"
		echo "Are you sure you want to do it? (y/N)"
		read -rsn1 SUBDIROPTION;
		if [ SUBDIROPTION == "y" ]; then
			mkdir -p /root/Exam/outputs/robots_txt
		else
			echo "OK, modify this code so as the directories created do not interfere with your files"
			echo "This script has stopped. Have a nice day!"
			clear
			echo "Bye!"
			sleep 3
			exit		 
		fi;
	fi;
fi;
# Clearing the screen and showing the options
clear
echo "			**********************************"
echo "			*                                *"
echo "			*       ROBOTS.TXT GRABBER       *"
echo "			*                                *"
echo "			**********************************"
echo
echo "Select from the following options:"
echo "================================= "
echo
echo " 1.- Use a txt file with the IPs in it"
echo
echo " 2.- Type the IPs manually and a txt will be created in /tmp"
echo
echo " 3.- Exit"
echo
echo
echo "JUST PRESS THE NUMBER OF YOUR CHOICE"
# Input from user will be stored in the varible OPTION (just pressing the number)
read -rsn1 OPTION

# Forking actions depending on the selected option
# OPTION == 1 -> Write the full path to a file containing domains or IPs  
if [ $OPTION == "1" ]; then
	clear;
	echo -n "Please, type the full path to the IPs txt file>";
	read IPS_FILE;
	echo $IPS_FILE;
	NOW=$(date +"%d_%m_%H_%M")
	mkdir /root/Exam/outputs/robots_txt/$NOW
	for IP in $(cat $IPS_FILE); do 
		clear;
		echo "*********************************";
		echo "* Downloading robots.txt in $IP *";
		echo "*********************************";
		# Download robots.txt and it is stored in a generated path (date and IP or domain)
		wget -T 10 -t 2 http://$IP/robots.txt -O /root/Exam/outputs/robots_txt/$NOW/${IP}_robots.txt; 
	done
# Option ==2 -> Domains or IPs are stored in a tmp file manually 
elif [ $OPTION == "2" ]; then
	MORE="y";
	if [ ! -f /tmp/robots_from_ips.txt ]; then
    		touch /tmp/robots_from_ips.txt;
	else
		rm /tmp/robots_from_ips.txt;
	fi
	while [ $MORE == "y" ]; do
		clear;
		echo -n "Type IP>";
	        read IP;
        	echo $IP >> /tmp/robots_from_ips.txt
		IPS_FILE="/tmp/robots_from_ips.txt"
	        echo -n "Do you want to add more IPs? (Press <y> for yes or <any to finish)>";
		read -rsn1 MORE;
	done;
	IPS_FILE="/tmp/robots_from_ips.txt";
	NOW=$(date +"%d_%m_%H_%M")
	mkdir /root/Exam/outputs/robots_txt/$NOW
	for IP in $(cat $IPS_FILE); do (wget -T 10 -t 2 http://$IP/robots.txt -O /root/Exam/outputs/robots_txt/$NOW/${IP}_robots.txt); done
# Option == 3 --> Just for exiting the program
elif [ $OPTION == "3" ]; then
	echo "Quitting. Have a nice day!";
	sleep 3;
	clear;
	exit
# Any other invalid option will relaunch the menu again
else
	echo "That option does note exist";
	echo "Let us update the OS database to auto-find keyrobtxt.sh"
	updatedb
	echo "Relaunching the script...";
	RESTART=$(locate keyrobtxt.sh)
	bash $RESTART
	sleep 2;
	exit
fi

# Interesting keywords
# A tmp file is created to store the interesting keywords to search for
if [ ! -f /tmp/keywords_in_robots.txt ]; then
	touch /tmp/keywords_in_robots.txt;
else
	rm /tmp/keywords_in_robots.txt;
fi
touch /tmp/keywords_in_robots.txt;
MORE="y"
while [ $MORE == "y" ]; do
	clear;
	echo -n "Type keyword>";
	read KEYWORD;
	echo $KEYWORD >> /tmp/keywords_in_robots.txt
                echo -n "Do you want to add more keywords? (Press <y> for yes or <any> to finish)>";
                read -rsn1 MORE;
        done;
        KEYWORDS_FILE="/tmp/keywords_in_robots.txt";

# Final menu where results are shown in a very basic way
# FORMAT: /root/Exam/outputs/robots_txt/$NOW/${IP}_robots.txt)
clear;
echo "					********************************************************"
echo "					*							                                         *"
echo "					*  			               RESULTS 	                       *"
echo "					*							                                         *"
echo "					********************************************************"
echo
echo

# If a keyword is found among the different robtos.txt files, it will be shown

for WORD in $(cat $KEYWORDS_FILE); do 
	for IP in $(cat $IPS_FILE); do
		for line in $(cat /root/Exam/outputs/robots_txt/$NOW/${IP}_robots.txt); do
			VALUE=$(echo $line |grep $WORD);
			if [[ $VALUE != "" ]]; then
				echo "==========================="
				echo "$IP"
				echo "==========================="
				echo
				echo "Searching for $WORD in the robots.txt file";
				echo $line |grep "$WORD";
				echo
			fi;
		done;
	done;
done
