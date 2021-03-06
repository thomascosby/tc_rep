LOCK_FILE="/tmp/conagra_rsync.lock"
LOG_FILE="/usr/schawk/logs/rsync_conagra.log"
DAILY_LOG="/usr/schawk/logs/rsync_conagra_daily.log"
RSYNC="/usr/bin/rsync"
RECIPIENTS="dberks@schawk.com"

# NOTE: this script will delete files at ConAgra which don't exist at the Mpls end
#
# Dan B - 8.26.09

# source is opus in Minneapolis
SOURCEVOL="/mn_raid2/conagra"

# dest is "Minneapolis" dir on volume RTX4 volume at Schawk ConAgra
DESTVOL="204.76.125.131::rsyncmpls"

# ensure log files exist
touch $DAILY_LOG
touch $LOG_FILE

# reset daily log file
cat /dev/null > $DAILY_LOG

# prevent the script from continuing if was already running
# if script abends, need to manually delete the Lock file
# before the script can be run again
if [ -e $LOCK_FILE ]; then
	TIMESTAMP=$(date)
        echo "" >> $DAILY_LOG
	echo "$TIMESTAMP: lock file exists, exiting" >> $DAILY_LOG
        cat $DAILY_LOG >> $LOG_FILE
        mail -s "[Rsync - Mpls ConAgra to Schawk ConAgra]" $RECIPIENTS < $DAILY_LOG
	exit
fi
touch $LOCK_FILE

echo "" >> $DAILY_LOG
echo "###  RSYNC START  ###" >> $DAILY_LOG
date >> $DAILY_LOG

# perform rsync

$RSYNC -avzh --delete --max-delete=100 --timeout=180 --stats --exclude '/Assets/Staging/' --exclude '/dip/' --exclude '*/dip/' --exclude '/*/dip/' --exclude '/*/*/dip/' --exclude '/*/*/*/dip/' --exclude '*_P.psd' --exclude '*_p.psd' --exclude '*_P.PSD' --exclude '*_p.PSD' --exclude '*_P?.psd' --exclude '*_p?.psd' --exclude '*_P?.PSD' --exclude '*_p?.PSD' --exclude '*_P??.psd' --exclude '*_p??.psd' --exclude '*_P??.PSD' --exclude '*_p??.PSD' --exclude '*_P???.psd' --exclude '*_p???.psd' --exclude '*_P???.PSD' --exclude '*_p???.PSD' --exclude '.*' $SOURCEVOL/Assets "$DESTVOL" 2>&1 | tee >> $DAILY_LOG

echo "" >> $DAILY_LOG
date >> $DAILY_LOG
echo "###  RSYNC END  ###" >> $DAILY_LOG
echo "" >> $DAILY_LOG
cat $DAILY_LOG >> $LOG_FILE
mail -s "[Rsync - Mpls ConAgra to Schawk ConAgra]" $RECIPIENTS < $DAILY_LOG

rm $LOCK_FILE
