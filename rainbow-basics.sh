#!/bin/bash

# We have divided the checking process into two steps to force extra writing ;)
clear
echo "Welcome to a simple script to show the Rainbow concept"
echo
sleep 2

# Defining filenames
EXFILE="/tmp/pass-hashed.txt"
HASHONLY="/tmp/hash-only.txt"

# Checking file presence in the OS temporary directory
if [[ $(ls $EXFILE) == $EXFILE ]]; then
	echo "A temporary example file already exists."

else
	echo
	echo "Generating a example file with 102350 passwords and its hashes."
	echo "This process takes 4 to 5 minutes in a i7/24GB RAM."
	echo
	echo "By the way, you should be in Kali Linux or the script will not work"
	for PASS in $(cat /usr/share/dict/american-english); do echo -n "$PASS " && echo $PASS | md5sum; done > $EXFILE
	echo "Creating auxiliary files"
	cat $EXFILE | cut -d' ' -f2 > $HASHONLY
fi
sleep 2
echo "All the required steps are satisfied"
echo
clear
echo -n "Type the hash you want to check in our txt database: "
read HASH

if [[ $(grep $HASH $HASHONLY) == "" ]]; then
	echo "Checking your hash..."
	echo "Sorry, we have not found your hash. Bye."
	exit 0
else
	echo "Checking your hash directly in combined file..."
	# Generating visual effect of searching
	#head -n 100000 $HASHONLY
	echo
	sleep 1
	echo "Take a look at what we have found..."
	cat $EXFILE | grep $HASH
	echo
	echo "So..."
	echo -n "Password --> "; cat $EXFILE | grep $HASH | cut -d' ' -f1  
fi
exit 0
