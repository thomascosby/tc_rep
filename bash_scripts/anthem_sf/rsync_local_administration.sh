#!/bin/bash
####################################################
####################################################
####################################################
###########          Version 1.0          ##########
###########                               ##########
###########   created by - Thomas Cosby   ##########
###########           2013 11 20          ##########
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
###########      Current Version 2.0      ##########
###########                               ##########
####################################################
####################################################
####################################################
#  Version History
#  v1.0 - 11.20.13 - T Cosby
#  v1.1 - 11.21.13 - T Cosby - improved logging & email notification
#  v2.0 - 20140917 - tcosby - improved exclude from line to use a list rather than
#+ individual names.
###########################################################
#  RSYNC Administration to Administration_BU

TIMESTAMP=`date '+%m.%d.%y-%H.%M'`
DAILY_LOG="/Library/Logs/rsync/rsync_local_administration_"$TIMESTAMP".log"
RUN_LOG="/Library/Logs/rsync/rsync_local_administration.log"
LOCK_FILE="/tmp/rsync_local_administration.lock"
RSYNC="/usr/local/bin/rsync"
RECIPIENTS="tholm@schawk.com,chause@schawk.com,thomas.cosby@schawk.com"
#RECIPIENTS="thomas.cosby@schawk.com"

touch $RUN_LOG
touch $DAILY_LOG
# uncomment next line to reset main log
# cat /dev/null > $RUN_LOG

# prevent the script from continuing if was already running
# if script abends or server crashes, you must manually delete the Lock file

if [ -f $LOCK_FILE ]; then
	TIMESTAMP=$(date)
        echo "" >> $DAILY_LOG
	    echo "$TIMESTAMP: ERROR - lock file exists, exiting" >> $DAILY_LOG
        echo "$TIMESTAMP: ERROR - lock file exists, exiting" >> $RUN_LOG
        mail -s "[ASF Local rsync Admin Volume] - ERROR]" $RECIPIENTS < $DAILY_LOG
	exit
fi
touch $LOCK_FILE

SOURCEVOL=/Volumes/10TB_RAID/Administration/
DESTVOL=/Volumes/3TB_R01A/Administration_BU/
START_TIME=`date`
echo "###  $START_TIME" >> $DAILY_LOG
echo "###  $START_TIME" >> $RUN_LOG
echo "###  START RSYNC ""$SOURCEVOL"" TO ""$DESTVOL" >> $DAILY_LOG
echo "###  START RSYNC ""$SOURCEVOL"" TO ""$DESTVOL" >> $RUN_LOG

if [ -d "$SOURCEVOL" -a -d "$DESTVOL" ]
then
#  uncomment to perform dry run rsync
   #$RSYNC -avhun --delete --max-delete=5000 --stats --exclude-from '/Library/Scripts/Schawk/asf_rsync_exclude_list.txt' "$SOURCEVOL" "$DESTVOL" 2>&1 >> $DAILY_LOG
#  perform for reals rsync
   $RSYNC -avhu --stats --delete --max-delete=5000 --exclude-from '/Library/Scripts/Schawk/asf_rsync_exclude_list.txt' $SOURCEVOL $DESTVOL 2>&1 >> $DAILY_LOG
else 
   echo "*** ERROR IN ADMINISTRATION RSYNC - SOURCE OR DEST PATH NOT FOUND ***" >> $DAILY_LOG
fi
END_TIME=`date`

echo "" >> $DAILY_LOG
echo "" >> $RUN_LOG
echo "###  END RSYNC: ""$SOURCEVOL"" TO ""$DESTVOL" >> $DAILY_LOG
echo "###  $END_TIME" >> $DAILY_LOG
echo "" >> $DAILY_LOG
echo "" >> $RUN_LOG

# test the daily log to see if it contains a summary section; if so, append the summary to
# the run log and mail it to the admins
LOG_TEST=`cat $DAILY_LOG`
if [[ $LOG_TEST = *Number\ of\ files* ]]
then
	LOG_SUMMARY=`grep --after-context=999999 "Number of files:" "$DAILY_LOG"`
else
	LOG_SUMMARY="*** INVALID DAILY LOG - NO SUMMARY DATA ***"
fi
echo "$LOG_SUMMARY" >> $RUN_LOG
echo "----------------------------------------------------" >> $RUN_LOG; echo "" >> $RUN_LOG
echo "###  $START_TIME" > /tmp/rsync_email.txt
echo "###  START RSYNC ""$SOURCEVOL"" TO ""$DESTVOL" >> /tmp/rsync_email.txt
echo "" >> /tmp/rsync_email.txt
echo "$LOG_SUMMARY"  >> /tmp/rsync_email.txt
MAILTEXT=`cat /tmp/rsync_email.txt`
echo "$MAILTEXT" | mail -s "[ASF Local rsync Admin Volume]" "$RECIPIENTS"

# delete daily logs older than two weeks
find /Library/Logs/rsync/rsync_local_administration_*log -mtime +14 -exec rm {} \;

rm -f $LOCK_FILE

exit 0
#  A zero return value from the script upon exit indicates success
#+ to the shell.