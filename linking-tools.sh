#!/bin/bash

# Script to link some simple tools.
# Next stepts: make this tool useful for different cases (e.g.: API required! or similar interruptions)
# Written to work in Kali Linux

clear
echo "Welcome to a simple script to show how to execute several tools for a given target domain."
echo
echo "Please, type the directory's FULL PATH in which you want to save the output of this script"
read DIRECTORY

echo
echo -n "Type the target domain (Example: mytarget.com): "
read TARGET

# Naming conventions
DATE=$(date +%d-%M-%Y-%H%m%S)
OUTFORMAT="$TARGET-$DATE.txt"
DIRTAR="$DIRECTORY/$TARGET-$DATE"

echo "Creating a subdirectory to store all the outputs"
mkdir $DIRTAR

echo "Starting a Whois search..."
echo "Output sent to $DIRTAR using this format TOOL-$TARGET-$DATE.txt"
echo 
whois $TARGET | tee $DIRTAR/whois-$OUTFORMAT
sleep 1
NT="\n==========\nNext tool!\n==========\n"
echo -e $NT

echo "Let us perform a DNS look up with nslookup and the default name server"
nslookup $TARGET | tee $DIRTAR/nslookup-$OUTFORMAT
OS=echo "****** Output sent to the corresponding directory ******"
echo -e $OS
sleep 1
echo -e $NT

echo "Using nmap to obtain Operating System fingerprints"
nmap -vv -O $TARGET | tee $DIRTAR/nmap-O-$OUTFORMAT
echo
echo -e $OS
sleep 1


echo "Starting now theHarvester to get some information. Options = -l 500 -b all"
theharvester -d $TARGET -l 500 -b google | tee $DIRTAR/theharvester-$OUTFORMAT
echo
echo -e $OS
sleep 1
echo -e $NT

echo "Turn for dnsrecon"
dnsrecon -d $TARGET | tee $DIRTAR/dnsrecon-$OUTFORMAT
echo
echo -e $OS
sleep 1
echo -e $NT

echo "Preparing to run WAF scanner (wafw00f)"
wafw00f http://$TARGET | tee $DIRTAR/wafw00f-$OUTFORMAT
echo
echo -e $OS
sleep 1
echo -e $NT

echo "Running some SSL checkings now..."
sslscan $TARGET | tee $DIRTAR/sslscan-$OUTFORMAT
sslyze --resum --certinfo=basic --compression --reneg --sslv2 --sslv3 --hide_rejected_ciphers $TARGET | tee $DIRTAR/sslyze-$OUTFORMAT

echo
echo "Time to review the output files in $DIRTAR. Enjoy!"

echo "Checking web with whatweb"
whatweb $TARGET | tee $DIRTAR/whatweb-$OUTFORMAT

echo "Checking indicators of WordPress."

if [[ $(grep -i wordpress $DIRTAR/whatweb-$OUTFORMAT) != "" ]]; then

  echo "Some WordPress indicator found."
  read -p "To scan it with WPscan press ENTER. To quit just press CTRL+C"
  wpscan --url http://$TARGET -e u > $DIRTAR/wpscan-$OUTFORMAT
	echo
	echo -e $OS
	sleep 1
	echo -e $NT

else
	echo "No WordPress indicator found."

fi

exit 0
