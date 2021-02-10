#!/bin/bash
# Set auto error checking
set -e

# AUTHOR : Arlene Kliewer
# TITLE: startapache.sh
# SHELL: bash
#
# NOTE: BASH shell requires -e for escape characters to work
# echo -e "Hello\nWorld"
#
# PURPOSE: Automates the starting of Apache & PHP installed by Homebrew
# For more instructions see brew info apache and brew info php
# ----------------------------------------------------------------------
# INCLUDE ANOTHER SCRIPT FILE IN THIS FILE
source amkFunctions.sh
# ----------------------------------------------------------------------
# MY VARIABLES
mySudoPwd="PurpleM00se"
# NOTE: sudo pwd must have a \n new line character at the end
# ----------------------------------------------------------------------
# ACTUAL WORK BEGINS
# ----------------------------------------------------------------------
# Use TextExpander Snippet, s s t e p
# ----------------------------------------------------------------------
stepName="Manual stop of Apache"
doThis="sudo apachectl stop"
echo -e "\t\t- $stepName"
amkDoCommand $stepName $doThis
# ----------------------------------------------------------------------
stepName="Manual stop of PHP"
doThis="sudo killall php-fpm"
echo -e "\t\t- $stepName"
amkDoCommand $stepName $doThis
# ----------------------------------------------------------------------
# HIGHLIGHT_AND_REPLACE_NEW_BLOCK_GOES_HERE

#

