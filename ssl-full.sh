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
# CERTIFICATE DETAILS NEEDED: 
# ----------------------------------------------------------------------
myDaysTL="7300" # Expires in 7300 days which = 20 years
# Expires in 3650 days which = 10 years
# ----------------------------------------------------------------------
#	SYNTAX: sudo ssl-full.sh Domain SerialNum CompanyName ServerName ready\n" 
# ----------------------------------------------------------------------
myCompany="$3"
myCommonName="$3 CA"
#
myDepart="$3 Certificate Authority"
myCity="Citrus Heights"
myState="California"
myCountry="US"
#
myPassPhrase=kastle7821022   # old phrase was misspelled myPassPhrase=kkastle7821002
myEmail="akliewer99@gmail.com"
# ----------------------------------------------------------------------#
# REMEMBER: Do not place "sudo" in this script, however you must include "sudo" on the commandline.
# ----------------------------------------------------------------------
#
mySudoPwd=PurpleM00se
#
fname="$1"
domain="$1"
servername="$4"
sn="$2"
myCompany="$3"
myCommonName="$4.$1"
# ----------------------------------------------------------------------
# TESTING NECESSARY COMMANDLINE PARAMETERS
# ----------------------------------------------------------------------
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
	echo -e ""
  exit ;
elif [ $# -eq 5 ] ; then
#
workingdir=`pwd`
# ----------------------------------------------------------------------
# ACTUAL WORK BEGINS
# ----------------------------------------------------------------------
# SET LOG FILE & PATH
fName="amk.log" # File name variables must have quotes!
stepName="Creating log file."
makelog $fName
amklog="$fName" # File name variables must have quotes!
# ----------------------------------------------------------------------
# CA - Certificate Authority
# ----------------------------------------------------------------------
fnameRootKEY="ca.priv.key.pem"
fnameRootCRT="ca.cert.pem"
fnameRootKEYinsecure="ca.insecure.key.pem"

# [CA_default]
# ----------------------------------------------------------------------
ca_dir		= "_ca" ; makedir $ca_dir
certs			= "$ca_dir/certs" ; makedir $certs
crl_dir		= "$ca_dir/crl" ; makedir $crl_dir  # Cert Revocation Lists
new_certs_dir = "$ca_dir/newcerts" ; makedir $new_certs_dir
ca_private = "$ca_dir/private" ; makedir $ca_private
database = "$ca_dir/index.txt" ; makelog database
serial = "$ca_dir/serial"  ; makelog serial
RANDFILE = "$ca_private/.rand"  ;  makelog $RANDFILE

# The root key and root certificate
# ----------------------------------------------------------------------
private_key       = "$ca_private/$fnameRootKEY"
certificate       = "$certs/$fnameRootCRT"

# For certificate revocation lists
# ----------------------------------------------------------------------
fnameRootCRL="ca.crl.pem"
crlnumber					= "$ca_dir/crlnumber"
crl								= "$crl_dir/$fnameRootCRL"
crl_extensions		= "crl_ext"
default_crl_days	= 30

# SHA-2 (SHA-1 is deprecated)
# ----------------------------------------------------------------------
default_md 				= sha256



# Make needed Int directories
# ----------------------------------------------------------------------
INTdir="_int"
makedir $INTdir
makedir $INTdir/certs
makedir $INTdir/crl  # Cert Revocation Lists
makedir $INTdir/private
#
fnameIntKEY="Int.Priv.Key.pem"
fnameIntCSR="Int.csr.pem"  # Cert Signing Request
fnameIntCRT="Int.CRT.pem"
#
fnameIntKEYinsecure="$INTdir/private/INT.Insecure.Key.pem"
#
fnameCAChainCRT="$fname.CAChain.CRT.pem"
#
fnameServerKEY="$fname.server.PrivKey.pem"
fnameServerCSR="$fname.server.csr.pem"
fnameServerCRT="$fname.server.CRT.pem"
#
fnameServerKEYinsecure="$fname.server.PrivKey.insecure.pem"
fnameServerKEYsecure="$fname.server.PrivKey.secure.pem"
#
# ----------------------------------------------------------------------
# SET index for serial numbers
fName="$dir/index.txt" # File name variables must have quotes!
stepName="Creating index file."
makelog $fName
echo $sn >>$fName
# ----------------------------------------------------------------------
# SET serial for serial numbers
fName="$dir/serial" # File name variables must have quotes!
stepName="Creating serial file."
makelog $fName
echo $sn >>$fName
#add_to_indexSN $fName $sn
# ----------------------------------------------------------------------
echo -e "\n\tBEGIN: CREATION OF SSL Certificates . . ." >> $amklog
echo -e "\t\t- $stepName"
echo -e "\t\t- $stepName" >> $amklog
# ----------------------------------------------------------------------
# TESTING IF COMMAND CONTAINS SUDO
test4sudo
# ----------------------------------------------------------------------
stepName="Adding serial number to index file"
fName="$dir/index.txt" # File name variables must have quotes!
add_to_indexSN $fName $sn
# ----------------------------------------------------------------------
echo -e "\n\tGENERATING ROOT CERTIFICATE AUTHORITY"
echo -e "\n\tGENERATING ROOT CERTIFICATE AUTHORITY" >> $amklog
# ----------------------------------------------------------------------
# CREATING SSL CONFIG FILE
stepName="Creating the SSL config file."
doThis="cp empty_openssl.cnf openssl.cnf"
echo -e "\t\t- $stepName"
echo -e "\t\t- $stepName" >> $amklog
if [ -f openssl.cnf ] ; then sudo rm openssl.cnf ; fi
amkDoCommand $stepName $doThis
# ----------------------------------------------------------------------
# COPY DEFAULT VALUES TO CONFIG FILE
stepName="Adding default values to config file"
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
doThis="`echo 0.organizationalName_default="$myCompany" >> openssl.cnf`"
amkDoCommand $stepName $doThis
#
doThis="`echo organizationalUnitName_default="$myDepart" >> openssl.cnf`"
amkDoCommand $stepName $doThis
#
doThis="`echo commonName_default="$myCompany CA" >> openssl.cnf`"
amkDoCommand $stepName $doThis
#
doThis="`echo emailAddress_default="$myEmail" >> openssl.cnf`"
amkDoCommand $stepName $doThis
# ----------------------------------------------------------------------
stepName="CREATING CERTIFICATE AUTHORITY -> PRIVATE KEY"
echo -e "\nmyPassPhrase is $myPassPhrase\n"
doThis="openssl genrsa -aes256 -out $dir/$fnameRootKEY -passout pass:$myPassPhrase 4096"
# MODIFIED: openssl genrsa -aes128 -out $fnameKEY -passout pass:kkastle7821002 2048
# DEPRECATED: openssl genrsa -des3 -out $fnameKEY -passout pass:kkastle7821002 4096
echo -e "\n\t$stepName"
echo -e "\n\t$stepName" >> $amklog
amkDoCommand $stepName $doThis
chmod 400 $dir/$fnameRootKEY
# ----------------------------------------------------------------------
stepName="NOW GENERATING THE ROOT CA CERTIFICATE"
echo -e "\n\t$stepName"
echo -e "\n\t$stepName" >> $amklog
doThis="openssl req -config openssl.cnf -key $dir/$fnameRootKEY -new -x509 -days $myDaysTL -sha256 -extensions v3_ca -passin pass:$myPassPhrase -out $dir/$fnameRootCRT"
amkDoCommand $stepName $doThis
chmod 400 $dir/$fnameRootCRT
# ----------------------------------------------------------------------
stepName="Creating Insecure Version of CA for Apache Server"
doThis="openssl rsa -in $dir/$fnameRootKEY -passin pass:$myPassPhrase -out $dir/$fnameRootKEYinsecure"
echo -e "\t\t- $stepName"
echo -e "\t\t- $stepName" >> $amklog
amkDoCommand $stepName $doThis
# ----------------------------------------------------------------------
# Make needed CA directories
#dir="_ca"
#dir="_ca/Int"
#makedir 	$dir
#makedir 	$dir/certs
#makedir 	$dir/crl
#makedir 	$dir/newcerts
#makedir 	$dir/private
touch $dir/indexInt.txt
echo $sn >> $dir/indexInt.txt
touch $dir/IntCRLnumber
echo $sn >> $dir/IntCRLnumber
# ----------------------------------------------------------------------
stepName="CREATING THE Int KEY"
stepName="Copying fresh config file"
doThis="cp empty_INT_openssl.cnf INT_openssl.cnf"
echo -e "\t\t- $stepName"
echo -e "\t\t- $stepName" >> $amklog
if [ -f INT_openssl.cnf ] ; then sudo rm INT_openssl.cnf ; fi
amkDoCommand $stepName $doThis
# ----------------------------------------------------------------------
# COPY DEFAULT VALUES TO CONFIG FILE
stepName="Adding new values to config file"
echo -e "\t\t- $stepName"
echo -e "\t\t- $stepName" >> $amklog
#
doThis="`echo private_key=$fnameRootKEY >> INT_openssl.cnf`"
amkDoCommand $stepName $doThis
#
doThis="`echo certificate=$fnameRootCRT >> INT_openssl.cnf`"
amkDoCommand $stepName $doThis
#
doThis="`echo countryName_default=$myCountry >> INT_openssl.cnf`"
amkDoCommand $stepName $doThis
#
doThis="`echo stateOrProvinceName_default="$myState" >> INT_openssl.cnf`"
amkDoCommand $stepName $doThis
#
doThis="`echo localityName_default="$myCity" >> INT_openssl.cnf`"
amkDoCommand $stepName $doThis
#
doThis="`echo organizationalUnitName_default="$myCompany Int" >> INT_openssl.cnf`"
amkDoCommand $stepName $doThis
#
doThis="`echo commonName_default="$myCompany Int CA" >> INT_openssl.cnf`"
amkDoCommand $stepName $doThis
#
doThis="`echo emailAddress_default="$myEmail" >> INT_openssl.cnf`"
amkDoCommand $stepName $doThis
# ----------------------------------------------------------------------
stepName="GENERATING THE Int CA => PRIVATE KEY"
doThis="openssl genrsa -aes256 -out $dir/$fnameIntKEY -passout pass:$myPassPhrase 4096"
# MODIFIED: openssl genrsa -aes128 -out $fnameServerKEY -passout pass:kkastle7821002 2048
# DEPRECATED: openssl genrsa -des3 -out $fnameServerKEY -passout pass:kkastle7821002 4096
echo -e "\n\t$stepName"
echo -e "\n\t$stepName" >> $amklog
amkDoCommand $stepName $doThis
chmod 400 $dir/$fnameIntKEY
# ----------------------------------------------------------------------
stepName="CREATING THE INSECURE VERSION FOR APACHE SERVER"
doThis="openssl rsa -in $dir/$fnameIntKEY -out $dir/$fnameIntKEYinsecure -passin pass:$myPassPhrase"
echo -e "\n\t\t$stepName"
echo -e "\n\t$stepName" >> $amklog
amkDoCommand $stepName $doThis
# ----------------------------------------------------------------------
stepName="GENERATING THE Int CERTIFICATE SIGNING REQUEST (CSR)"
doThis="openssl req -config INT_openssl.cnf -new -sha256 -key $dir/$fnameIntKEY -out $dir/$fnameIntCSR -passin pass:$myPassPhrase"
echo -e "\n\t\t- $stepName"
echo -e "\n\t\t- $stepName" >> $amklog
amkDoCommand $stepName $doThis
# ----------------------------------------------------------------------
stepName="CREATING THE Int CERTIFICATE"
doThis="openssl ca -config INT_openssl.cnf -extensions v3_Int_ca -days $3650 -notext -md sha256 -in $dir/$fnameIntCSR -out $dir/$fnameIntCRT"
# MODIFIED: openssl ca -extensions v3_Int_ca -days $myDaysTL -key $fnameIntCSR -out $fnameIntCRT -config openssl.cnf -batch -passin pass:\"$myPassPhrase\" -passout pass:\"$myPassPhrase\
echo -e "\t\t- $stepName"
echo -e "\t\t- $stepName" >> $amklog
amkDoCommand $stepName $doThis
chmod 444 $dir/$fnameIntCRT
# ----------------------------------------------------------------------
stepName="CREATING THE CERTIFICATE CHAIN FILE"
doThis="cat $dir/$fnameIntCRT $dir/$fnameRootCRT > $dir/$fnameCAChainCRT"
echo -e "\t\t- $stepName"
echo -e "\t\t- $stepName" >> $amklog
amkDoCommand $stepName $doThis
chmod 444 $dir/$fnameCAChainCRT
# ----------------------------------------------------------------------
#
echo -e "\tThis command passed the test."
echo -e "\tThis script is now exiting\n"
#
exit # After passing all tests, cut/paste from dotted line to mark below.
# ----------------------------------------------------------------------
# THE BELOW STATEMENTS -> HAVE NOT BEEN TESTED!
# ----------------------------------------------------------------------
echo "" # REMEMBER 3 name stmts one for the block, one for the screen, the last for the log file.
echo "" >> $amklog
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
openssl genrsa -aes256 -out $fnameServerKEY -passout pass:\"$myPassPhrase\" 2048
# MODIFIED: openssl genrsa -aes128 -out $fnameServerKEY -passout pass:kkastle7821002 2048
# DEPRECATED: openssl genrsa -des3 -out $fnameServerKEY -passout pass:kkastle7821002 4096
echo -e "\nServer Private Key Completed\n"

echo -e "\nGenerating the Certificate Signing Request (CSR)\n"
openssl req -new -sha256 -key $fnameServerKEY -out $fnameServerCSR -config openssl.cnf -batch -passin pass:$myPassPhrase -passout pass:\"$myPassPhrase\"
echo -e "\nSERVER CSR completed\n"

echo -e "\nSigning the CSR with the Int CA CRT\n"
openssl ca -extensions server_cert -md sha256 -days $myDaysTL -in $fnameServerCSR -CA $fnameIntCRT -CAkey $fnameIntKEY -set_serial $sn -out $fnameServerCRT -passin pass:$myPassPhrase
# MODIFIED: openssl x509 -req -days $myDaysTL -in $fnameServerCSR -CA $fnameCRT -CAkey $fnameKEY -set_serial $sn -out $fnameServerCRT -passin pass:kkastle7821002
echo -e "\nSERVER Certificate completed SUCCESSFULLY\n"

echo -e "\nMaking insecure version for Apache Server\n"
openssl rsa -in $fnameServerKEY -out $fnameServerKEYinsecure -passin pass:\"$myPassPhrase\"
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
echo -e "You MUST COPY TO: /etc/certificates\n"
echo -e "SET FILE PERMISSIONS: 600\n"
echo -e "ALL DONE!\n"
ls -al
exit
fi