#!/bin/bash

# Defining some font colors

RED='\033[0;31m' # Red
LRE='\033[1;31m' # Light Red

GRE='\033[0;32m' # Green
LGR='\033[1;32m' # Light Green

LBL='\033[94m' # Light Blue

NC='\033[0m' # No Color

BOL='\033[1m' # Bold

clear
echo -e "$GRE[i]$NC Resetting working temporary directories..."
rm -rf /tmp/bash-tests
sleep 2
clear
echo -e  "$RED Please, be sure to execute this script as $BOL root. $NC"
echo
echo -e "$LGR Press ENTER when ready to start. $NC"
read -p ""

if [[ $(which pv) != "" ]]; then 
	echo -e  "$LGR [+] $NC pv requirement satisfied, we can continue."
	sleep 1
	clear
else 
	echo -e  "$RED[!]$NC pv is NOT installed."
	echo -e  "Installing it for you..."
	sudo apt-get update -y && sleep 5 && apt-get install pv -y
	if [[ $(which pv) != "" ]]; then
		sleep 2
		clear 
	        echo -e  "$LGR [+] $NC pv requirement satisfied, we can continue."
        	sleep 1
        	clear
	else
		clear
        	echo -e  "$RED Manually check that pv has been installed. Problems detected. Exiting now. $NC"
        	exit 1
	fi

fi
echo -e 

if [[ $(which tree) != "" ]]; then 
        echo -e  "$LGR [+] $NC tree requirement satisfied, we can continue."
        sleep 1
        clear
else 
        echo -e  "$RED[!]$NC tree is NOT installed."
        echo -e  "Installing it for you..."
        sudo apt-get update -y && sleep 5 && apt-get install tree -y
        if [[ $(which tree) != "" ]]; then
                sleep 2
                clear 
                echo -e  "$LGR [+] $NC tree requirement satisfied, we can continue."
                sleep 1
                clear
        else
                clear
                echo -e  "Manually check that tree has been installed. Problems detected. Exiting now."
                exit 1
        fi

fi
echo -e 

clear
echo -e  "$BOL Exercise 1 $NC"
echo -e  "=========="

cd ~
echo -e  "This is a script that simulates some linux basic commands to help you to get familiar with them." | pv -qL 50
echo -e 
echo -e  "Try to replicate everything after a couple of reviews." | pv -qL 50
echo -e 
#echo -e  "If you are not using Terminator, do you want me to install Terminator for you? $BOL (y/$BOL N $NC) $NC" | pv -qL 50
#read INSTALL

#if [ "$INSTALL" == "y" ] || [ "$INSTALL" == "yes" ] || [ "$INSTALL" == "Y" ]; then
#	sudo apt-get update -y
#	sudo apt-get install terminator -y
#	clear
#	echo -e  "Now you can run this script in Terminator"
#	echo -e  "Exiting now"
#	echo -e 
#	exit 0
#else
#	echo -e  "You need to manually install Terminator if you want to use it to follow this exercise in parallel" | pv -qL 50
#fi

echo -e 
echo -e "$LGR Press ENTER when ready to go on. $NC" | pv -qL 75 ; read -p ""
clear
echo -e  "$BOL Exercise 2 $NC"
echo -e  "=========="

echo -e  "Some directories basics. Now you are in the following directory:" | pv -qL 75
echo -e "$LBL"; pwd; echo -e "$NC"
echo -e 
echo -e  "I am going to change the current directory so you can appreciate subdirectories structures." | pv -qL 75

echo -e 
echo -e  "Changing to $BOL /var/log/apache2 $NC, typing:" | pv -qL 75
echo -e "$LBL cd /var/log/apache2 $NC"
cd /var/log/apache2

echo -e 
echo -e  "Now you are in the following directory:" | pv -qL 75
echo -e  "$LBL"; pwd; echo -e "$NC"

echo -e 
echo -e  "To verify the current directory, you just have to type $LBL pwd. $NC" | pv -qL 50
echo -e "$LGR Press ENTER when ready to keep on. $NC" | pv -qL 50; read -p ""

clear
echo -e  "Exercise 3"
echo -e  "=========="
echo -e  "Type the following to discover the directories architecture of your system:"
echo -e  "First change to the root directory (/) typing:"
echo -e  "$LBL cd / $NC"
cd /
echo -e 
echo -e  "Now, to see the directory structure type:"
echo -e  "$LBL tree -L 1 $NC"
echo -e "$LGR Press ENTER when ready to keep on. $NC" | pv -qL 50; read -p ""
tree -L 1

echo -e 
echo -e  "$RED Be sure to be $BOL root $NC $RED for the next exercise. $NC" | pv -qL 50
echo -e "$LGR Press ENTER when ready to keep on $NC" | pv -qL 50; read -p ""

clear
echo -e  "$BOL Exercise 4 $NC"
echo -e  "=========="

echo -e  "Changing to the user root home directory ( $LBL /root $NC )" | pv -qL 75
echo -e  "$LBL cd /root $NC" | pv -qL 30
sleep 1
cd /root
sleep 1

echo -e  "Showing the root user home directory tree structure" | pv -qL 75
tree -L 1
echo -e 

echo -e  "About to list the contents of the working directory with $LBL ls -lha $NC" | pv -qL 75
echo -e "$LGR Press ENTER when ready to keep on $NC" | pv -qL 50; read -p ""
ls -lha

echo
#echo -e  "Now, I am changing to the root user's directory (hint: /root)" | pv -qL 75
#echo -e "$LBL cd /root $NC"
#cd /root

echo -e  "List the contents of /bin from the root user’s directory"
echo -e  "$LBL ls /bin $NC" | pv -qL 75
echo -e "$LGR Press ENTER when ready to list the directory. $NC" | pv -qL 50; read -p ""
ls /bin

echo -e "$LGR Press ENTER when ready to keep on. $NC" | pv -qL 50; read -p ""

clear
echo -e  "$BOL Exercise 5 $NC" | pv -qL 30
echo -e  "==========" | pv -qL 30
echo -e  "Making a new directory named $LBL bash-tests $NC inside the $LBL /tmp $NC directory (remember, nothing will remain there after rebooting)" | pv -qL 75
echo -e  "$LBL mkdir /tmp/bash-tests $NC" | pv -qL 75
mkdir /tmp/bash-tests
echo -e "$LGR Press ENTER to continue. $NC" | pv -qL 50; read -p ""

echo -e 
echo -e  "Explore the options of the command used to make a new directory (mkdir) and try to make the following chain of subdirectories with a single command (the goal is to create nonexistent middle directories at the same time) :" | pv -qL 75
echo -e  "$LBL mkdir -p /tmp/bash-tests/dir1/dir2/dir3/dir4/dir5 $NC" | pv -qL 40
mkdir -p /tmp/bash-tests/dir1/dir2/dir3/dir4/dir5
echo -e "$LGR Press ENTER to continue. $NC" | pv -qL 50; read -p ""

echo -e 
echo -e  "Change to $LBL /tmp/bash-tests $NC directory and once there use $LBL echo $NC to insert the following URL in $LBL text-1.txt: $NC" | pv -qL 75
echo -e "$LBL cd /tmp/bash-tests $NC"
cd /tmp/bash-tests
echo
echo -e  "$LBL echo 'https://www.microsoft.com' > /tmp/bash-tests $NC"
echo 'https://www.microsoft.com' > /tmp/bash-tests/text-1.txt
echo
echo -e "$LGR Press ENTER to continue. $NC" | pv -qL 50; read -p ""

clear
echo -e  "$BOL Exercise 6 $NC" | pv -qL 30
echo -e  "==========" | pv -qL 30
echo -e  "Copy text-1.txt to /tmp/bash-tests/dir1 with a different name (text-2.txt)." | pv -qL 50
echo -e  "$LBL cp ./text-1.txt /tmp/bash-tests/dir1/text-2.txt $NC"
cp ./text-1.txt /tmp/bash-tests/dir1/text-2.txt
echo -e 
echo -e  "Change the name of text-2.txt to text-3.txt. (Hint: mv)"
echo -e  "$LBL mv /tmp/bash-tests/dir1/text-2.txt /tmp/bash-tests/dir1/text-3.txt $NC"
mv /tmp/bash-tests/dir1/text-2.txt /tmp/bash-tests/dir1/text-3.txt
echo -e 
echo -e  "Move text-1.txt to the same folder in which text-3.txt is."
echo -e  "$LBL mv ./text-1.txt /tmp/bash-tests/dir1 $NC"
mv ./text-1.txt /tmp/bash-tests/dir1
echo -e 
echo -e "Show the content of text-3.txt on the console using $LBL cat $NC"
echo -e "$LBL cat /tmp/bash-tests/dir1/text-3.txt $NC"
echo -e "$BOL"
cat /tmp/bash-tests/dir1/text-3.txt
echo -e "$NC"
#echo -e  "Change the owner and group of text-2.txt"
#echo -e  "Hint 1: chown"
#echo -e  "Hint 2: chgrp"

#echo -e  "Change the privileges of text-2.txt in a way that only you, the owner, can read the content of the file."
#echo -e  "Hint 1: chmod"
#echo -e  "Hint 2: -r--------"
echo -e 
echo -e "$LGR Press ENTER to continue. $NC" | pv -qL 50; read -p ""

clear
echo -e  "$BOL Exercise 7 $NC" | pv -qL 30
echo -e  "==========" | pv -qL 30
echo -e  "Type $LBL host test.com $NC and filter the output to only display IPs"
echo -e  "Hint for beginners: it can be done using just one single grep and one single cut"
echo -e  "Hint for advanced users (-oE): it can be done with a single grep"
echo 
echo -e  "$LBL host test.com | grep "has address" | cut -d" " -f4 $NC"
echo -e "$BOL"
host test.com | grep "has address" | cut -d" " -f4
echo -e "$NC"
echo -e "$LGR Press ENTER to continue. $NC" | pv -qL 50; read -p ""

clear
echo -e  "$BOL Exercise 8 $NC" | pv -qL 30
echo -e  "==========" | pv -qL 30
echo -e  "Type and execute the following script, and get familiar with the process of creating a simple $BOL for loop: $NC"
echo -e  "$LBL for NUMBER in \$(seq 1 10); do echo -e  \$NUMBER && sleep 1; done $NC"
for NUMBER in $(seq 1 10); do echo -e  $NUMBER && sleep 1; done
echo -e 
echo -e  "NUMBER is a variable you are defining, that in every round of the loop, will take the value of a number in the sequence 1 to 10 until reaching the last value (which is 10)."
echo -e 
echo -e  "\$NUMBER is the way in which you refer to the created variable with that name. The format is $ plus the NAME_OF_VARIABLE."
echo -e 
echo -e  "Just repeat this from time to time to assimilate the fundamentals of scripting in the terminal. This could be a variation that also does the job:"
echo -e  "$LBL for i in \$(seq 1 10); do echo -e  \$i; done $NC"
echo -e "$LGR Press ENTER to continue. $NC" | pv -qL 50; read -p ""

clear
echo -e "$LGR Press ENTER to see a summary. $NC" | pv -qL 50; read -p ""

echo
echo -e "$LRE This script is just an inspiration for you to adopt a new way of learning through scripting."
echo
echo -e "LEARNING PROPOSAL: AUTOMATE EVERYTHING WITH SCRIPTS TO LEARN THE INNER MECHANISMS AND ASSIMILATE THE CONTENTS"
echo 
echo -e "During this script you have learned:"
echo
echo -e "How to identify the current directory and how to change it"
echo -e "How to list the contents of a directory"
echo -e "How to transfer text to a file using the terminal"
echo -e "How to move, copy and rename files"
echo -e "How to manipulate the output"
echo -e "How to count until 10 using your first FOR loop"
echo -e
echo -e "Press ENTER to end $NC"
read -p ""
