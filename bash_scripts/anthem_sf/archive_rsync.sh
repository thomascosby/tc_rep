#!/bin/bash
#
####################################################
####################################################
###########          Version 1.0          ##########
###########                               ##########
###########   created by - Thomas Cosby   ##########
###########           2014 11 03          ##########
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
#  
#  
#######################################################################
#  
#
#######################################################################
#  This script copies 00_To_Archive data from the Clients Volume
#+ to the Archive volume
#
#######################################################################
#
#  Variables
TIMESTAMP=`date '+%m.%d.%y-%H.%M'`
DAILY_LOG="/Library/Logs/rsync/rsync_arch_"$TIMESTAMP".log"
LOG_FILE="/Library/Logs/rsync/rsync_arch.log"
LOCK_FILE="/tmp/rsync_arch.lock"
RSYNC="/usr/local/bin/rsync"
RECIPIENTS="thomas.cosby@schawk.com"
#  source on fileserver
SOURCEVOL="/Volumes/15TB_RAID/Clients/00_To_Archive/"
#  dest on fileserver
DESTVOL="/Volumes/10TB_RAID/Archive/Clients/"
#  
START_TIME=`date`
touch $DAILY_LOG
touch $LOG_FILE
#  reset daily log
cat /dev/null > $DAILY_LOG

#  prevent the script from continuing if it was already running
#+ if script abends, need to manually delete this lock file
if [ -e $LOCK_FILE ]; then
	TIMESTAMP=$(date)
        echo "" >> $DAILY_LOG
	echo "$TIMESTAMP: lock file detected, exiting" >> $DAILY_LOG
        cat $DAILY_LOG >> $LOG_FILE
        mail -s "[ASF Archive rsync]" $RECIPIENTS < $DAILY_LOG
	exit
fi
touch $LOCK_FILE

echo "" >> $DAILY_LOG
echo "###  rsync Start: $START_TIME  ###" >> $DAILY_LOG

#  uncomment to perform dry run rsync
$RSYNC -avh --remove-source-files --stats --exclude '.DS_Store' "$SOURCEVOL" "$DESTVOL" 2>&1 | tee >> $DAILY_LOG

#  perform for reals rsync
#$RSYNC -avh --remove-source-files --stats --exclude '.DS_Store' "$SOURCEVOL" "$DESTVOL" 2>&1 | tee >> $DAILY_LOG

END_TIME=`date`

echo "" >> $DAILY_LOG
echo "###  $END_TIME" >> $DAILY_LOG;echo "" >> $DAILY_LOG
echo "###  rsync Complete" >> $DAILY_LOG
echo "" >> $DAILY_LOG
cat $DAILY_LOG >> $LOG_FILE
echo "----------------------------------------------------" >> $LOG_FILE; echo "" >> $LOG_FILE
tail -n 20000 $LOG_FILE > tempfile
cat tempfile > $LOG_FILE
rm -f tempfile

rm $LOCK_FILE

#  test the daily log to see if it contains a summary section;
#+ if so, append the summary to the run log and mail it to the admins
LOG_TEST=`cat $DAILY_LOG`
if [[ $LOG_TEST = *Number\ of\ files* ]]
then
	LOG_SUMMARY=`grep --after-context=999999 "Number of files:" "$DAILY_LOG"`
else
	LOG_SUMMARY="*** Invalid Daily Log - Summary Data Not Found ***"
fi

echo "###  $START_TIME" > /tmp/rsync_email.txt;echo "" >> /tmp/rsync_email.txt
echo "###  rsync From ""$SOURCEVOL"" TO ""$DESTVOL" >> /tmp/rsync_email.txt

echo "" >> /tmp/rsync_email.txt
echo "$LOG_SUMMARY"  >> /tmp/rsync_email.txt
MAILTEXT=`cat /tmp/rsync_email.txt`
echo "$MAILTEXT" | mail -s "[Anthem SF Archive rsync]" "$RECIPIENTS"

exit 0
#  A zero return value from the script upon exit indicates success
#+ to the shell.
