# File-Integrity-Check
A cronjob/bash script for determining whether or not files in a specified directory have been unintentionally or malicously modified.

Best used for a directory with stagnant files that will not be commonly changed

## Usage
1. Download the 'file_integrity.sh' file and place it in the directory of your choice
2. In your copy of 'file_integrity.sh', replace all directory instances (which can be located by searching for the keyword 'EXAMPLE') with your corresponding directories for logging and checking.
3. Execute the script once, and create a cronjob for the process.
   a. Example cronjob: 'boot * * * /my/dir/file_integrity.sh'
   
## Analysis
This program contains a number of shortcomings. Here are a few that I can think of:
* You are not notified when a file is changed, so you have to continuously check the log file to make sure nothing has changed
* It only does not descend into subdirectories, so you would need to replicate the file for each directory in which you need to verify the integrity of the files.
* If a file in the directory you are checking was modified on purpose, you would need to manually reset the 'file_integrity.sh' file and 'sums.txt' file

So, with all of those shortcomings, what is the point of this, you may ask? Well, this is my starting point in file integrity. I wanted to get a feel for bash scripting and file integrity, and this will be a great starting point for me to continue to build on, and hopefully a good first look for anyone else interested in these things.
