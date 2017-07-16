#!/bin/bash
set -e

# AMK Quick Way to generate SSL Certificates!
#
# Generate my own Certificate Authority (CA)
#
# Check commandline for proper variables

# OKAY TO CHANGE BELOW:
# EXPIRES IN DAY: 3650 = 10 years
myDaysTL="3650"
myCommonName="amkcreations.com"
myCompany="amkCREATIONS"
#
myDepart="Support"
myCity="Roseville"
myState="California"
myCountry="US"
#
myPassPhrase="kastle7821022"
myEmail="akliewer99@gmail.com"
#
mySudoPwd="R0sev1lle"
#

if [ $# -eq 0 ] ; then
	echo -e '\nSYNTAX: sudo ./ssl-full.sh DomainName SerialNum CACompanyName ready\n' 
	echo -e '  EXAMPLE:'
	echo -e '  DOMAIN_NAME=kkastle.com \t.com must be here'
	echo -e '  SERIAL_NUM=999 \t(1Password:Maintains last SN used)'
	echo -e '  CA_COMPANY_NAME=kkastle \t(No spaces. One word. No .coms)'
	echo -e '  READY=ready \t(Starts the generation)'
	echo -e ''
	echo -e "VERIFY CURRENT VALUES:"
	echo -e "  COMMON/FILE_NAME: $myCommonName \t<-DOMAIN_NAME"
	echo -e "  COMPANY: $myCompany \t<-CA_COMPANY_NAME"
	echo -e "  DEPART: $myDepart"
	echo -e ''
	echo -e "  CITY: $myCity"
	echo -e "  STATE: $myState"
	echo -e "  COUNTRY: $myCountry"
	echo -e ''
	echo -e "  PASS_PHRASE: $myPassPhrase "
	echo -e "  EMAIL: $myEmail"
	echo -e ''
	echo -e "  EXPIRES: $myDaysTL \t(Days:3650 = 10 years)"
	echo -e "  SudoPwd: $mySudoPwd"
	echo -e ''
exit ;

elif [ $# -eq 3 ] ; then
	echo -e "VERIFY CURRENT VALUES:"
	echo -e "\t PassPhrase: $myPassPhrase "
	echo -e "\t Common & File Name: $myCommonName"
	echo -e "\t Company: $myCompany"
	echo -e "\t Depart: $myDepart"
	echo -e "\t City: $myCity"
	echo -e "\t State: $myState"
	echo -e "\t Country: $myCountry"
	echo -e "TO GENERATE: must include -> ready"
	echo -e ''
	exit;

elif [ $# -eq 4 ] ; then

# DON'T CHANGE BELOW ITEMS UNLESS YOUR ARE SURE!
fname="$1"
sn="$2"
myCompany="$3"
myCommonName="$fname"
#
workingdir=`pwd`
#
fnameKEY="$3.CA.PrivKey.pem"
fnameKEYinsecure="$3.CA.PrivKey.insecure.pem"
fnameKEYsecure="$3.CA.PrivKey.secure.pem"
fnameCRT="$3.CA.CRT.pem"
#
fnameServerKEY="$fname.server.PrivKey.pem"
fnameServerCSR="$fname.server.csr"
fnameServerCRT="$fname.server.CRT.pem"
#
fnameServerKEYinsecure="$fname.server.PrivKey.insecure.pem"
fnameServerKEYsecure="$fname.server.PrivKey.secure.pem"
#
# Copy values to certificate
cp $workingdir/empty_openssl.cnf openssl.cnf
echo countryName_default="$myCountry" >> openssl.cnf
echo stateOrProvinceName_default="$myState" >> openssl.cnf
echo localityName_default="$myCity" >> openssl.cnf
echo 0.organizationName_default="$myCompany" >> openssl.cnf
echo organizationalUnitName_default="$myDepart" >> openssl.cnf
echo commonName_default="$myCommonName" >> openssl.cnf
echo emailAddress_default="$myEmail" >> openssl.cnf
#

# ACTUAL WORK BEGINS
echo -e "\nGenerating my own Certificate Authority\n"
# DEPRECIATED: openssl genrsa -des3 -out $fnameKEY -passout pass:"$myPassPhrase" 4096
openssl genrsa -aes128 -out $fnameKEY -passout pass:"$myPassPhrase" 2048
echo -e "\nCA Private key completed\n"

echo -e "\nMaking insecure version CA for Apache Server\n"
openssl rsa -in $fnameKEY -out $fnameKEYinsecure -passin pass:"$myPassPhrase"
echo -e "\nCA Certificate completed\n"
echo -e "\nInsecure CA.KEY Completed\n"

echo -e "\nNow generating the CA Certificate file\n"
openssl req -new -x509 -days $myDaysTL -key $fnameKEY -out $fnameCRT -config openssl.cnf -batch -passin pass:"$myPassPhrase" -passout pass:"$myPassPhrase"
echo -e "\nCA Certificate completed\n"

echo -e "\nNow generating the Domain Server Key\n"
# DEPRECIATED: openssl genrsa -des3 -out $fnameServerKEY -passout pass:"$myPassPhrase" 4096
openssl genrsa -aes128 -out $fnameServerKEY -passout pass:"$myPassPhrase" 2048
echo -e "\nServer Private Key Completed\n"

echo -e "\nGenerating the Certificate Signing Request (CSR)\n"
echo -e "\n Hey you remember Common Name MUST match domain name\n"
openssl req -new -key $fnameServerKEY -out $fnameServerCSR -config openssl.cnf -batch -passin pass:"$myPassPhrase" -passout pass:"$myPassPhrase"
echo -e "\nCA Certificate completed\n"
echo -e "\nCSR Completed\n"

echo -e "\nSigning the CSR with the CA\n"
openssl x509 -req -days $myDaysTL -in $fnameServerCSR -CA $fnameCRT -CAkey $fnameKEY -set_serial $sn -out $fnameServerCRT -passin pass:"$myPassPhrase"
echo -e "\nSigning completed\n"

echo -e "\nMaking insecure version for Apache Server\n"
openssl rsa -in $fnameServerKEY -out $fnameServerKEYinsecure -passin pass:"$myPassPhrase"
echo -e "\nCA Certificate completed\n"
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
echo -e 'You MUST COPY TO: /etc/apache2/certificates'
echo -e "SET FILE PERMISSIONS: 600"
echo -e "ALL DONE!\n"
ls -al
exit
# BELOW IS NOT PERFORMED
#****** testing *******
echo -e "\nCopy FILE:$fnameServerKEY to /private/etc/apache2/certificates\n"
/usr/bin/expect <<EOD
spawn sudo cp $fnameServerKEY /private/etc/apache2/certificates/$fnameServerKEY
expect "Password:"
send "$mySudoPwd"
EOD
echo -e "\nFile Copy SUCCESFUL\n"
#

echo -e "\nCopy FILE:$fnameServerCRT to /etc/apache2/certificates\n"
/usr/bin/expect <<EOD
spawn sudo cp $fnameServerCRT /private/etc/apache2/certificates
expect "Password:"
send "$mySudoPwd"
EOD
echo -e "\nFile Copy SUCCESFUL\n"

echo -e "\nCORRECTING FILE PERMISSIONS\n"
/usr/bin/expect <<EOD
spawn sudo chmod 600 /etc/apache2/certificates/$fnameServerKEY
expect "Password:"
send "$mySudoPwd"
EOD
echo -e "\n\nFILE PERMISSIONS of $fnameServerKEY: was set to 600\n"

/usr/bin/expect <<EOD
spawn sudo chmod 600 /private/etc/apache2/certificates/$fnameServerCRT
expect "Password:"
send "$mySudoPwd"
EOD
echo -e "\n\nFILE PERMISSIONS of $fnameServerCRT: was set to 600\n"

echo -e "\n\nALL DONE!\n"
fi