#!/bin/bash
# Set auto error checking
set -e
# AUTHOR : Arlene Kliewer
# TITLE: deployism.sh
# PURPOSE: To automate the deployment process for the Ubuntu 16 on the Newkirk system.
#
#
# NOTE: BASH shell requires -e for escape characters to work
# echo -e "Hello\nWorld"
#
# ----------------------------------------------------------------------
# MY VARIABLES
# ----------------------------------------------------------------------
# mySudoPwd="PurpleM00se"
ismParentPath=/home/iskymarshall/public_html/prod/node-apps
bitBucketURL=https://akliewer@bitbucket.org/akliewer/starfire.git
tagName=$1

# ----------------------------------------------------------------------
# MY ALIASES
# ----------------------------------------------------------------------
goto_ismPath=`cd $ismParentPath/$tagName`
#goto_amkTemp=`cd $ismParentPath/amkTemp`
##

# SET LOG FILE & PATH
fName="./deployism.log" # File name variables must have quotes!
stepName="Creating log file."
amklog="$fName" # File name variables must have quotes!
# ----------------------------------------------------------------------
# FUNCTIONS INCLUDED FROM OTHER SCRIPT FILES
# ----------------------------------------------------------------------
source amkFunctions.sh
# ----------------------------------------------------------------------
# TEST COMMAND LINE OPTIONS- Make sure to have everything needed
# ----------------------------------------------------------------------
# TESTING FOR SUDO COMMAND
test4sudo
# ----------------------------------------------------------------------
# TESTING NECESSARY COMMANDLINE PARAMETERS
if [ $# -le 1 ] ; then
	echo -e "\nSYNTAX: sudo deployism.sh TagName\n" 
	echo -e "  REMEMBER:Must be run with SUDO.\n"
	echo -e "  EXAMPLE:"
	echo -e "  TagName=Version.00x \tMust match exact BitBucket.org/starfire/Tags spelling!!!"
	echo -e ""
  exit 
elif;
# ----------------------------------------------------------------------
# ACTUAL WORK BEGINS
# ----------------------------------------------------------------------
makelog $fName
# ----------------------------------------------------------------------
stepName="Create temp directory for checkout"
doThis="mkdir -p $ismParentPath/amkTemp"
echo -e "\t\t- $stepName" | tee -a $amklog
amkDoCommand $stepName $doThis
# ----------------------------------------------------------------------
goto_amkTemp=`cd $ismParentPath/amkTemp`
# ----------------------------------------------------------------------
stepName="Change into amkTemp directory"
doThis="goto_amkTemp"
echo -e "\t\t- $stepName" | tee -a $amklog
amkDoCommand $stepName $doThis
# ----------------------------------------------------------------------
stepName="Git Clone Branch"
doThis="git clone --branch $tagName"
echo -e "\t\t- $stepName" | tee -a $amklog
amkDoCommand $stepName $doThis
# ----------------------------------------------------------------------
$goto_ismPath
#
echo -e "\tThis command passed the test."
echo -e "\tThis script is now exiting\n"
#
exit # After passing all tests, cut/paste from dotted line to mark below.
# ----------------------------------------------------------------------
# HIGHLIGHT_AND_REPLACE_NEW_BLOCK_GOES_HERE
# ----------------------------------------------------------------------
stepName="Update npm globals"
doThis="npm install -g npm"
echo -e "\t\t- $stepName" | tee -a $amklog
amkDoCommand $stepName $doThis
# ----------------------------------------------------------------------
stepName="Change permissions"
doThis="chmod -R $ismPath"
echo -e "\t\t- $stepName" | tee -a $amklog
amkDoCommand $stepName $doThis
# ----------------------------------------------------------------------
#
echo -e "\tThis command passed the test."
echo -e "\tThis script is now exiting\n"
#
exit # After passing all tests, cut/paste from dotted line to mark below.
# ----------------------------------------------------------------------
# HIGHLIGHT_AND_REPLACE_NEW_BLOCK_GOES_HERE
# ----------------------------------------------------------------------

