#!/bin/bash
# Set auto error checking
set -e

# AUTHOR : Arlene Kliewer
# TITLE: remove.sh
# SHELL: bash
#
# NOTE: BASH shell requires -e for escape characters to work
# echo -e "Hello\nWorld"
#
# PURPOSE: AMK Quick Way to delete files, so testing can continue

# INCLUDE ANOTHER SCRIPT FILE IN THIS FILE
source amkFunctions.sh
# ----------------------------------------------------------------------
# ACTUAL WORK BEGINS
# ----------------------------------------------------------------------
# SET LOG FILE & PATH
stepName="Creating log file."
echo -e "\t\t- $stepName"
fName="amk.log" # File name variables must have quotes!
if [ -f $fName ] ; then rm $fName ; fi
# ----------------------------------------------------------------------
echo -e "\n\tREMOVING ALL CERTIFICATES & KEYS"
# ----------------------------------------------------------------------
stepName="Removing Certificate Database"
echo -e "\t\t- $stepName"
fName="index.txt" # File name variables must have quotes!
if [ -f $fName ] ; then rm $fName ; fi
# ----------------------------------------------------------------------
stepName="Removing CA private key"
fName="KKastle.CA.PrivKey.pem"
echo -e "\t\t- $stepName"
if [ -f $fName ] ; then rm $fName ; fi
# ----------------------------------------------------------------------
stepName="Removing CA Private Insecure Key"
fName="KKastle.CA.PrivKey.insecure.pem"
echo -e "\t\t- $stepName"
if [ -f $fName ] ; then rm $fName ; fi
# ----------------------------------------------------------------------
stepName="Removing CA Certificate"
fName="KKastle.CA.CRT.pem"
echo -e "\t\t- $stepName"
if [ -f $fName ] ; then rm $fName ; fi
# ----------------------------------------------------------------------
stepName="Remove OpenSSL Configuration File"
fName="openssl.cnf"
echo -e "\t\t- $stepName"
if [ -f $fName ] ; then rm $fName ; fi
# ----------------------------------------------------------------------
stepName="Removing the CA Intermediate Private Key"
fName="kkastle.com.Intermediate.PrivKey.pem"
echo -e "\t\t- $stepName"
if [ -f $fName ] ; then rm $fName ; fi
# ----------------------------------------------------------------------
stepName="Removing the CA Intermediate Private Insecure Key"
fName="kkastle.com.Intermediate.PrivKey.insecure.pem"
echo -e "\t\t- $stepName"
if [ -f $fName ] ; then rm $fName ; fi
# ----------------------------------------------------------------------
stepName="Removing the CA Intermediate CSR"
fName="kkastle.com.Intermediate.csr"
echo -e "\t\t- $stepName"
if [ -f $fName ] ; then rm $fName ; fi
# ----------------------------------------------------------------------
# HIGHLIGHT_AND_REPLACE_NEW_BLOCK_GOES_HERE
# ----------------------------------------------------------------------
echo "" # REMEMBER 3 name stmts one for the block, one for the screen, the last for the log file.
#
echo -e "\tThis script has completed successfully!"
echo -e "\tThis script is now exiting\n"
#
exit # After passing all tests, cut/paste from dotted line to mark below.
