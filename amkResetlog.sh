#!/bin/bash
# Set auto error checking
set -e

# AUTHOR : Arlene Kliewer
# TITLE: amkResetlog.sh
# SHELL: bash
#
# NOTE: BASH shell requires -e for escape characters to work
# echo -e "Hello\nWorld"
#
# PURPOSE: Quick Way to reset amkRestart.log file
#
# ----------------------------------------------------------------------
# INCLUDE OTHER SCRIPTS:
#source amkFunctions.sh
#
# ----------------------------------------------------------------------
# MY VARIABLES
mySudoPwd="PurpleM00se"
fName="/var/log/amkRestart.log" # File name variables must have quotes!
amklog="$fName" # File name variables must have quotes!
#
# ----------------------------------------------------------------------
# ACTUAL WORK BEGINS
# ----------------------------------------------------------------------
# SET LOG FILE & PATH
stepName="Resetting the log file."
echo -e "\t\t- $stepName"
if [ -f $fName ] ; then 
     rm $fName 
     touch $fName ; 
else touch $fName 
fi
# 
sudo cp /var/log/amkRestart.amk /var/log/amkRestart.log