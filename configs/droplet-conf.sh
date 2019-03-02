#!/bin/bash

echo "Type the name of the user to create"
read NUSER

useradd $NUSER && passwd $NUSER #(follow instructions)
mkdir -p /home/$NUSER/.ssh
touch /home/$NUSER/.ssh/authorized_keys
chown -R $NUSER:$NUSER /home/$NUSER/
chown root:root /home/$NUSER
chmod 700 /home/$NUSER/.ssh
su $NUSER
chmod 600 /home/$NUSER/.ssh/authorized_keys

echo "User creation process ended."
exit 0
