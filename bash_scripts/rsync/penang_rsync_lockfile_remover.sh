#!/bin/bash

# This script deletes any lock files orphaned by the unexpected crash of any of the 
# Penang_Rsync scripts. A copy of this script will be put into /etc/profile.d/ which 
# ensures it will be run at server startup.

rm -f /tmp/rsync*lock

#
#
exit 0
#  A zero return value from the script upon exit indicates success
#+ to the shell.