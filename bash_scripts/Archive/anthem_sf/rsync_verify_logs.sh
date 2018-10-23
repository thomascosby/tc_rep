#!/bin/bash
####################################################
####################################################
####################################################
###########          Version 1.0          ##########
###########                               ##########
###########   created by - Thomas Cosby   ##########
###########           2013 08 04          ##########
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
# v. 1.0 - 20130804 - TCosby
#######################################################################
#   This script checks for the presence of at least one fileserver rsync log created in the past
#+ two days. If none exists, if warns the admins that the fileserver rsync may be broken.

RECIPIENTS="tholm@schawk.com,chause@schawk.com,thomas.cosby@schawk.com"
#RECIPIENTS="thomas.cosby@schawk.com"

# if no daily logs exist from the past two days, send an email to the admins
LOCAL_LOGS_FOUND=`find /Library/Logs/ -name 'rsync_local_*' -mtime -2 | wc -l`
REMOTE_LOGS_FOUND=`find /Library/Logs/ -name 'rsync_remote_*' -mtime -2 | wc -l`

if [ "$LOCAL_LOGS_FOUND" -lt "1" ]; then
  # NO LOGS FOUND
  SUBJECT="[WARNING - ASF Local rsync]"
  BODY="There are no daily logs for the Local Rsyncs for the past two days. Might want to look into that."
  echo -e "$BODY" | mail -s "$SUBJECT" "$RECIPIENTS"
fi

if [ "$REMOTE_LOGS_FOUND" -lt "1" ]; then
  # NO LOGS FOUND
  SUBJECT="[WARNING - ASF Remote rsync]"
  BODY="There are no daily logs for the Remote Rsyncs for the past two days. Might want to look into that."
  echo -e "$BODY" | mail -s "$SUBJECT" "$RECIPIENTS"
fi

exit 0
#  A zero return value from the script upon exit indicates success
#+ to the shell.