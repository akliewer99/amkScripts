#!/bin/bash
# Set auto error checking
set -e

# AUTHOR : Arlene Kliewer
# TITLE: amkAutoRemove.sh
# SHELL: bash
#
# NOTE: BASH shell requires -e for escape characters to work
# echo -e "Hello\nWorld"
#
# PURPOSE: Nighly Remove Patches that are no longer needed!
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
stepName="AutoRemoved Unneccessary Files on ZATHRUS SERVER"
echo -e "\n\t\t- $(timestamp)-$stepName" >> $amklog 
echo -e "Y" | apt autoremove

