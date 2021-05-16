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
# INCLUDE ANOTHER SCRIPT FILE IN THIS FILE
source amkFunctions.sh
# ----------------------------------------------------------------------
# MY VARIABLES
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin
mySudoPwd="PurpleM00se"
#
# ----------------------------------------------------------------------
# ACTUAL WORK BEGINS
# ----------------------------------------------------------------------
# SET LOG FILE & PATH
fName="_amkRestart.log" # File name variables must have quotes!
stepName="Creating log file."
makelog $fName
amklog="$fName" # File name variables must have quotes!
# ----------------------------------------------------------------------
# TESTING IF COMMAND CONTAINS SUDO
test4sudo
# ----------------------------------------------------------------------
# TESTING NECESSARY COMMANDLINE PARAMETERS
if [ $# -le 1 ] ; then
	echo -e "\nSYNTAX: sudo amkBlank.sh \n" 
	echo -e "  REMEMBER:Must be run with SUDO.\n"
	echo -e "  EXAMPLE:"
	echo -e "  TagName=Version.00x \tMust match exact BitBucket.org/starfire/Tags spelling!!!"
	echo -e ""
  exit 
elif;
# ----------------------------------------------------------------------
# Use TextExpander Snippet, s s t e p
# ----------------------------------------------------------------------
stepName="RESTART SERVER"
doThis="sudo shutdown -r now"
echo -e "\t\t- $stepName"
echo -e "\t\t- $stepName" >> $amklog
amkDoCommand $stepName $doThis
# ----------------------------------------------------------------------
# HIGHLIGHT_AND_REPLACE_NEW_BLOCK_GOES_HERE

#

