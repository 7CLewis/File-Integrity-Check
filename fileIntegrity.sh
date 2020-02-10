#!/bin/bash

# Generate the hashes for all of the files in the directory.
# Whenever you purposefully add or edit a file in the directory you are checking,
# you should delete the sums.txt file and execute this script immediately
# after the deletion (You should also check the log file to verify that
# no other files were unintentionally/maliciously modified before you).
FILE=/example/dir/logging/sums.txt
if [ ! -f "$FILE" ]; then
    echo -e "MD5 Checksums for /home/user/Cyber/sums:\n" > /example/dir/logging/sums.txt
    for i in /example/dir/dir-to-check/*
    do
        echo "File Name: " $i >> /example/dir/logging/sums.txt
        md5sum $i | awk ' { print "MD5 Sum: " $1 } ' >> /example/dir/logging/sums.txt
        echo "" >> /example/dir/logging/sums.txt
    done
fi

# Regenerate the hashes for all of the files in the directory.
echo -e "MD5 Checksums for /home/user/Cyber/sums:\n" > /example/dir/logging/sumCheck.txt
for i in /example/dir/dir-to-check/*
do
	echo "File Name: " $i >> /example/dir/logging/sumCheck.txt
        md5sum $i | awk ' { print "MD5 Sum: " $1 } ' >> /example/dir/logging/sumCheck.txt
	echo "" >> /example/dir/logging/sumCheck.txt
done

# If the current hashes don't match the original, an error
# will be printed to your log file describing the changes.
if diff "/example/dir/logging/sumCheck.txt "/example/dir/logging/sums.txt" >/dev/null; then
    echo "No issues: " >> /example/dir/logging/sumLog.txt
    date >> /example/dir/logging/sumLog.txt
    echo "" >> /example/dir/logging/sumLog.txt
    rm /example/dir/logging/sumCheck.txt
else
    LOGFILE=/example/dir/logging/sumLog.txt
    # If log file has not been created, then create it. Otherwise,
    # append to the already-created log file.
    if [ ! -f "$LOGFILE" ]; then
        echo "WARNING: One or more files have been changed" > /example/dir/logging/sumLog.txt
    else
        echo "WARNING: One or more files have been changed" > /example/dir/logging/sumLog.txt
    fi
    date >> /home/user/Cyber/logs/cronSumLog.txt
    echo "Changes: " >> /home/user/Cyber/logs/cronSumLog.txt
    diff "/home/user/Cyber/sumCheck.txt" "/home/user/Cyber/sums.txt" >> /home/user/Cyber/logs/cronSumLog.txt
    echo "" >> /home/user/Cyber/logs/cronSumLog.txt
fi

# If the current hashes don't match the original, an error
# will be printed to your log file describing the changes.
if diff "/home/user/Cyber/sumCheck.txt" "/home/user/Cyber/sums.txt" >/dev/null; then
    echo "No issues: " >> /home/user/Cyber/logs/cronSumLog.txt
    date >> /home/user/Cyber/logs/cronSumLog.txt
    echo "" >> /home/user/Cyber/logs/cronSumLog.txt
    rm sumCheck.txt
else
    LOGFILE=/home/user/Cyber/logs/cronSumLog.txt
    # If log file has not been created, then create it. Otherwise,
    # append to the already-created log file.
    if [ ! -f "$LOGFILE" ]; then
        echo "WARNING: One or more files have been changed" > /home/user/Cyber/logs/cronSumLog.txt
    else
        echo "WARNING: One or more files have been changed" > /home/user/Cyber/logs/cronSumLog.txt
    fi
    date >> /home/user/Cyber/logs/cronSumLog.txt
    echo "Changes: " >> /home/user/Cyber/logs/cronSumLog.txt
    diff "/home/user/Cyber/sumCheck.txt" "/home/user/Cyber/sums.txt" >> /home/user/Cyber/logs/cronSumLog.txt
    echo "" >> /home/user/Cyber/logs/cronSumLog.txt
fi
