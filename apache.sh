#!/bin/bash
set -e

## -*- APACHE: Start/Stop -*-
## @author Arlene Kliewer 
## @file apache.sh

$sname_fname="/Library/LaunchDaemons/homebrew.mxcl.httpd24.plist"


function pandaMbk () {
    if [ "$1" == "start" ] ; then
      sudo apachectl start ;
      exit ;
    else
      sudo apachectl stop ;
      exit ;
    fi
}

function newkirk () {
    if [ "$1" == "start" ] ; then
      sudo serveradmin start web ;
      exit;
    else
      sudo serveradmin stop web ;
      exit ;
    fi
}

function hogan () {
    if [ "$1" == "start" ] ; then
      sudo apachectl start ;
        exit ;
    else
      sudo apachectl stop ;
      exit ;
    fi
}

function carter () {
    if [ "$1" == "start" ] ; then
      sudo apachectl start ;
      exit ;
    else
      sudo apachectl stop ;
      exit ;
    fi
}

if [ $# -eq 0 ] ; then
	 echo -e '\n SYNTAX: apache.sh start| stop| restart\n\n' 
	exit ;

elif [ $# -eq 1 ] ; then

    if [ "$sname" == "newkirk" ] ; then
        newkirk $1 
        exit
    elif [ "$sname" == "pandaMbk" ] ; then
        pandaMbk $1
        exit
	elif [ "$sname" == "hogan" ] ; then
        hogan $1
        exit
    elif [ "$sname" == "carter" ] ; then
        carter $1
        exit
    fi
fi
