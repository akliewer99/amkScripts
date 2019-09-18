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
mySudoPwd=PurpleM00se # For Git repo checkout only
ismParentPath="/home/iskymarshall/public_html/prod/node-apps"
bitBucketURL="https://akliewer:PurpleM00se@bitbucket.org/akliewer/starfire.git"
tagName=$1

# SET LOG FILE & PATH
fName="$ismParentPath/deployism.log" # File name variables must have quotes!
stepName="Creating log file."
amklog="$fName" # File name variables must have quotes!
# ----------------------------------------------------------------------
# FUNCTIONS INCLUDED FROM OTHER SCRIPT FILES
# ----------------------------------------------------------------------
source /usr/local/sbin/amkFunctions.sh
# ----------------------------------------------------------------------
# TEST COMMAND LINE OPTIONS- Make sure to have everything needed
# ----------------------------------------------------------------------
# TESTING FOR SUDO COMMAND
test4sudo
# ----------------------------------------------------------------------
# TESTING NECESSARY COMMANDLINE PARAMETERS
if [ $# -le 0 ] ; then
	echo -e "\nSYNTAX: sudo deployism.sh TagName\n" 
	echo -e "  REMEMBER: Must contain SUDO\n"
	echo -e "  EXAMPLE: TagName = Version-0.0.x\n"
	echo -e "  WARNING: TagName must match tags in BitBucket Repo EXACTLY"
	echo -e "  \t - Recommend verifying spelling by browsing Tags online"
	echo -e "  \t - At https://bitbucket.org/akliewer/starfire/src/master"
	echo -e "  \t - Click down arrow by MASTER to FILTER BY TAGS"
	echo -e ""
  exit
fi
# ----------------------------------------------------------------------
# ACTUAL WORK BEGINS
# ----------------------------------------------------------------------
makelog $fName
# ----------------------------------------------------------------------
checkIfexist
# ----------------------------------------------------------------------
stepName="Creating temp directory for bitbucket cloning"
doThis=`mkdir $ismParentPath/amkTemp`
amkDoCommand $stepName $doThis
echo -e "" | tee -a $ismParentPath/npm-install.log
# ----------------------------------------------------------------------
cd $ismParentPath/amkTemp
currWorking=`pwd`
# ----------------------------------------------------------------------
stepName="Cloning the BitBucket Branch with the Version Tag"
echo -e $stepName | tee -a $amklog
echo -e "" | tee -a $ismParentPath/npm-install.log
doThis=`git clone $bitBucketURL --branch $tagName`
amkDoCommand $stepName $doThis
# ----------------------------------------------------------------------
stepName="Moving $tagName "preferred" node-apps location"
doThis=`mv $ismParentPath/amkTemp/starfire/iSkyMarshal $ismParentPath/$tagName`
amkDoCommand $stepName $doThis
# ----------------------------------------------------------------------
stepName="Changing $tagName file PERMISSIONS"
doThis=`chmod -R 777 $ismParentPath/$tagName`
amkDoCommand $stepName $doThis
# ----------------------------------------------------------------------
stepName="Changing $tagName file OWNERSHIP"
doThis=`chown -R iskymarshall:iskymarshall $ismParentPath/$tagName`
amkDoCommand $stepName $doThis
# ----------------------------------------------------------------------
stepName="Removing Temporary Directory."
doThis=`rm -R $ismParentPath/amkTemp`
amkDoCommand $stepName $doThis
# ----------------------------------------------------------------------
cd $ismParentPath/$tagName
currWorking=`pwd`
# ----------------------------------------------------------------------
stepName="Creating "node_modules" directory for npm local modules"
doThis=`mkdir $ismParentPath/$tagName/node_modules`
amkDoCommand $stepName $doThis
# ----------------------------------------------------------------------
stepName="Changing "node_modules" PERMISSIONS"
doThis=`chmod -R 777 $ismParentPath/$tagName/node_modules`
amkDoCommand $stepName $doThis
# ----------------------------------------------------------------------
stepName="\n\t\tTHE STEP: Installing npm local modules"
echo -e $stepName | tee -a $ismParentPath/npm-install.log
echo -e "" | tee -a $ismParentPath/npm-install.log
npm install | tee -a $ismParentPath/npm-install.log
echo -e $stepName | tee -a $amklog
echo -e "\t\t- Completed Successfully" | tee -a $amklog
# ----------------------------------------------------------------------
stepName="\n\t\tTHE STEP: Running npm audit fix"
echo -e $stepName | tee -a $ismParentPath/npm-install.log
echo -e "" | tee -a $ismParentPath/npm-install.log
npm audit fix | tee -a $ismParentPath/npm-install.log
echo -e $stepName | tee -a $amklog
echo -e "\t\t- Completed Successfully" | tee -a $amklog
# ----------------------------------------------------------------------
stepName="Making NEW symbolic link."
doThis=`ln -s $ismParentPath/$tagName $ismParentPath/ism`
amkDoCommand $stepName $doThis
echo -e "" | tee -a $ismParentPath/npm-install.log
# ----------------------------------------------------------------------
stepName="\n\t\tTHE STEP: Performed First Gulp Build"
gulp build
echo -e $stepName | tee -a $amklog
echo -e "\t\t- Completed Successfully" | tee -a $amklog
# ----------------------------------------------------------------------
echo -e "\n\t\tYAY - FINISHED!!!\n"
echo -e "\t\t- The NEW $tagName of iSkyMarshall is ready to go!"
echo -e "\t\t- Access new version by "Refreshing/Reloading" your browser\n\n"
#
exit ; # After passing all tests, cut/paste from dotted line to mark below.
