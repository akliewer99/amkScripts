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
# Generate my own Certificate Authority (CA), Intermediate Cert and Server Certificate

# 2017-07-10 - modified some details from https://jamielinux.com/docs/openssl-certificate-authority/index.html
# - The index.txt file is where the OpenSSL ca tool stores the certificate database.
# - Do not delete or edit this file by hand.
# - It will contain a line that refers to the Intermediate certificate.

# INCLUDE ANOTHER SCRIPT FILE IN THIS FILE
source amkScriptLibrary.sh
# ----------------------------------------------------------------------
# CERTIFICATE DETAILS NEEDED: 
myDaysTL="3650" # Expires in 3650 days which = 10 years
# ----------------------------------------------------------------------
#	SYNTAX: sudo ssl-full.sh Domain SerialNum CompanyName ServerName ready\n" 
myCompany="$3 Certificate Authority"
myCommonName="$3 Root CA"
#
myDepart="R & D"
myCity="Roseville"
myState="California"
myCountry="US"
#
myPassPhrase="kastle7821022"
myEmail="akliewer99@gmail.com"
#
mySudoPwd="PurpleM00se"
#
fname="$1"
servername="$4"
sn="$2"
myCompany="$3"
myCommonName="$4.$fname"
# ----------------------------------------------------------------------
# TESTING NECESSARY COMMANDLINE PARAMETERS
if [ $# -le 4 ] ; then
	echo -e "\nSYNTAX: sudo ssl-full.sh domain serialNum companyName serverName ready\n" 
	echo -e "  REMEMBER:Must be run with SUDO.\n"
	echo -e "  EXAMPLE:"
	echo -e "  DOMAIN=kkastle.com \t(Must contain a dot extension like: .com)"
	echo -e "  SERIAL_NUM=900 \t\t(1Paassword:Maintains last SN used)"
	echo -e "  COMPANY_NAME=KKastle \t\t(No dot extensions like: .coms)"
	echo -e "  ServerName=newkirk \t\t(Actual Machine host name)"
	echo -e "  READY=ready \t\t\t(Starts the generation)"
	echo -e ""
	echo -e "VERIFY CURRENT VALUES:"
	echo -e "  COMMON/FILE_NAME: $myCommonName \t<-DOMAIN_NAME"
	echo -e "  COMPANY: $myCompany \t\t\t\t<-CA_COMPANY_NAME"
	echo -e "  DEPART: $myDepart"
	echo -e "  CITY: $myCity"
	echo -e "  STATE: $myState"
	echo -e "  COUNTRY: $myCountry"
	echo -e ""
	echo -e "  PASS_PHRASE: $myPassPhrase "
	echo -e "  EMAIL: $myEmail"
	echo -e ""
	echo -e "  EXPIRES: $myDaysTL \t\t\t\t<- Days:3650 = 10 years"
#	echo -e "  SudoPwd: $mySudoPwd"
	echo -e ""
  exit ;
elif [ $# -eq 5 ] ; then
#
workingdir=`pwd`
#
fnameRootKEY="$3.CA.PrivKey.pem"
fnameRootKEYinsecure="$3.CA.PrivKey.insecure.pem"
fnameRootKEYsecure="$3.CA.PrivKey.secure.pem"
fnameRootCRT="$3.CA.CRT.pem"
#
fnameIntermediateKEY="$fname.Intermediate.PrivKey.pem"
fnameIntermediateCSR="$fname.Intermediate.csr"
fnameIntermediateCRT="$fname.Intermediate.CRT.pem"
#
fnameIntermediateKEYinsecure="$fname.Intermediate.PrivKey.insecure.pem"
fnameIntermediateKEYsecure="$fname.Intermediate.PrivKey.secure.pem"
#
fnameCAChainCRT="$fname.CAChain.CRT.pem"
#
fnameServerKEY="$fname.server.PrivKey.pem"
fnameServerCSR="$fname.server.csr"
fnameServerCRT="$fname.server.CRT.pem"
#
fnameServerKEYinsecure="$fname.server.PrivKey.insecure.pem"
fnameServerKEYsecure="$fname.server.PrivKey.secure.pem"
#
# ----------------------------------------------------------------------
# ACTUAL WORK BEGINS
# ----------------------------------------------------------------------
# SET LOG FILE & PATH
amklog="amk.log" # File name variables must have quotes!
stepName="Creating log file."
makelog
# ----------------------------------------------------------------------
echo -e "\n\tBEGIN: CREATION OF SSL Certificates . . ."
echo -e "\n\tBEGIN: CREATION OF SSL Certificates . . ." >> $amklog
echo -e "\t\t- $stepName"
echo -e "\t\t- $stepName" >> $amklog
# ----------------------------------------------------------------------
# TESTING IF COMMAND CONTAINS SUDO
test4sudo
echo -e "\n\tGENERATING ROOT CERTIFICATE AUTHORITY"
echo -e "\n\tGENERATING ROOT CERTIFICATE AUTHORITY" >> $amklog
# ----------------------------------------------------------------------
if [ -f openssl.cnf ] ; then sudo rm openssl.cnf ; fi
# ----------------------------------------------------------------------
# Copy empty file to openssl.cnf file
stepName="Creating the SSL config file."
doThis="cp empty_openssl.cnf openssl.cnf"
echo -e "\t\t- $stepName"
echo -e "\t\t- $stepName" >> $amklog
amkDoCommand $stepName $doThis
# ----------------------------------------------------------------------
# Copy Current Vaules to openssl.cnf file
stepName="Adding current values to config file."
echo -e "\t\t- $stepName"
echo -e "\t\t- $stepName" >> $amklog
#
doThis="`echo countryName_default=$myCountry >> openssl.cnf`"
amkDoCommand $stepName $doThis
#
doThis="`echo stateOrProvinceName_default="$myState" >> openssl.cnf`"
amkDoCommand $stepName $doThis
#
doThis="`echo localityName_default="$myCity" >> openssl.cnf`"
amkDoCommand $stepName $doThis
#
doThis="`echo organizationalUnitName_default="$myCompany Certificate Authority" >> openssl.cnf`"
amkDoCommand $stepName $doThis
#
doThis="`echo commonName_default="$myCompany Root CA" >> openssl.cnf`"
amkDoCommand $stepName $doThis
#
doThis="`echo emailAddress_default="$myEmail" >> openssl.cnf`"
amkDoCommand $stepName $doThis
# ----------------------------------------------------------------------
echo "" # REMEMBER two (2) echo stmts one for the screen, the other for the log file.
echo "" >> $amklog
#
echo -e "\tThis command passed the test."
echo -e "\tThis script is now exiting\n"
#
exit # After passing all tests, cut/paste from dotted line to mark below.
#
# ----------------------------------------------------------------------
# THE BELOW STATEMENTS -> HAVE NOT BEEN TESTED!
# ----------------------------------------------------------------------
echo -e "Creating CA PRIVATE KEY\n"
echo -e "Creating CA PRIVATE KEY\n" >> $amklog
openssl genrsa -aes256 -out $fnameRootKEY -passout pass:"$myPassPhrase" 4096
# MODIFIED: openssl genrsa -aes128 -out $fnameKEY -passout pass:"$myPassPhrase" 2048
# DEPRECIATED: openssl genrsa -des3 -out $fnameKEY -passout pass:"$myPassPhrase" 4096
#
# CHECKING FOR ERROR: Did the last command complete successfully?
estat=$? ;  # REMEMBER: This variable is a string not an integer!
if test $estat != 0; then
 echo "ERROR: An error has occurred." ; >> $amkLog
 echo "WHILE ??????"; >> $amkLog
 echo "This script is now exiting"; >> $amkLog
 exit;
fi
#
echo -e "\aNo errors detected"
exit
fi
# ----------------------------------------------------------------------
##

echo -e "CA PRIVATE KEY created SUCCESSFULLY\n"

echo -e "Creating insecure version CA for Apache Server\n"
openssl rsa -in $fnameRootKEY  -out $fnameRootKEYinsecure -passin pass:"$myPassPhrase"
echo -e "Insecure CA.KEY (public key) created SUCCESSFULLY\n"

echo -e "\nNow generating the CA CERTIFICATE file\n"
openssl req -new -x509 -days $myDaysTL -key $fnameRootKEY -out $fnameRootCRT -config openssl.cnf -batch -passin pass:"$myPassPhrase" -passout pass:"$myPassPhrase"
echo -e "\nROOT CA Certificate completed\n"
# ----------------------------------------------------------------------
# ----------------------------------------------------------------------
echo -e "\nNow generating the INTERMEDIATE KEY\n"
# Copy values to openssl.cnf file
cp $workingdir/empty_openssl.cnf openssl.cnf
echo countryName_default="$myCountry" >> openssl.cnf
echo stateOrProvinceName_default="$myState" >> openssl.cnf
echo localityName_default="$myCity" >> openssl.cnf
echo 0.organizationName_default="$myCompany Certificate Authority" >> openssl.cnf
echo organizationalUnitName_default="$myCompany Intermediate" >> openssl.cnf
echo commonName_default="$myCompany Intermediate CA" >> openssl.cnf
echo emailAddress_default="$myEmail" >> openssl.cnf
# ----------------------------------------------------------------------
openssl genrsa -aes256 -out $fnameIntermediateKEY -passout pass:"$myPassPhrase" 4096
# MODIFIED: openssl genrsa -aes128 -out $fnameServerKEY -passout pass:"$myPassPhrase" 2048
# DEPRECIATED: openssl genrsa -des3 -out $fnameServerKEY -passout pass:"$myPassPhrase" 4096
echo -e "\nINTERMEDIATE PRIVATE KEY created SUCCESSFULLY\n"

echo -e "Creating insecure version Intermediate for Apache Server\n"
openssl rsa -in $fnameIntermediateKEY -out $fnameIntermediateKEYinsecure -passin pass:"$myPassPhrase"
echo -e "Insecure Intermediate.KEY (public key) created SUCCESSFULLY\n"

echo -e "\nGenerating the INTERMEDIATE Certificate Signing Request (CSR)\n"
openssl req -new -sha256 -key $fnameIntermediateKEY -out $fnameIntermediateCSR -config openssl.cnf -batch -passin pass:"$myPassPhrase" -passout pass:"$myPassPhrase"
echo -e "\nINTERMEDIATE CSR Completed\n"

echo -e "\nCREATING the INTERMEDIATE CERTIFICATE file\n"
openssl ca -extensions v3_intermediate_ca -days $myDaysTL -key $fnameIntermediateCSR -out $fnameIntermediateCRT -config openssl.cnf -batch -passin pass:"$myPassPhrase" -passout pass:"$myPassPhrase"
echo -e "\nINTERMEDIATE Certificate completed\n"
# ----------------------------------------------------------------------
# ----------------------------------------------------------------------
echo -e "\nCREATING the CERTIFICATE CHANGE file\n"
cat $fnameIntermediateCRT $fnameRootCRT > $fnameCAChainCRT
# ----------------------------------------------------------------------
# ----------------------------------------------------------------------
echo -e "\nNow generating the SERVER Key\n"
# Copy values to openssl.cnf file
cp $workingdir/empty_openssl.cnf openssl.cnf
echo countryName_default="$myCountry" >> openssl.cnf
echo stateOrProvinceName_default="$myState" >> openssl.cnf
echo localityName_default="$myCity" >> openssl.cnf
echo 0.organizationName_default="$myCompany" >> openssl.cnf
echo organizationalUnitName_default="$myCompany Web Services" >> openssl.cnf
echo commonName_default="$myCommonName" >> openssl.cnf
echo emailAddress_default="$myEmail" >> openssl.cnf
# ----------------------------------------------------------------------
openssl genrsa -aes256 -out $fnameServerKEY -passout pass:"$myPassPhrase" 2048
# MODIFIED: openssl genrsa -aes128 -out $fnameServerKEY -passout pass:"$myPassPhrase" 2048
# DEPRECIATED: openssl genrsa -des3 -out $fnameServerKEY -passout pass:"$myPassPhrase" 4096
echo -e "\nServer Private Key Completed\n"

echo -e "\nGenerating the Certificate Signing Request (CSR)\n"
openssl req -new -sha256 -key $fnameServerKEY -out $fnameServerCSR -config openssl.cnf -batch -passin pass:"$myPassPhrase" -passout pass:"$myPassPhrase"
echo -e "\nSERVER CSR completed\n"

echo -e "\nSigning the CSR with the Intermediate CA CRT\n"
openssl ca -extensions server_cert -md sha256 -days $myDaysTL -in $fnameServerCSR -CA $fnameIntermediateCRT -CAkey $fnameIntermediateKEY -set_serial $sn -out $fnameServerCRT -passin pass:"$myPassPhrase"
# MODIFIED: openssl x509 -req -days $myDaysTL -in $fnameServerCSR -CA $fnameCRT -CAkey $fnameKEY -set_serial $sn -out $fnameServerCRT -passin pass:"$myPassPhrase"
echo -e "\nSERVER Certificate completed SUCCESSFULLY\n"

echo -e "\nMaking insecure version for Apache Server\n"
openssl rsa -in $fnameServerKEY -out $fnameServerKEYinsecure -passin pass:"$myPassPhrase"
echo -e "\nInsecure Server.KEY Completed\n"

mv $fnameServerKEY $fnameServerKEYsecure
mv $fnameServerKEYinsecure $fnameServerKEY
#
if [ ! -d _csr ]; then
	mkdir _csr
	mv *.csr ./_csr
else
	mv *.csr ./_csr
fi
#
if [ ! -d _secure ]; then
	mkdir _secure
	mv *.secure.pem ./_secure
else
	mv *.secure.pem ./_secure
fi
#
echo -e "You MUST COPY TO: /etc/ca-certificates\n"
echo -e "SET FILE PERMISSIONS: 600\n"
echo -e "ALL DONE!\n"
ls -al
exit
fi