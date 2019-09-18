#!/bin/bash
set -e

# AMK Quick Way to start & stop MYSQL!
# Check commandline for proper variables


if [ $# -eq 0 ] ; then
	 echo -e '\n SYNTAX: mysql.sh start|stop\n\n' 
	exit ;

elif [ $# -eq 1 ] ; then

	if [ "$1" == "start" ] ; then


		if [ "$sname" == "newkirk" ] ; then
			launchctl load /Library/LaunchDaemons/homebrew.mxcl.mysqld.plist
		  	exit;

		  elif [ "$sname" == "pandaMbk" ] ; then
			sudo launchctl load /Library/LaunchDaemons/homebrew.mxcl.mysqld.plist
      		exit;

      elif [ "$sname" == "hogan" ] ; then
			mysql.server start
    exit;

      elif [ "$sname" == "carter" ] ; then
      exit;
    fi
  
	elif [ "$1" == "stop" ] ; then
    if [ "$sname" == "newkirk" ] ; then
      launchctl unload /Library/LaunchDaemons/homebrew.mxcl.mysqld.plist
	    exit;

      elif [ "$sname" == "pandaMbk" ] ; then
      sudo launchctl unload /Library/LaunchDaemons/homebrew.mxcl.mysqld.plist
      exit;

      elif [ "$sname" == "hogan" ] ; then
      mysql.server stop
      exit;

      elif [ "$sname" == "carter" ] ; then
      exit;
    fi
  fi
  exit
fi
