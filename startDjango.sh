#!/bin/bash
# Set auto error checking
set -e

# AUTHOR : Arlene Kliewer
# TITLE: startDjango.sh
# SHELL: bash
#
# NOTE: BASH shell requires -e, in above third line, for escape characters to work
# echo -e "Hello\nWorld"
#
# PURPOSE: Starts the development Django server for RevRun project
#
# ----------------------------------------------------------------------
# INCLUDE ANOTHER SCRIPT FILE IN THIS FILE
source amkFunctions.sh
# ----------------------------------------------------------------------
# MY VARIABLES
#PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin
mySudoPwd="PurpleM00se"
#
# ----------------------------------------------------------------------
# ACTUAL WORK BEGINS
# ----------------------------------------------------------------------
# SET LOG FILE & PATH
#fName="_amkRestart.log" # File name variables must have quotes!
#stepName="Creating log file."
#makelog $fName
#amklog="$fName" # File name variables must have quotes!
# ----------------------------------------------------------------------
# TESTING IF COMMAND CONTAINS SUDO
#test4sudo
# ----------------------------------------------------------------------
# Use TextExpander Snippet, s s t e p
# ----------------------------------------------------------------------
dpath='/Users/akliewer/Repos-git/django_rev_run/revrun'
stepName="Change directory"
doThis="cd /Users/akliewer/Repos-git/django_rev_run/revrun"
echo -e "\t\t- $stepName"
#echo -e "\t\t- $stepName" >> $amklog
amkDoCommand $stepName $doThis
# ----------------------------------------------------------------------
stepName="START DJANGO DEV SERVER"
doThis="python3 $dpath/manage.py runserver"
echo -e "\t\t- $stepName"
#echo -e "\t\t- $stepName" >> $amklog
amkDoCommand $stepName $doThis
# ----------------------------------------------------------------------
# HIGHLIGHT_AND_REPLACE_NEW_BLOCK_GOES_HERE

#

