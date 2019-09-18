#!/bin/bash
# Set auto error checking
set -e

# AUTHOR : Arlene Kliewer
# TITLE: ssl-int.sh
# SHELL: bash
#
# NOTE: BASH shell requires -e for escape characters to work
# echo -e "Hello\nWorld"
#
# PURPOSE: AMK Quick Way to generate new SelfSigned SSL Certificates!
# Generate my own Intermediate and Server Certificate
#
# ----------------------------------------------------------------------
# As of April 2019 - For instructions & explanations see
# ----------------------------------------------------------------------
# https://jamielinux.com/docs/openssl-certificate-authority/introduction.html
# - Modified to match new encryption requirements by Chrome brower
#
# ----------------------------------------------------------------------
# INCLUDE ANOTHER SCRIPT FILE
# ----------------------------------------------------------------------
source amkFunctions.sh
# ----------------------------------------------------------------------
# REMEMBER:
#		- Bash variables MUST NOT contain spaces outside quotes
# ----------------------------------------------------------------------
# CERTIFICATE DETAILS NEEDED
# ----------------------------------------------------------------------
fname="$1"
domain="$1"
sn="$2"
myCompany="$3"
# Must be different than CA Common Name
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
myDaysTL="5475" # Expires in 15 years * 365 days
# 
# ----------------------------------------------------------------------
# SET LOG FILE & PATH
fName="ssl-creation-INT.log" # File name variables must have quotes!
makelog $fName
amklog="$fName" # File name variables must have quotes!
# ----------------------------------------------------------------------
# SYNTAX PARAMETERS EXPLAINED
# ----------------------------------------------------------------------
if [ $# -le 4 ] ; then
	echo -e "\nSYNTAX: sudo ssl-int.sh domain serialNum companyName serverName ready\n" 
	echo -e "  REMEMBER:Must contain SUDO\n"
	echo -e "  "
	echo -e "  DOMAIN=kkastle.com \t(Must contain a dot extension like: .com)"
	echo -e "  SERIAL_NUM=900 \t\t(1Paassword:Maintains last SN used)"
	echo -e "  COMPANY_NAME=KKastle \t\t(MUST NOT MATCH CERT.AUTH. / No dot extensions like: .coms)"
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
		echo -e "\n\tBEGIN: CREATING INTERMEDIATE CERTIFICATES" | tee -a $amklog ;
		echo -e "\t------------------------------------------------------" | tee -a $amklog
		# ----------------------------------------------------------------------
		# TESTING FOR SUDO
		test4sudo
		# ----------------------------------------------------------------------
		# SETTING VARIABLES FOR INTERMEDIATE CERTIFICATES
		# ----------------------------------------------------------------------
		# CA VARIABLES
		fnameRootKEY="ca.priv.key.pem"
		fnameRootCERT="ca.cert.pem"
		fnameRootKEYinsecure="ca.insecure.key.pem"
		#
		# INTERMEDIATE VARIABLES
		fnameIntKEY="int.key.pem"
		fnameIntCERT="int.cert.pem"
		#fnameIntKEYinsecure="int.insecure.key.pem"
		#
		fnameIntCSR="int.csr.pem"  # Cert Signing Request
		fnameIntCRL="int.crl.pem"
		#
		# CA CHAIN CERTIFICATE VARIABLES
		fnameCAChainCERT="ca-chain.cert.pem"
		#
		# SERVER VARIABLES
		fnameServerKEY="$fname.server.PrivKey.pem"
		fnameServerCSR="$fname.server.csr.pem"
		fnameServerCERT="$fname.server.cert.pem"
		#
		fnameServerKEYinsecure="$fname.server.PrivKey.insecure.pem"
		fnameServerKEYsecure="$fname.server.PrivKey.secure.pem"
		#		
		# [Intermediate Default]
		# ----------------------------------------------------------------------
		myDefaults="_dragNdrop"
		# ----------------------------------------------------------------------
		echo -e "\n\t\tTHE STEP: Making directories"  | tee -a $amklog 
		int_dir="_int" ; makedir $int_dir
		certs="$int_dir/certs" ; makedir $certs
		crl_dir="$int_dir/crl" ; makedir $crl_dir  # Cert Revocation Lists
		new_certs_dir="$int_dir/newcerts" ; makedir $new_certs_dir
		int_private="$int_dir/private" ; makedir $int_private
		csr="$int_dir/csr" ; makedir $csr
		# ----------------------------------------------------------------------
		database="$int_dir/index.txt" ; makelog $database
		serial="$int_dir/serial"  ; makelog $serial
		RANDFILE="$int_private/.rand"  ;  makelog $RANDFILE

		# The root key and root certificate
		# ----------------------------------------------------------------------
		private_key="$int_private/$fnameIntKEY"
		certificate="$certs/$fnameIntCRT"

		# For certificate revocation lists
		# ----------------------------------------------------------------------
		crlnumber="$int_dir/crlnumber"
		crl="$crl_dir/$fnameIntCRL"
		# ----------------------------------------------------------------------
		# ACTUAL WORK BEGINS
		# ----------------------------------------------------------------------
		echo 00 > $serial
		stepName="THE STEP: Recording serial number"
		echo -e "\n\t\t$stepName" | tee -a $amklog
		echo $sn > $serial
		echo -e "\t\t- Completed Successfully" | tee -a $amklog
		# ----------------------------------------------------------------------
		stepName="MAKING A NEW CONFIG FILE"
		updateInt_SSLconfig
		# ----------------------------------------------------------------------
		stepName="Generating INTERMEDIATE Private Key"
		echo -e "\n\t\tTHE STEP: $stepName\n" 
		createIntKey
		# ----------------------------------------------------------------------
		stepName="Creating a Intermediate Certificate Signing Request"
		echo -e "\n\t\tTHE STEP: $stepName\n" 
		createIntCSR
		# ----------------------------------------------------------------------
		stepName="Creating a Intermediate Certificate"
		echo -e "\n\t\tTHE STEP: $stepName\n" 
		createIntCERT
		# ----------------------------------------------------------------------
		stepName="Creating the CA CHAIN file"
		doThis=`cat $certs/$fnameIntCERT _ca/certs/ca.cert.pem \
						> $certs/$fnameCAChainCERT`
		amkDoCommand $stepName $doThis
		# ----------------------------------------------------------------------
		#
		echo -e "\n\t\tYAY!!! FINISHED CREATING INTERMEDIATE CERTIFICATE" | tee -a $amklog
		echo -e "\t\t- Ready to test next step\n"
		#
		echo -e "" | tee -a $amklog
fi 
exit ; 

