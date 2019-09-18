# AUTHOR : Arlene Kliewer
# TITLE: amkScriptLibrary.sh
# SHELL: bash
#
# NOTE: BASH shell requires -e for escape characters to work
# echo -e "Hello\nWorld"
#
# PURPOSE: Function/Method Library

# ----------------------------------------------------------------------
makelog () {
    # 
    if [ -f $1 ] ; then rm $1 ; fi
    #
    if !(touch $1) ; then
        echo -e "\n\t\tTHE STEP: $stepName"  | tee -a $amklog 
        echo -e "\t\t- An ERROR has occurred."  | tee -a $amklog 
        echo -e "\t\t- Now exiting script.\n" | tee -a $amklog
    exit ;
    fi
}

# ----------------------------------------------------------------------
removeLOG () {
    # 
		if [ -f $1 ] ; then
				stepName="Removing the $1 file"
				echo -e "\n\t\tTHE STEP: $stepName"
				rm $1 ; 
 			  echo -e "\t\t- Completed Successfully"
 		else
				echo -e "\t\tERROR: $1 already removed" 
 		fi
    #
}

# ----------------------------------------------------------------------
makedir () {
    # 
		stepName="Making the $1 directory"
    echo -e "\n\t\tTHE STEP: $stepName" | tee -a $amklog
    if [ -d $1 ] ; then rm -r $1 ; fi
    #
    if !(mkdir -p $1) ; then
        echo -e "\n\t\tTHE STEP: Creating the $1 directory"  | tee -a $amklog ;
        echo -e "\t\t- An ERROR has occurred."  | tee -a $amklog ;
        echo -e "\t\t- Now exiting script.\n" | tee -a $amklog ;
    		exit ;
    else
        echo -e "\t\t- Completed Successfully" | tee -a $amklog
    fi
}

# ----------------------------------------------------------------------
removeDIR () {
    # 
		if [ -d $1 ] ; then
				stepName="Removing the $1 directory"
				echo -e "\n\t\tTHE STEP: $stepName"
				rm -r $1
 			  echo -e "\t\t- Completed Successfully"
 		else
				echo -e "\t\tERROR: $1 already removed"
		fi ;
    #
}

# ----------------------------------------------------------------------
test4sudo () {
    testlog="/etc/amk_test.log" # File name variables must have quotes!
    stepName="THE STEP: Checking commandline for SUDO"
    echo -e "\n\t\t$stepName" | tee -a $amklog
    #
    if [ -f $testlog ] ; then sudo rm $testlog ; fi
    echo -e "\t\t- Completed Successfully" | tee -a $amklog
    #
    if !(touch $testlog) ; then
        echo -e "\tREMEMBER SYNTAX: Command Must start with SUDO." ;
        echo -e "\t\t- An ERROR has occurred."  | tee -a $amklog 

        echo -e "\t\t- FOR MORE INFO SEE THE LOG FILE: amk.log" | tee -a $amklog 
        echo -e "\t\t- Now exiting script.\n" | tee -a $amklog
    exit ;
    fi
}

# ----------------------------------------------------------------------
amkDoCommand () {
		# REMEMBER: When calling this function the doThis var must contain
		# back tic marks, not quote marks. EX: 
    if !($doThis) ; then
        echo -e "\n\t\tTHE STEP: $stepName"  | tee -a $amklog 
        echo -e "\t\t- An ERROR has occurred\n"  | tee -a $amklog 
        echo -e "\t\t- Now exiting script\n" | tee -a $amklog
        # last line needs the \n new line code.
        exit ;
    else
        echo -e "\n\t\tTHE STEP: $stepName"  | tee -a $amklog 
        echo -e	"\t\t- Completed Successfully\n" | tee -a $amklog
    fi

}

# ----------------------------------------------------------------------
updateCA_SSLconfig () {
	configFile=$ca_dir/openssl_ca.cnf
	# ----------------------------------------------------------------------
	# NOTE: Wonder why I had to leave the double-quotes for this to work????
	doThis="cp $myDefaults/empty_CA_openssl.cnf $configFile"
	if [ -f openssl_ca.cnf ] ; then rm openssl_ca.cnf ; fi
	amkDoCommand $stepName $doThis
	# ----------------------------------------------------------------------
	stepName="- Adding COUNTRY: $myCountry"
	doThis=`echo countryName_default=$myCountry >> $configFile`
	echo -e "\t\t\t$stepName" | tee -a $amklog
	$doThis
	# ----------------------------------------------------------------------
	stepName="- Adding STATE: $myState"
	doThis=`echo stateOrProvinceName_default=$myState >> $configFile`
	echo -e "\t\t\t$stepName" | tee -a $amklog
	$doThis
	# ----------------------------------------------------------------------
	stepName="- Adding CITY: $myCity"
	doThis=`echo localityName_default=$myCity >> $configFile`
	echo -e "\t\t\t$stepName" | tee -a $amklog
	$doThis
	# ----------------------------------------------------------------------
	stepName="- Adding COMPANY: $myCompany"
	doThis=`echo 0.organizationName_default=$myCompany >> $configFile`
	echo -e "\t\t\t$stepName" | tee -a $amklog
	$doThis
	# ----------------------------------------------------------------------
	stepName="- Adding DEPART: $myDepart"
	doThis=`echo organizationalUnitName_default=$myDepart >> $configFile`
	echo -e "\t\t\t$stepName" | tee -a $amklog
	$doThis
	# ----------------------------------------------------------------------
	stepName="- Adding COMMON: $myCommonName"
	doThis=`echo commonName_default=$myCommonName >> $configFile`
	echo -e "\t\t\t$stepName" | tee -a $amklog
	$doThis
	# ----------------------------------------------------------------------
	stepName="- Adding EMAIL: $myEmail"
	doThis=`echo emailAddress_default=$myEmail >> $configFile`
	echo -e "\t\t\t$stepName" | tee -a $amklog
	$doThis
	# ----------------------------------------------------------------------
  echo -e "\t\t\t- Completed Successfully" | tee -a $amklog
}

# ----------------------------------------------------------------------
# ----------------------------------------------------------------------
createRootKey () {
	# ----------------------------------------------------------------------
	# FOR DETAILS: https://www.openssl.org/docs/manmaster/man1/openssl.html
	# ----------------------------------------------------------------------
	# genpkey = Generation of Private Key or Parameters
	# genrsa = Generation of RSA Private Key, replacing (superseded) genpkey
	# rand = Generate pseudo-random bytes
	# req = PKCS#10 X.509 Certificate Signing Request (CSR) Management
	# rsa = RSA key Management
	# x509 = X.509 Certificate Data Management
	# ----------------------------------------------------------------------
	# Encoding and Cipher Commands
	# aes256 + type of cipher
	# ----------------------------------------------------------------------
	# OPTIONS
	# passin and passout = Allow the password to obtained from a variety of sources
	# pass:password = Password is the actual password, which is visible to all (not secure)
	# ----------------------------------------------------------------------
	# REMEMBER: THE SIZE MUST BE LAST & no quote marks in variable 
	# ----------------------------------------------------------------------
	doThis=`openssl genrsa -aes256 -out $ca_private/$fnameRootKEY \
					-passout pass:$myPassPhrase 4096`
	# 
	# MODIFIED: openssl genrsa -aes128 -out $fnameKEY -passout pass:kkastle7821002 2048
	# DEPRECATED: openssl genrsa -des3 -out $fnameKEY -passout pass:kkastle7821002 4096
	amkDoCommand $stepName $doThis
	#
}

# ----------------------------------------------------------------------
createRootCert () {
	# ----------------------------------------------------------------------
	# FOR DETAILS: https://www.openssl.org/docs/manmaster/man1/openssl.html
	# ----------------------------------------------------------------------
	# req = PKCS#10 X.509 Cert ificate Signing Request (CSR) Management
	#
	#
	doThis=`openssl req -config $ca_dir/openssl_ca.cnf -key $ca_private/$fnameRootKEY \
					-new -x509 -days $myDaysTL -sha256 -extensions v3_ca \
					-passin pass:$myPassPhrase -out $certs/$fnameRootCERT`
	#
	amkDoCommand $stepName $doThis
	#		
}

# ----------------------------------------------------------------------
# ----------------------------------------------------------------------
updateInt_SSLconfig () {
	configFile=$int_dir/openssl_int.cnf
	# ----------------------------------------------------------------------
	# NOTE: Wonder why I had to leave the double-quotes for this to work????
	doThis="cp $myDefaults/empty_INT_openssl.cnf $configFile"
	if [ -f openssl.cnf ] ; then rm openssl.cnf ; fi
	amkDoCommand $stepName $doThis
	# ----------------------------------------------------------------------
	stepName="- Adding COUNTRY: $myCountry"
	doThis=`echo countryName_default=$myCountry >> $configFile`
	echo -e "\t\t\t$stepName" | tee -a $amklog
	$doThis
	# ----------------------------------------------------------------------
	stepName="- Adding STATE: $myState"
	doThis=`echo stateOrProvinceName_default=$myState >> $configFile`
	echo -e "\t\t\t$stepName" | tee -a $amklog
	$doThis
	# ----------------------------------------------------------------------
	stepName="- Adding CITY: $myCity"
	doThis=`echo localityName_default=$myCity >> $configFile`
	echo -e "\t\t\t$stepName" | tee -a $amklog
	$doThis
	# ----------------------------------------------------------------------
	stepName="- Adding COMPANY: $myCompany"
	doThis=`echo 0.organizationName_default=$myCompany >> $configFile`
	echo -e "\t\t\t$stepName" | tee -a $amklog
	$doThis
	# ----------------------------------------------------------------------
	stepName="- Adding DEPART: $myDepart"
	doThis=`echo organizationalUnitName_default=$myDepart >> $configFile`
	echo -e "\t\t\t$stepName" | tee -a $amklog
	$doThis
	# ----------------------------------------------------------------------
	stepName="- Adding COMMON: $myCommonName"
	doThis=`echo commonName_default=$myCommonName >> $configFile`
	echo -e "\t\t\t$stepName" | tee -a $amklog
	$doThis
	# ----------------------------------------------------------------------
	stepName="- Adding EMAIL: $myEmail"
	doThis=`echo emailAddress_default=$myEmail >> $configFile`
	echo -e "\t\t\t$stepName" | tee -a $amklog
	$doThis
	# ----------------------------------------------------------------------
  echo -e "\t\t\t- Completed Successfully" | tee -a $amklog
}

# ----------------------------------------------------------------------
# ----------------------------------------------------------------------
createIntKey () {
	# ----------------------------------------------------------------------
	# FOR DETAILS: https://www.openssl.org/docs/manmaster/man1/openssl.html
	# ----------------------------------------------------------------------
	# genpkey = Generation of Private Key or Parameters
	# genrsa = Generation of RSA Private Key, replacing (superseded) genpkey
	# rand = Generate pseudo-random bytes
	# req = PKCS#10 X.509 Certificate Signing Request (CSR) Management
	# rsa = RSA key Management
	# x509 = X.509 Certificate Data Management
	# ----------------------------------------------------------------------
	# Encoding and Cipher Commands
	# aes256 + type of cipher
	# ----------------------------------------------------------------------
	# OPTIONS
	# passin and passout = Allow the password to obtained from a variety of sources
	# pass:password = Password is the actual password, which is visible to all (not secure)
	# ----------------------------------------------------------------------
	# REMEMBER: THE SIZE MUST BE LAST & no quote marks in variable 
	# ----------------------------------------------------------------------
	doThis=`openssl genrsa -aes256 -passout pass:$myPassPhrase \
					-out $int_private/$fnameIntKEY 4096`					
	# 
	# MODIFIED: openssl genrsa -aes128 -out $fnameKEY -passout pass:kkastle7821002 2048
	# DEPRECATED: openssl genrsa -des3 -out $fnameKEY -passout pass:kkastle7821002 4096
	amkDoCommand $stepName $doThis
	#
}

# ----------------------------------------------------------------------
createIntCSR () {
	# ----------------------------------------------------------------------
	# FOR DETAILS: https://www.openssl.org/docs/manmaster/man1/openssl.html
	# ----------------------------------------------------------------------
	# req = PKCS#10 X.509 Certificate Signing Request (CSR) Management
	#
	configFile="$int_dir/openssl_int.cnf"
	doThis=`openssl req -config $configFile -new -sha256 \
					-key $int_private/$fnameIntKEY -days $myDaysTL \
					-passin pass:$myPassPhrase -out $csr/$fnameIntCSR`
	#
	amkDoCommand $stepName $doThis
	#		
}

# ----------------------------------------------------------------------
createIntCERT () {
	# ----------------------------------------------------------------------
	# FOR DETAILS: https://www.openssl.org/docs/manmaster/man1/openssl.html
	# ----------------------------------------------------------------------
	# req = PKCS#10 X.509 Certificate Signing Request (CSR) Management
	#
	configFile="_ca/openssl_ca.cnf"
	doThis=`openssl ca -config $configFile -extensions v3_intermediate_ca \
					-days $myDaysTL -notext -md sha256 -in $csr/$fnameIntCSR \
					-passin pass:$myPassPhrase -out $certs/$fnameIntCERT`
		#
	amkDoCommand $stepName $doThis
	#		
}

# ----------------------------------------------------------------------
# ----------------------------------------------------------------------
createServerKEY () {
	# ----------------------------------------------------------------------
	# FOR DETAILS: https://www.openssl.org/docs/manmaster/man1/openssl.html
	# ----------------------------------------------------------------------
	# req = PKCS#10 X.509 Certificate Signing Request (CSR) Management
	#
	configFile="_int/openssl_int.cnf"
	doThis=`openssl genrsa -aes256 -out $int_private/$fnameServerKEY \
					-passout pass:$myPassPhrase 2048`
	amkDoCommand $stepName $doThis
	#		
}

# ----------------------------------------------------------------------
createServerCSR () {
	# ----------------------------------------------------------------------
	# FOR DETAILS: https://www.openssl.org/docs/manmaster/man1/openssl.html
	# ----------------------------------------------------------------------
	# req = PKCS#10 X.509 Certificate Signing Request (CSR) Management
	#
	configFile="_int/openssl_int.cnf"
	doThis=`openssl req -config $configFile \
					-key $int_private/$fnameServerKEY \
					-new -sha256 -passin pass:$myPassPhrase \
					-out $csr/$fnameServerCSR`
	amkDoCommand $stepName $doThis
	#		
}

# ----------------------------------------------------------------------
createServerCERT () {
	# ----------------------------------------------------------------------
	# FOR DETAILS: https://www.openssl.org/docs/manmaster/man1/openssl.html
	# ----------------------------------------------------------------------
	# req = PKCS#10 X.509 Certificate Signing Request (CSR) Management
	#
	configFile="_int/openssl_int.cnf"
	doThis=`openssl ca -config $configFile \
					-extensions server_cert -days $myDaysTL -notext -md sha256 \
					-in $csr/$fnameServerCSR \
					-passin pass:$myPassPhrase \
					-out $certs/$fnameServerCERT`
	amkDoCommand $stepName $doThis
	#		
}

# ----------------------------------------------------------------------
# ----------------------------------------------------------------------
createUserKEY () {
	# ----------------------------------------------------------------------
	# FOR DETAILS: https://www.openssl.org/docs/manmaster/man1/openssl.html
	# ----------------------------------------------------------------------
	# req = PKCS#10 X.509 Certificate Signing Request (CSR) Management
	#
	configFile="_int/openssl_int.cnf"
	doThis=`openssl genrsa -aes256 -out $int_private/$fnameUserKEY \
					-passout pass:$myPassPhrase 2048`
	amkDoCommand $stepName $doThis
	#		
}

# ----------------------------------------------------------------------
createUserCSR () {
	# ----------------------------------------------------------------------
	# FOR DETAILS: https://www.openssl.org/docs/manmaster/man1/openssl.html
	# ----------------------------------------------------------------------
	# req = PKCS#10 X.509 Certificate Signing Request (CSR) Management
	#
	configFile="_int/openssl_int.cnf"
	doThis=`openssl req -config $configFile \
					-key $int_private/$fnameUserKEY \
					-new -sha256 -passin pass:$myPassPhrase \
					-out $csr/$fnameUserCSR`
	amkDoCommand $stepName $doThis
	#		
}

# ----------------------------------------------------------------------
createUserCERT () {
	# ----------------------------------------------------------------------
	# FOR DETAILS: https://www.openssl.org/docs/manmaster/man1/openssl.html
	# ----------------------------------------------------------------------
	# req = PKCS#10 X.509 Certificate Signing Request (CSR) Management
	#
	configFile="_int/openssl_int.cnf"
	doThis=`openssl ca -config $configFile \
					-extensions usr_cert -days $myDaysTL -notext -md sha256 \
					-in $csr/$fnameUserCSR \
					-passin pass:$myPassPhrase \
					-out $certs/$fnameUserCERT`
	amkDoCommand $stepName $doThis
	#
}
