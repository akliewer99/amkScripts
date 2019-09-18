#!/bin/bash
# Set auto error checking
set -e

# AUTHOR : Arlene Kliewer
# TITLE: amkRestart.sh
# SHELL: bash
#
# NOTE: BASH shell requires -e for escape characters to work
# echo -e "Hello\nWorld"
#
# PURPOSE: Nighly Server Restart in order to Incorporate the Last Upgrades!
#
# ----------------------------------------------------------------------
# MY VARIABLES
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin
mySudoPwd="PurpleM00se"
fName="/var/log/amkRestart.log" # File name variables must have quotes!
amklog="$fName" # File name variables must have quotes!
#
# Define a timestamp function
timestamp() {
  date +"%Y-%m-%d @-> %H:%M:%S"
}
# ----------------------------------------------------------------------
# ACTUAL WORK BEGINS
# ----------------------------------------------------------------------
 # SET LOG FILE & PATH
stepName="Creating log file."
if [ ! -f $fName ] ; then touch $fName ; fi
#
# ----------------------------------------------------------------------
stepName="RESTARTED ZATHRUS SERVER"
echo -e "\t\t- $(timestamp)-$stepName" >> $amklog 
shutdown -r now
#echo $mySudoPwd | sudo shutdown -r now

