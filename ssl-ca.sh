#!/bin/bash
# Set auto error checking
set -e

# AUTHOR : Arlene Kliewer
# TITLE: SSL-Full.sh
# SHELL: bash
#
# NOTE: BASH shell requires -e for escape characters to work
# echo -e "Hello\nWorld"
#
# PURPOSE: AMK Quick Way to generate new SelfSigned SSL Certificates!
# Generate my own Certificate Authority (CA), Int Cert and Server Certificate

# ----------------------------------------------------------------------
# As of April 2019 - For instructions & explanations see
# ----------------------------------------------------------------------
# https://jamielinux.com/docs/openssl-certificate-authority/introduction.html
# - Modified to match new encryption requirements by Chrome brower
#
# ----------------------------------------------------------------------
# 2017-07-10 - modified some details from 
# ----------------------------------------------------------------------
# https://jamielinux.com/docs/openssl-certificate-authority/index.html
# - The index.txt file is where the OpenSSL ca tool stores the certificate database.
# - Do not delete or edit this file by hand.
# - It will contain a line that refers to the Int certificate.
#
# ----------------------------------------------------------------------
# INCLUDE ANOTHER SCRIPT FILE IN THIS FILE
# ----------------------------------------------------------------------
source amkFunctions.sh
# ----------------------------------------------------------------------
# REMEMBER VARIABLES IN BASH SCRIPTS
#		-	MUST NOT CONTAIN SPACES OUTSIDE QUOTES
# ----------------------------------------------------------------------
# CERTIFICATE DETAILS NEEDED: 
# ----------------------------------------------------------------------
fname="$1"
domain="$1"
sn="$2"
myCompany="$3"
myCommonName="$4"
servername="$4"
#
myDepart="develop - vpn"
myCity="Citrus Heights"
myState="California"
myCountry="US"
#
myPassPhrase=kastle7821022   # old phrase was misspelled myPassPhrase=kkastle7821002
mySudoPwd=PurpleM00se
myEmail="akliewer99@gmail.com"
# ----------------------------------------------------------------------
myDaysTL="7300" # Expires in 7300 days which = 20 years
# Expires in 3650 days which = 10 years
# ----------------------------------------------------------------------
# SYNTAX PARAMETERS EXPLAINED
# ----------------------------------------------------------------------
if [ $# -le 4 ] ; then
	echo -e "\nSYNTAX: sudo ssl-ca.sh domain serialNum companyName serverName ready\n" 
	echo -e "  REMEMBER:Must contain SUDO\n"
	echo -e "  "
	echo -e "  DOMAIN=kkastle.com \t(Must contain a dot extension like: .com)"
	echo -e "  SERIAL_NUM=900 \t\t(1Paassword:Maintains last SN used)"
	echo -e "  COMPANY_NAME=KKastle \t\t(No dot extensions like: .coms)"
	echo -e "  ServerName=newkirk \t\t(Actual Machine host name)"
	echo -e "  READY=ready \t\t\t(Start generating . . .)"
	echo -e ""
	echo -e "VERIFY CURRENT VALUES:"
	echo -e "  COMMON/FILE_NAME: $myCommonName \t<-DOMAIN_NAME"
	echo -e "  COMPANY: $myCompany \t\t\t\t<-CA_COMPANY_NAME"
	echo -e "  DEPART: $myDepart"
	echo -e "  CITY: $myCity"
	echo -e "  STATE: $myState"
	echo -e "  COUNTRY: $myCountry"
	echo -e "  EMAIL: $myEmail"
	echo -e "  EXPIRES: $myDaysTL \t\t\t<- Days:3650 = 10 years"
	echo -e ""
  exit ;
elif [ $# -eq 5 ] ; then
#
workingdir=`pwd`
# ----------------------------------------------------------------------
# ACTUAL WORK BEGINS
# ----------------------------------------------------------------------
# SET LOG FILE & PATH
fName="ssl-creation.log" # File name variables must have quotes!
makelog $fName
amklog="$fName" # File name variables must have quotes!
# ----------------------------------------------------------------------
echo -e "\n\tBEGIN: CREATING THE CERTIFICATE AUTHORITY (CA) CERTIFICATES" | tee -a $amklog ;
echo -e "\t------------------------------------------------------" | tee -a $amklog
# ----------------------------------------------------------------------
# TESTING FOR SUDO
test4sudo
# ----------------------------------------------------------------------
# SETTING VARIABLES FOR CA - Certificate Authority
# ----------------------------------------------------------------------
fnameRootKEY="ca.key.pem"
fnameRootCERT="ca.cert.pem"
fnameRootKEYinsecure="ca.insecure.key.pem"

# [CA_default]
# ----------------------------------------------------------------------
myDefaults="_dragNdrop"
ca_dir="_ca" ; makedir $ca_dir
certs="$ca_dir/certs" ; makedir $certs
crl_dir="$ca_dir/crl" ; makedir $crl_dir  # Cert Revocation Lists
new_certs_dir="$ca_dir/newcerts" ; makedir $new_certs_dir
ca_private="$ca_dir/private" ; makedir $ca_private
database="$ca_dir/index.txt" ; makelog $database
serial="$ca_dir/serial"  ; makelog $serial
RANDFILE="$ca_private/.rand"  ;  makelog $RANDFILE

# The root key and root certificate
# ----------------------------------------------------------------------
private_key="$ca_private/$fnameRootKEY"
certificate="$certs/$fnameRootCERT"

# For certificate revocation lists
# ----------------------------------------------------------------------
fnameRootCRL="ca.crl.pem"
crlnumber="$ca_dir/crlnumber"
crl="$crl_dir/$fnameRootCRL"
# ----------------------------------------------------------------------
echo 00 > $serial
stepName="THE STEP: Recording serial number"
echo -e "\n\t\t$stepName" | tee -a $amklog
echo $sn > $serial
echo -e "\t\t- Completed Successfully" | tee -a $amklog
# ----------------------------------------------------------------------
stepName="MAKING A NEW CONFIG FILE"
updateCA_SSLconfig
# ----------------------------------------------------------------------
stepName="Generating CA Private Key"
echo -e "\n\t\tTHE STEP: $stepName\n" 
createRootKey
# ----------------------------------------------------------------------
stepName="Generating CA Root Certificate"
echo -e "\n\t\tTHE STEP: $stepName\n" 
createRootCert
# ----------------------------------------------------------------------
#
echo -e "\n\t\tYAY!!! FINISHED CREATING CERTIFICATE AUTHORITY" | tee -a $amklog
echo -e "\t\t- Ready to test next step\n"
#
echo -e "" | tee -a $amklog
exit 
fi # After passing all tests, cut/paste from dotted line to mark below.
# ----------------------------------------------------------------------

