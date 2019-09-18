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
