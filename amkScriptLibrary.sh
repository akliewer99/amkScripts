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
    if [ -f $amklog ] ; then rm $amklog ; fi
    #
    if !(touch $amklog) ; then
    echo -e "\n\tERROR: An error has occurred." ;
    echo -e "\t\tREMEMBER SYNTAX: Command Must start with SUDO." ;
    echo -e "\t\tWHILE: $stepName" ;
    echo -e "\t\tWHILE: $stepName" >> $amklog ;
    echo -e "\t\tNow exiting script.\n" # last line needs the \n new line code.
    exit
    fi
}

# ----------------------------------------------------------------------
test4sudo () {
    testlog="/etc/amk_test.log" # File name variables must have quotes!
    stepName="Checking commandline for SUDO"
    echo -e "\t\t- $stepName"
    echo -e "\t\t- $stepName" >> $amklog
    #
    if [ -f $testlog ] ; then sudo rm $testlog ; fi
    #
    if !(touch $testlog) ; then
        echo -e "\tREMEMBER SYNTAX: Command Must start with SUDO." ;
        echo -e "\n\tERROR: An error has occurred." ;
        echo -e "\t\tWHILE: $stepName" ;
        echo -e "\t\tWHILE: $stepName" >> $amklog ;
        echo -e "\t\tNow exiting script.\n"; # last line needs the \n new line code.
        echo -e "\t\tNow exiting script.\n" >> $amklog ;
        exit ;
    fi
}

# ----------------------------------------------------------------------
amkDoCommand () {
    if !($doThis) ; then
           echo -e "\n\t\tERROR: An error has occurred." ;
            echo -e "\n\t\tERROR: An error has occurred." >> $amklog ;
            echo -e "\t\tWHILE: $stepName" ;
            echo -e "\t\tWHILE: $stepName" >> $amklog ;
            echo -e "\t\tNow exiting this script.\n" ; # last line needs the \n new line code.
            echo -e "\t\tNow exiting this script.\n" >> $amklog ;
            exit ;
    fi

}