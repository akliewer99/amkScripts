#!/bin/bash
# Set auto error checking
set -e

# AUTHOR : Arlene Kliewer
# TITLE: startpoxy.sh
# SHELL: bash
#
# NOTE: BASH shell requires -e for escape characters to work
# echo -e "Hello\nWorld"
# REMEMBER: No spaces between var=value
#
# PURPOSE: Automates the starting of Google's Cloud mysql proxy server
# This server will be used locally to connect phpMyAdmin to the Cloud SQL
# ----------------------------------------------------------------------
# INCLUDE ANOTHER SCRIPT FILE IN THIS FILE
source amkFunctions.sh
# ----------------------------------------------------------------------
# MY VARIABLES
mydir="/tmp/cloudsql"
myinstances="revrun2020:us-central1:revrun2020mysql"
# TOO LONG
#mypath="/Users/akliewer/GCP-Keys/_Cloud SQL/SSL client certs/amk_mysql_ssl/rsa private key/cert_x.509"
mypath="/usr/privateKey"
mycredential_file="$mypath/revrun2020-91dfbcc2c8c5.json"
mySudoPwd="PurpleM00se\n"
# NOTE: sudo pwd must have a \n new line character at the end
# ----------------------------------------------------------------------
# ACTUAL WORK BEGINS
# ----------------------------------------------------------------------
# Use TextExpander Snippet, s s t e p
# ----------------------------------------------------------------------
stepName="Manual start of Cloud SQL Proxy"
doThis="cloud_sql_proxy -dir=$mydir \
						-instances=$myinstances=tcp:3306 \
						-credential_file=$mycredential_file"
echo -e "\t\t- $stepName"
amkDoCommand $stepName $doThis
# ----------------------------------------------------------------------
# HIGHLIGHT_AND_REPLACE_NEW_BLOCK_GOES_HERE

#

