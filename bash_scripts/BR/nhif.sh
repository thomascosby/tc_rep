#!/bin/bash
#
####################################################
####################################################
####################################################
###########          Version 1.0          ##########
###########                               ##########
###########   created by - Thomas Cosby   ##########
###########           2015 07 28          ##########
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
###########      Current Version 1.0      ##########
###########                               ##########
####################################################
####################################################
####################################################
#  Version History
#  creates new hire info request and send to hiring manager.
####################################################
#
#
#  Variables
RECIPIENTS="tcosby@bleacherreport.com"
MAILTEXT="/tmp/newhire_request_email.txt"
#
#
####################################################
#
#

echo "###  Now, we'll send an email to the hiring manager for information about new hire.  ###" ; echo
#
read -p "Enter hiring managers email address. :  " NHREQEMAIL
#  Email text/message
#
echo "$MAILTEXT" | mail -s "*** New Hire Information Request ***" -c "$RECIPIENTS" "$NHREQEMAIL"
#
echo "###  Email sent to $NHREQEMAIL  ###" ; echo
#
exit 0
#  A zero return value from the script upon exit indicates success
#+ to the shell.