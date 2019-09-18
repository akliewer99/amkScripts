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
alias amk='cd $amkPath/_scripts'
alias snamePath='cd $amkPath/_scripts/_$sname'
alias devism='cd /Users/Shared/sDocuments/repos-git/starfire/iSkyMarshal'
alias ll='ls -al'
alias nprofile='source ~/.profile'
alias newsource='source ~/.profile'

# SHOW HIDDEN FILES
alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'

# HIDE HIDDEN FILES
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

#=== LDFLAGS =======================================
#LDFLAG_PATHS=PasteNewValueHere:$LDFLAG_PATHS
LDFLAG_PATHS=/usr/local/opt/readline/lib
LDFLAG_PATHS=/usr/local/opt/sqlite/lib:$LDFLAG_PATHS
LDFLAG_PATHS=/usr/local/opt/ncurses/lib:$LDFLAG_PATHS
LDFLAG_PATHS=/usr/local/opt/zlib/lib:$LDFLAG_PATHS
LDFLAG_PATHS=/usr/local/opt/bzip2/lib:$LDFLAG_PATHS
LDFLAG_PATHS=/usr/local/opt/openssl/lib:$LDFLAG_PATHS
LDFLAG_PATHS=/usr/local/opt/gettext/lib:$LDFLAG_PATHS
LDFLAG_PATHS=/usr/local/opt/libffi/lib:$LDFLAG_PATHS
LDFLAG_PATHS=/usr/local/opt/tcl-tk/lib:$LDFLAG_PATHS
LDFLAG_PATHS=/usr/local/opt/icu4c/lib:$LDFLAG_PATHS
LDFLAG_PATHS=/usr/local/opt/curl/lib:$LDFLAG_PATHS
LDFLAG_PATHS=/usr/local/opt/llvm/lib:$LDFLAG_PATHS
LDFLAG_PATHS=/usr/local/opt/mysql-client/lib:$LDFLAG_PATHS
LDFLAG_PATHS=/usr/local/opt/qt/lib:$LDFLAG_PATHS
LDFLAG_PATHS=/usr/local/opt/openssl/lib:$LDFLAG_PATHS
LDFLAG_PATHS=/usr/local/opt/curl/libg:$LDFLAG_PATHS
LDFLAG_PATHS=/usr/local/opt/sqlite/lib:$LDFLAG_PATHS

#=== CPPFLAGS =======================================
#CPPFLAG_PATHS=PasteNewValueHere:$CPPFLAG_PATHS
CPPFLAG_PATHS=/usr/local/opt/readline/include
CPPFLAG_PATHS=/usr/local/opt/sqlite/include:$CPPFLAG_PATHS
CPPFLAG_PATHS=/usr/local/opt/ncurses/include:$CPPFLAG_PATHS
CPPFLAG_PATHS=/usr/local/opt/zlib/include:$CPPFLAG_PATHS
CPPFLAG_PATHS=/usr/local/opt/bzip2/include:$CPPFLAG_PATHS
CPPFLAG_PATHS=/usr/local/opt/openssl/include:$CPPFLAG_PATHS
CPPFLAG_PATHS=/usr/local/opt/gettext/include:$CPPFLAG_PATHS
CPPFLAG_PATHS=/usr/local/opt/tcl-tk/include:$CPPFLAG_PATHS
CPPFLAG_PATHS=/usr/local/opt/icu4c/include:$CPPFLAG_PATHS
CPPFLAG_PATHS=/usr/local/opt/curl/include:$CPPFLAG_PATHS
CPPFLAG_PATHS=/usr/local/opt/llvm/include:$CPPFLAG_PATHS
CPPFLAG_PATHS=/usr/local/opt/mysql-client/include:$CPPFLAG_PATHS
CPPFLAG_PATHS=/usr/local/opt/qt/include:$CPPFLAG_PATHS
CPPFLAG_PATHS=/usr/local/opt/openssl/include:$CPPFLAG_PATHS
CPPFLAG_PATHS=/usr/local/opt/curl/include:$CPPFLAG_PATHS
CPPFLAG_PATHS=/usr/local/opt/sqlite/include:$CPPFLAG_PATHS

#=== PKG_CONFIG =======================================
#PKG_CONFIG=PasteNewValueHere:$PKG_CONFIG
PKG_CONFIG=/usr/local/opt/openssl/lib/pkgconfig
PKG_CONFIG=/usr/local/opt/libffi/lib/pkgconfig:$PKG_CONFIG
PKG_CONFIG=/usr/local/opt/tcl-tk/lib/pkgconfig:$PKG_CONFIG
PKG_CONFIG=/usr/local/opt/icu4c/lib/pkgconfig:$PKG_CONFIG
PKG_CONFIG=/usr/local/opt/curl/lib/pkgconfig:$PKG_CONFIG
PKG_CONFIG=/usr/local/opt/mysql-client/lib/pkgconfig:$PKG_CONFIG
PKG_CONFIG=/usr/local/opt/qt/lib/pkgconfig:$PKG_CONFIG
PKG_CONFIG=/usr/local/opt/openssl/lib/pkgconfig:$PKG_CONFIG
PKG_CONFIG=/usr/local/opt/curl/lib/pkgconfig:$PKG_CONFIG
PKG_CONFIG=/usr/local/opt/sqlite/lib/pkgconfig:$PKG_CONFIG

#=== EXPORTS =======================================
export LDFLAGS=-L$LDFLAG_PATHS
export CPPFLAGS=-I$CPPFLAG_PATHS
export PKG_CONFIG_PATH=$PKG_CONFIG
export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)

#=== PATH =======================================
#export PATH=PasteNewValueHere:$PATH
export PATH=/usr/local/_amk/_scripts:$PATH
export PATH=/usr/local/opt/sqlite/bin:$PATH
export PATH=/usr/local/opt/ncurses/bin:$PATH
export PATH=/usr/local/opt/bzip2/bin:$PATH
export PATH=/usr/local/opt/sphinx-doc/bin:$PATH
export PATH=/usr/local/opt/gettext/bin:$PATH
export PATH=/usr/local/opt/icu4c/bin:$PATH
export PATH=/usr/local/opt/icu4c/sbin:$PATH
export PATH=/usr/local/opt/curl/bin:$PATH
export PATH=/usr/local/opt/meson-internal/bin:$PATH
export PATH=/usr/local/opt/mysql-client/bin:$PATH
export PATH=/usr/local/opt/qt/bin:$PATH
export PATH=/usr/local/opt/apr/bin:$PATH
export PATH=/usr/local/opt/apr-util/bin:$PATH
export PATH=/usr/local/opt/openssl/bin:$PATH
export PATH=/usr/local/opt/curl/bin:$PATH
export PATH=/usr/local/opt/go/libexec/bin:$PATH
export PATH=/usr/local/opt/sqlite/bin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH

