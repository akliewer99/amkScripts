#!/bin/bash
#set -e   #-- Must be disabled so Mac terminals don't auto exit
# AMK Sets the admin's profile
#
# TERMINAL SETTINGS == MUST HAVE Brew bash_completion installed
# NOTE: Attempted to add below . . but didn't work???
# [-f/usr/local/etc/bash_completion]&&./usr/local/etc/bash_completion

 # if [ -f "/usr/local/opt/bash-git-prompt/share/gitprompt.sh" ]; then
 #   __GIT_PROMPT_DIR="/usr/local/opt/bash-git-prompt/share"
 #   source "/usr/local/opt/bash-git-prompt/share/gitprompt.sh"
 # fi

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# SET SYSTEM VARS
export sname="janeway"
#
#export srcPath=/Users/admin/SparkleShare/amkScripts
export amkPath=/usr/local/_amkScripts
export snamePath=$amkPath/_$sname

#DYLD_LIBRARY_PATH environment variable

# ARLENE'S SPECIFIC ALIAS
alias amk='cd $amkPath/'
alias snamePath='cd $amkPath/_$sname'
alias devism='cd /Users/akliewer/Repos-git/starfire/iSkyMarshal'
alias ll='ls -al'
alias nprofile='source ~/.profile'
alias newsource='source ~/.profile'

# SHOW HIDDEN FILES
alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'

# HIDE HIDDEN FILES
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

## REMEMBER- KEEP BELOW ITEMS ALPHABATIZED

#=== LDFLAGS =======================================
#LDFLAG_PATHS=PasteNewValueHere:$LDFLAG_PATHS

#=== CPPFLAGS =======================================
#CPPFLAG_PATHS=PasteNewValueHere:$CPPFLAG_PATHS

#=== PKG_CONFIG =======================================
#PKG_CONFIG=PasteNewValueHere:$PKG_CONFIG

#=== EXPORTS =======================================
export LDFLAGS=-L$LDFLAG_PATHS
export CPPFLAGS=-I$CPPFLAG_PATHS
export PKG_CONFIG_PATH=$PKG_CONFIG
export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)

#=== PATH =======================================
#export PATH=PasteNewValueHere:$PATH

#=== REMEMBER- Keep above alphabetized ==========
export PATH=/usr/local/_amkScripts:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH
