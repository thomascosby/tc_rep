#!/bin/bash
#
# revised 06.06.14 to work with GFS 1.0
#
echo -n "Enter a new Raster folder number : "
read newFldr
# validate the value entered
# composed of digits?
DIGITS='^[0-9]+$'
if ! [[ $newFldr =~ $DIGITS ]] ; then
	echo "ERROR: INVALID FOLDER NUMBER ENTERED (non-digit chars detected). EXITING." >&2; exit 1
fi
# is the  number entered between 1000 and 9999?
if [ $newFldr -lt 1000 -o $newFldr -gt 9999 ] ; then
	echo "ERROR: INVALID FOLDER NUMBER ENTERED (out of range). EXITING." >&2; exit 1
fi
# does the number entered end in "00"?
LAST2CHARS=${newFldr:${#newFldr} - 2}
if [ ! $LAST2CHARS = "00" ]; then
		echo "ERROR: INVALID FOLDER NUMBER ENTERED (must end in 00). EXITING." >&2; exit 1
fi
# is there already an asset folder with this number in the Gen Mills Baking?
if [ -d /mn_raid1/generalmills/PCBU93007/Images/Baking/Raster/$newFldr  ] ; then
	echo "ERROR: INVALID YEAR ENTERED (folder already exists in Gen Mills). EXITING." >&2; exit 1
fi

find /mn_raid*/*/PCBU93007/Images/Raster/ -maxdepth 0 -type d | grep -v 'Staging' | grep -v 'Promo' | grep -v '3rd Party Logos' | grep -v 'dummy' | grep -v 'zz_clienttemplate' | while read foundPath
do
   echo "creating: " $foundPath$newFldr
   mkdir -p "$foundPath/$newFldr"
   chgrp schawk_users "$foundPath/$newFldr"
   chmod 777 "$foundPath/$newFldr"
done


exit 0
#  A zero return value from the script upon exit indicates success
#+ to the shell.

