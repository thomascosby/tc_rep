#!/bin/bash
#
####################################################
####################################################
####################################################
###########          Version 1.0          ##########
###########                               ##########31
###########   created by - Thomas Cosby   ##########
###########           2015 01 08          ##########
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
####################################################
#  
#  this script is to determine whether or not you have a lot of inactive memory
#+ then email the results to thomas

#  varibles
LOG_FILE="/usr/schawk/logs/mem.log"
DAILY_LOG="/usr/schawk/logs/mem_daily.log"
RECIPIENTS="thomas.cosby@schawk.com"
START_TIME=`date`
####################################################

touch $DAILY_LOG
touch $LOG_FILE
# reset daily log
cat /dev/null > $DAILY_LOG

echo "" >> $DAILY_LOG
echo "###  MemInfo Test: $START_TIME  ###" >> $DAILY_LOG

#  perform the meminfo command 
cat /proc/meminfo | tee >> $DAILY_LOG


END_TIME=`date`

echo "" >> $DAILY_LOG
echo "###  $END_TIME : Completed ###" >> $DAILY_LOG;echo "" >> $DAILY_LOG
echo "" >> $DAILY_LOG
cat $DAILY_LOG >> $LOG_FILE
echo "----------------------------------------------------" >> $LOG_FILE; echo "" >> $LOG_FILE
cat $LOG_FILE > tempfile
cat tempfile > $LOG_FILE
rm -f tempfile



#  test the daily log to see if it contains a summary section; if so, append the summary to the run log and mail it to the admins
LOG_TEST=`cat $DAILY_LOG`
if [[ $LOG_TEST = *MemTotal:* ]]
then
	LOG_SUMMARY=`grep --after-context=999999 "MemTotal:" "$DAILY_LOG"`
else
	LOG_SUMMARY="*** INVALID DAILY LOG - SUMMARY DATA NOT FOUND ***"
fi

echo "###  $START_TIME" > /tmp/mem_email.txt;echo "" >> /tmp/mem_email.txt
echo "###  Inactive Mem test" >> /tmp/mem_email.txt
echo "" >> /tmp/mem_email.txt
echo "$LOG_SUMMARY"  >> /tmp/mem_email.txt
MAILTEXT=`cat /tmp/mem_email.txt`
echo "$MAILTEXT" | mail -s "[Opus Inactive Memory Test Results]" "$RECIPIENTS"
#
#
exit 0
#  A zero return value from the script upon exit indicates success
#+ to the shell.
