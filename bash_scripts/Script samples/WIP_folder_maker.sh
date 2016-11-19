#!/bin/bash
# creates folder structure in the WIP
echo;echo "This script creates an 'Archive Staging' & 'Logs' folders. As well as appropriate permissions";echo
read -p "Enter path to client assets (e.g. /r2/conagrajobs/): " CLIENT

if [ ! -d "$CLIENT" ]; then
  echo;echo "###  NOT A VALID CLIENT PATH - EXITING  ###";echo
  exit
fi
mkdir -p "$CLIENT/""Archive Staging/"
mkdir -p "$CLIENT/""Logs/"

# set ownership and permissions
chown -R root:schawk_users "$CLIENT"
chmod 777 "$CLIENT"
chmod -R 755 "$CLIENT/""Archive Staging"
chmod -R 755 "$CLIENT/""Logs"
chown -R root:schawk_users "$CLIENT/""Archive Staging"
chown -R root:schawk_users "$CLIENT/""Logs"

echo "###  Successful Completion  ###";echo

exit 0
#  A zero return value from the script upon exit indicates success
#+ to the shell.