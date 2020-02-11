#!/bin/bash

# Generate the hashes for all of the files in the directory.
# Whenever you purposefully add or edit a file in the directory you are checking,
# you should delete the sums.txt file and execute this script immediately
# after the deletion (You should also check the log file to verify that
# no other files were unintentionally/maliciously modified before you).
SUMFILE=/home/user/Cyber/sums.txt
if [ ! -f "$SUMFILE" ]; then
    echo -e "MD5 Checksums for /home/user/Cyber/sums:\n" > $SUMFILE
    for i in /home/user/Cyber/sums/*
    do
        echo "File Name: " $i >> $SUMFILE
        md5sum $i | awk ' { print "MD5 Sum: " $1 } ' >> $SUMFILE
        echo "" >> $SUMFILE
    done
fi

# Regenerate the hashes for all of the files in the directory.
SUMCHECKFILE=/home/user/Cyber/sumCheck.txt
echo -e "MD5 Checksums for /home/user/Cyber/sums:\n" > $SUMCHECKFILE
for i in /home/user/Cyber/sums/*
do
	echo "File Name: " $i >> $SUMCHECKFILE
        md5sum $i | awk ' { print "MD5 Sum: " $1 } ' >> $SUMCHECKFILE
	echo "" >> $SUMCHECKFILE
done

# If the current hashes don't match the original, an error
# will be printed to your log file describing the changes.
LOGFILE=/home/user/Cyber/logs/cronSumLog.txt
# If log file has not been created, then create it. Otherwise,
# append to the already-created log file.
if [ ! -f "$LOGFILE" ]; then
    touch $LOGFILE
fi
if diff "$SUMCHECKFILE" "$SUMFILE" >/dev/null; then
    echo "No issues: " >> $LOGFILE
    date >> $LOGFILE
    echo "" >> $LOGFILE
    rm sumCheck.txt
else
    echo "WARNING: One or more files have been changed" >> $LOGFILE
    date >> $LOGFILE
    echo "Changes: " >> $LOGFILE
    diff "$SUMCHECKFILE" "$SUMFILE" >> $LOGFILE
    echo "" >> $LOGFILE
fi
