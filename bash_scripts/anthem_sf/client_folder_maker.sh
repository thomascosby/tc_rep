#!/bin/bash
#
####################################################
####################################################
####################################################
###########          Version 1.0          ##########
###########                               ##########
###########   created by - Thomas Cosby   ##########
###########           2014 09 09          ##########
###########          __        __         ##########
###########         /\ \   *  /\ \        ##########
###########         \:\ \    /::\ \       ##########
###########          \:\ \  /:/\:\ \      ##########
###########        * /::\ \/:/ /\:\ \     ##########
###########         /:/\:\_\/_/  \:\_\    ##########
###########        /:/ /\/_/\ \   \/_/    ##########
###########       /:/ /    \:\ \  *       ##########
###########       \/_/      \:\ \         ##########
###########               *  \:\_\        ##########
###########                   \/_/        ##########
###########                               ##########
###########      Current Version 3.1      ##########
###########                               ##########
####################################################
####################################################
####################################################
#  Version History
#  v3.1 - 20150106 - tc
#+ script clean up and fixed issue of way too many double quotes that prevented any folder names with spaces
#+ also added email verification to requestor
#  v3.0 - 20141120 - tc
#+ folder tweaks and clean up, added design folders as requested.
#  v2.0 - 20141113 - tc
#+ adjusted clientname variable to include, by default, /Volumes/15TB_RAID/Clients/ as this is a static path and
#+ does not need to be entered in every time.
#  v1.0 - 20140909 - tc
#  creates Anthem Folder Structure in the Client Volume
####################################################
#
#
#  Variables
DIRPATH="/Volumes/15TB_RAID/Clients"
#DIRPATH="/Users/thomas/Desktop"
RECIPIENTS="thomas.cosby@schawk.com,becca.gorski@schawk.com,william.finn@schawk.com"
#
#
####################################################
#
#
echo;echo "This script creates a client folder, including brand name & other required folders.";echo
read -p "Enter Client Name. Do not use any non alpha numeric characters. (e.g. Client Name):  " CLIENTNAME
#
#  check to see if this client folder exists; if not, offer to create
if [ ! -d "$DIRPATH/$CLIENTNAME" ]; then
    echo
  read -p "Client folder doesn't exist: $DIRPATH/$CLIENTNAME/ Create it? (y/n) : " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    echo "###  USER CANCELLED - EXITING  ###"
    exit
  fi
  mkdir -p "$DIRPATH/$CLIENTNAME/"
fi
read -p "Enter the name of the Brand folder. Do not use any non alpha numeric characters. (e.g. Brand Name):  " BRANDNAME
#
#  check to see if this brand folder exists; if not, offer to create
if [ ! -d "$CLIENTNAME/$BRANDNAME/" ]; then
    echo
  read -p "Brand folder doesn't exist: $CLIENTNAME/$BRANDNAME/ Create it? (y/n) : " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    echo "###  USER CANCELLED - EXITING  ###"
    exit
  fi
  mkdir -p "$DIRPATH/$CLIENTNAME/$BRANDNAME/"
fi
read -p "Enter the name of the Project folder. Do not use any non alpha numeric characters. (e.g. Project Name):  " PROJECTNAME
#
#  check to see if this project folder exists; if not, offer to create
if [ ! -d "$DIRPATH/$CLIENTNAME/$BRANDNAME/$PROJECTNAME/" ]; then
    echo
  read -p "Project folder doesn't exist: $DIRPATH/$CLIENTNAME/$BRANDNAME/$PROJECTNAME/ Create it? (y/n):  " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    echo "###  USER CANCELLED - EXITING  ###"
    exit
  fi
  mkdir -p "$DIRPATH/$CLIENTNAME/$BRANDNAME/$PROJECTNAME/"
fi
#
#
echo
#  now create required structure
mkdir -p "$DIRPATH/$CLIENTNAME/$BRANDNAME/Brand Resources/"
mkdir -p "$DIRPATH/$CLIENTNAME/Master Account/Client Contacts/"
mkdir -p "$DIRPATH/$CLIENTNAME/Master Account/Master Service Agreements/"
#  
#  now create required structure within $PROJECTNAME/Account/
mkdir -p "$DIRPATH/$CLIENTNAME/$BRANDNAME/$PROJECTNAME/Account/Billing/Invoices/"
mkdir -p "$DIRPATH/$CLIENTNAME/$BRANDNAME/$PROJECTNAME/Account/Billing/Revenue Recognition/"
mkdir -p "$DIRPATH/$CLIENTNAME/$BRANDNAME/$PROJECTNAME/Account/Billing/Reports"
mkdir -p "$DIRPATH/$CLIENTNAME/$BRANDNAME/$PROJECTNAME/Account/Client Provided/"
mkdir -p "$DIRPATH/$CLIENTNAME/$BRANDNAME/$PROJECTNAME/Account/Concept Lead Upload/"
mkdir -p "$DIRPATH/$CLIENTNAME/$BRANDNAME/$PROJECTNAME/Account/Creative Brief/"
mkdir -p "$DIRPATH/$CLIENTNAME/$BRANDNAME/$PROJECTNAME/Account/Presentations/"
mkdir -p "$DIRPATH/$CLIENTNAME/$BRANDNAME/$PROJECTNAME/Account/Proposals/"
mkdir -p "$DIRPATH/$CLIENTNAME/$BRANDNAME/$PROJECTNAME/Account/Timeline/"
mkdir -p "$DIRPATH/$CLIENTNAME/$BRANDNAME/$PROJECTNAME/Account/Vendors/"
#
#  now create required structure within $PROJECTNAME/Design/
mkdir -p "$DIRPATH/$CLIENTNAME/$BRANDNAME/$PROJECTNAME/Design/Audits/"
mkdir -p "$DIRPATH/$CLIENTNAME/$BRANDNAME/$PROJECTNAME/Design/Raw Images/Client Provided/"
mkdir -p "$DIRPATH/$CLIENTNAME/$BRANDNAME/$PROJECTNAME/Design/Raw Images/Vendor Provided/"
mkdir -p "$DIRPATH/$CLIENTNAME/$BRANDNAME/$PROJECTNAME/Design/Raw Images/Purchased Stock Images/"
mkdir -p "$DIRPATH/$CLIENTNAME/$BRANDNAME/$PROJECTNAME/Design/Rounds/Prepro/"
mkdir -p "$DIRPATH/$CLIENTNAME/$BRANDNAME/$PROJECTNAME/Design/Rounds/R1/Design Files/"
mkdir -p "$DIRPATH/$CLIENTNAME/$BRANDNAME/$PROJECTNAME/Design/Rounds/R1/PDFs/"
mkdir -p "$DIRPATH/$CLIENTNAME/$BRANDNAME/$PROJECTNAME/Design/Rounds/R1/Presentation Deck/"
mkdir -p "$DIRPATH/$CLIENTNAME/$BRANDNAME/$PROJECTNAME/Design/Rounds/R2/Design Files/"
mkdir -p "$DIRPATH/$CLIENTNAME/$BRANDNAME/$PROJECTNAME/Design/Rounds/R2/PDFs/"
mkdir -p "$DIRPATH/$CLIENTNAME/$BRANDNAME/$PROJECTNAME/Design/Rounds/R2/Presentation Deck/"
mkdir -p "$DIRPATH/$CLIENTNAME/$BRANDNAME/$PROJECTNAME/Design/Rounds/R3/Design Files/"
mkdir -p "$DIRPATH/$CLIENTNAME/$BRANDNAME/$PROJECTNAME/Design/Rounds/R3/PDFs/"
mkdir -p "$DIRPATH/$CLIENTNAME/$BRANDNAME/$PROJECTNAME/Design/Rounds/R3/Presentation Deck/"
mkdir -p "$DIRPATH/$CLIENTNAME/$BRANDNAME/$PROJECTNAME/Design/Sketches/atsuei/"
mkdir -p "$DIRPATH/$CLIENTNAME/$BRANDNAME/$PROJECTNAME/Design/Sketches/cmazer/"
mkdir -p "$DIRPATH/$CLIENTNAME/$BRANDNAME/$PROJECTNAME/Design/Sketches/kbates/"
mkdir -p "$DIRPATH/$CLIENTNAME/$BRANDNAME/$PROJECTNAME/Design/Sketches/kkuan/"
mkdir -p "$DIRPATH/$CLIENTNAME/$BRANDNAME/$PROJECTNAME/Design/Sketches/mchan/"
mkdir -p "$DIRPATH/$CLIENTNAME/$BRANDNAME/$PROJECTNAME/Design/Sketches/mtjhin/"
mkdir -p "$DIRPATH/$CLIENTNAME/$BRANDNAME/$PROJECTNAME/Design/Sketches/sfraye/"
mkdir -p "$DIRPATH/$CLIENTNAME/$BRANDNAME/$PROJECTNAME/Design/Sketches/smederios/"
mkdir -p "$DIRPATH/$CLIENTNAME/$BRANDNAME/$PROJECTNAME/Design/Sketches/tdiehl/"
#
#  now create required structure within $PROJECTNAME/Strategy/
mkdir -p "$DIRPATH/$CLIENTNAME/$BRANDNAME/$PROJECTNAME/Strategy/Phase01/"
mkdir -p "$DIRPATH/$CLIENTNAME/$BRANDNAME/$PROJECTNAME/Strategy/Phase02/"
mkdir -p "$DIRPATH/$CLIENTNAME/$BRANDNAME/$PROJECTNAME/Strategy/Phase03/"
mkdir -p "$DIRPATH/$CLIENTNAME/$BRANDNAME/$PROJECTNAME/Strategy/Phase04/"
mkdir -p "$DIRPATH/$CLIENTNAME/$BRANDNAME/$PROJECTNAME/Strategy/Phase05/"
mkdir -p "$DIRPATH/$CLIENTNAME/$BRANDNAME/$PROJECTNAME/Strategy/References/"

#
#  now create required structure within $PROJECTNAME/Tech Design/
mkdir -p "$DIRPATH/$CLIENTNAME/$BRANDNAME/$PROJECTNAME/Tech Design/Design Handoff/"
mkdir -p "$DIRPATH/$CLIENTNAME/$BRANDNAME/$PROJECTNAME/Tech Design/History/"
mkdir -p "$DIRPATH/$CLIENTNAME/$BRANDNAME/$PROJECTNAME/Tech Design/Mechanicals/"
mkdir -p "$DIRPATH/$CLIENTNAME/$BRANDNAME/$PROJECTNAME/Tech Design/Released YYYYMMDD/"
mkdir -p "$DIRPATH/$CLIENTNAME/$BRANDNAME/$PROJECTNAME/Tech Design/Resources/Resources History/"
mkdir -p "$DIRPATH/$CLIENTNAME/$BRANDNAME/$PROJECTNAME/Tech Design/Working psd/"
#
#  set ownership and permissions
chown -R localadmin:staff "$DIRPATH/$CLIENTNAME/"
chmod 744 "$DIRPATH/$CLIENTNAME/"
chmod -R 764 "$DIRPATH/$CLIENTNAME/$BRANDNAME/$PROJECTNAME/"
chmod -R 764 "$DIRPATH/$CLIENTNAME/Master Account/"
#
#
echo "###  Successful Completion of $CLIENTNAME/$BRANDNAME/$PROJECTNAME/  ###" ; echo
#
#
#
echo "###  Now, we'll send an email to the requestor for verification of requested folder(s).  ###" ; echo
#
touch /tmp/asf_request_email.txt
read -p "Enter requestor's email address. We must use the @schawk.com email address. (e.g. chrystal.campbell@schawk.com):  " REQEMAIL
#  Email text/message
EMAILMESSAGE="/tmp/asf_request_email.txt"
echo "This is an automated email designed to verify that the Client, Brand, Project folder(s),">> $EMAILMESSAGE
echo "that you requested, were sucessfully created." >>$EMAILMESSAGE
echo "" >>$EMAILMESSAGE
echo "The following was created:" >>$EMAILMESSAGE
echo "Clients/$CLIENTNAME/$BRANDNAME/$PROJECTNAME/" >>$EMAILMESSAGE
echo "" >>$EMAILMESSAGE
echo "Thank you." >>$EMAILMESSAGE
echo "" >>$EMAILMESSAGE
echo "-Thomas" >>$EMAILMESSAGE
#
MAILTEXT=`cat /tmp/asf_request_email.txt`
echo "$MAILTEXT" | mail -s "*** Requested Folders Created on Clients Volume ***" -c "$RECIPIENTS" "$REQEMAIL"
#
echo "###  Email sent to $REQEMAIL and $RECIPIENTS  ###" ; echo
#
rm -rf /tmp/asf_request_email.txt
exit 0
#  A zero return value from the script upon exit indicates success
#+ to the shell.