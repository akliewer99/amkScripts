#!/usr/local/bin/bash
set -e
# AMK Sets the admin's profile
#
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# SET SYSTEM VARS
export sname="hogan"
export amkPath=/usr/local/_amk

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

# Dynamic Linked Librarys (Apple Var)
# Leave commented out. No longer needed.
#DYLD_LIBRARY_PATH

## NOTE: In order to prevent DUPLICATION I have
## decided to alphabetize the below three (3) items
## and export only once at the bottom of the file.
LDFLAG_PATHS=""
CPPFLAG_PATHS=""
PKG_CONFIG=""

#=== PATH =======================================
PATH=/usr/local/bin:$PATH
PATH=/usr/local/sbin:$PATH
# Those above must be first. Alphabetize starts below
PATH=/usr/local/_amk/_scripts:$PATH
PATH=/usr/local/opt/apr/bin:$PATH
PATH=/usr/local/opt/apr-util/bin:$PATH
PATH=/usr/local/opt/curl/bin:$PATH
PATH=/usr/local/opt/gettext/bin:$PATH
PATH=/usr/local/opt/go/libexec/bin:$PATH
PATH=/usr/local/opt/icu4c/bin:$PATH
PATH=/usr/local/opt/icu4c/sbin:$PATH
PATH=/usr/local/opt/llvm/bin:$PATH
PATH=/usr/local/opt/meson-internal/bin:$PATH
PATH=/usr/local/opt/mysql-client/bin:$PATH
PATH=/usr/local/opt/ncurses/bin:$PATH
PATH=/usr/local/opt/openssl/bin:$PATH
PATH=/usr/local/opt/qt/bin:$PATH
PATH=/usr/local/opt/ruby/bin:$PATH
PATH=/usr/local/opt/sphinx-doc/bin:$PATH
PATH=/usr/local/opt/sqlite/bin:$PATH
PATH=/usr/local/opt/tcl-tk/bin:$PATH
#PATH=PasteNewValueHere:$PATH
# This should be exported BEFORE the others below.
export PATH=$PATH

#=== LDFLAGS =======================================
LDFLAG_PATHS=/usr/local/opt/bzip2/lib:$LDFLAG_PATHS
LDFLAG_PATHS=/usr/local/opt/curl/lib:$LDFLAG_PATHS
LDFLAG_PATHS=/usr/local/opt/gettext/lib:$LDFLAG_PATHS
LDFLAG_PATHS=/usr/local/opt/icu4c/lib:$LDFLAG_PATHS
LDFLAG_PATHS=/usr/local/opt/libffi/lib:$LDFLAG_PATHS
LDFLAG_PATHS=/usr/local/opt/llvm/lib:$LDFLAG_PATHS
LDFLAG_PATHS=/usr/local/opt/mysql-client/lib:$LDFLAG_PATHS
LDFLAG_PATHS=/usr/local/opt/ncurses/lib:$LDFLAG_PATHS
LDFLAG_PATHS=/usr/local/opt/openssl/lib:$LDFLAG_PATHS
LDFLAG_PATHS=/usr/local/opt/qt/lib:$LDFLAG_PATHS
LDFLAG_PATHS=/usr/local/opt/readline/lib:$LDFLAG_PATHS
LDFLAG_PATHS=/usr/local/opt/ruby/lib:$LDFLAG_PATHS
LDFLAG_PATHS=/usr/local/opt/sqlite/lib:$LDFLAG_PATHS
LDFLAG_PATHS=/usr/local/opt/tcl-tk/lib:$LDFLAG_PATHS
LDFLAG_PATHS=/usr/local/opt/zlib/lib:$LDFLAG_PATHS
#LDFLAG_PATHS=PasteNewValueHere:$LDFLAG_PATHS

#=== CPPFLAGS =======================================
CPPFLAG_PATHS=/usr/local/opt/bzip2/include:$CPPFLAG_PATHS
CPPFLAG_PATHS=/usr/local/opt/curl/include:$CPPFLAG_PATHS
CPPFLAG_PATHS=/usr/local/opt/gettext/include:$CPPFLAG_PATHS
CPPFLAG_PATHS=/usr/local/opt/icu4c/include:$CPPFLAG_PATHS
CPPFLAG_PATHS=/usr/local/opt/llvm/include:$CPPFLAG_PATHS
CPPFLAG_PATHS=/usr/local/opt/mysql-client/include:$CPPFLAG_PATHS
CPPFLAG_PATHS=/usr/local/opt/ncurses/include:$CPPFLAG_PATHS
CPPFLAG_PATHS=/usr/local/opt/openssl/include:$CPPFLAG_PATHS
CPPFLAG_PATHS=/usr/local/opt/qt/include:$CPPFLAG_PATHS
CPPFLAG_PATHS=/usr/local/opt/readline/include:$CPPFLAG_PATHS
CPPFLAG_PATHS=/usr/local/opt/ruby/include:$CPPFLAG_PATHS
CPPFLAG_PATHS=/usr/local/opt/sqlite/include:$CPPFLAG_PATHS
CPPFLAG_PATHS=/usr/local/opt/tcl-tk/include:$CPPFLAG_PATHS
CPPFLAG_PATHS=/usr/local/opt/zlib/include:$CPPFLAG_PATHS
#CPPFLAG_PATHS=PasteNewValueHere:$CPPFLAG_PATHS

#=== PKG_CONFIG =======================================
PKG_CONFIG=/usr/local/opt/curl/lib/pkgconfig:$PKG_CONFIG
PKG_CONFIG=/usr/local/opt/icu4c/lib/pkgconfig:$PKG_CONFIG
PKG_CONFIG=/usr/local/opt/libffi/lib/pkgconfig:$PKG_CONFIG
PKG_CONFIG=/usr/local/opt/mysql-client/lib/pkgconfig:$PKG_CONFIG
PKG_CONFIG=/usr/local/opt/qt/lib/pkgconfig:$PKG_CONFIG
PKG_CONFIG=/usr/local/opt/openssl/lib/pkgconfig:$PKG_CONFIG
PKG_CONFIG=/usr/local/opt/readline/lib/pkgconfig:$PKG_CONFIG
PKG_CONFIG=/usr/local/opt/ruby/lib/pkgconfig:$PKG_CONFIG
PKG_CONFIG=/usr/local/opt/sqlite/lib/pkgconfig:$PKG_CONFIG
PKG_CONFIG=/usr/local/opt/tcl-tk/lib/pkgconfig:$PKG_CONFIG
#PKG_CONFIG=PasteNewValueHere:$PKG_CONFIG

#=== EXPORTS =======================================
export LDFLAGS="-L$LDFLAG_PATHS -Wl,-rpath,/usr/local/opt/llvm/lib"
export CPPFLAGS=-I$CPPFLAG_PATHS
export PKG_CONFIG_PATH=$PKG_CONFIG
export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
# SO PERL keep non-brewed cpan modules to persist across updates
eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5)"
