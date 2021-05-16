#!/bin/bash
#set -e   #-- Must be disabled so Mac terminals don't auto exit
#
# AMK Sets the admin's profile
#
# TERMINAL SETTINGS == MUST HAVE Brew bash_completion installed
# NOTE: Attempted to add below . . but didn't work???
# [-f/usr/local/etc/bash_completion]&&./usr/local/etc/bash_completion

 # if [ -f "/usr/local/opt/bash-git-prompt/share/gitprompt.sh" ]; then
 #   __GIT_PROMPT_DIR="/usr/local/opt/bash-git-prompt/share"
 #   source "/usr/local/opt/bash-git-prompt/share/gitprompt.sh"
 # fi
# -----------------------------------
# AMK-NOTE2self
# Global vars should be all UPPERCASE.
# Start phasing out the lowercase versions.
# -----------------------------------

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# SET SYSTEM VARS
export SNAME="janeway"

#
# For PurgeCSS to use PostCSS to minify tailwindcss for production environments
#export NODE_ENV="production"
export NODE_ENV="development"
#
#export srcPath=/Users/admin/SparkleShare/amkScripts
export AMKPATH=/usr/local/_amkScripts
export SNAMEPATH=$AMKPATH/_$SNAME

#DYLD_LIBRARY_PATH environment variable

# ARLENE'S SPECIFIC ALIAS
alias amk='cd $AMKPATH/'
alias SNAMEPATH='cd $AMKPATH/_$SNAME'
#alias devism='cd /Users/akliewer/Repos-git/starfire/iSkyMarshal'
alias devism='cd ~/Repos-git/_ism/ism-deploy/'
alias ll='ls -al'
alias nprofile='source ~/.profile'
alias newsource='source ~/.profile'
alias revrunDjango='cd /Users/akliewer/Repos-git/django_rev_run/revrun'
alias amkwprig='cd /usr/local/var/www/wordpress/wp-content/themes/wprig/'

# For ism/gulp to work
alias gulp="node  /usr/local/lib/node_modules/gulp/bin/gulp.js"

# SHOW HIDDEN FILES
alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'

# HIDE HIDDEN FILES
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

## REMEMBER- KEEP FOUR (4) ITEMS ALPHABATIZED
## PATH, LDFLAGS, CPPFLAGS, PKG_CONFIG
#=== PATH =======================================
#export PATH=PasteNewValueHere:$PATH
export PATH=/usr/local/opt/apr/bin:$PATH
export PATH=/usr/local/opt/apr-util/bin:$PATH
export PATH=/usr/local/opt/bison/bin:$PATH
export PATH=/usr/local/opt/curl/bin:$PATH
export PATH=/usr/local/opt/curl-openssl/bin:$PATH
export PATH=/usr/local/opt/gettext/bin:$PATH
export PATH=/usr/local/opt/icu4c/bin:$PATH
export PATH=/usr/local/opt/icu4c/sbin:$PATH
export PATH=/usr/local/opt/krb5/bin:$PATH
export PATH=/usr/local/opt/krb5/sbin:$PATH
export PATH=/usr/local/opt/libpq/bin:$PATH
export PATH=/usr/local/mongodb/mongodb/bin:$PATH
export PATH=/usr/local/opt/openldap/bin:$PATH
export PATH=/usr/local/opt/openldap/sbin:$PATH
export PATH=/usr/local/opt/openssl@1.1/bin:$PATH
export PATH=/usr/local/opt/php@7.2/bin:$PATH
export PATH=/usr/local/opt/php@7.2/sbin:$PATH
export PATH=/usr/local/opt/python@3.9/bin:$PATH
export PATH=/usr/local/opt/sphinx-doc/bin:$PATH
export PATH=/usr/local/opt/sqlite/bin:$PATH
export PATH=/usr/local/opt/tcl-tk/bin:$PATH
export PATH=/usr/local/var/www/wordpress/wp-content/themes/wprig/vendor/squizlabs/php_codesniffer/bin:$PATH


#=== LDFLAGS =======================================
#LDFLAG_PATHS=PasteNewValueHere:$LDFLAG_PATHS
LDFLAG_PATHS=/usr/local/opt/bison/lib:$LDFLAG_PATHS
LDFLAG_PATHS=/usr/local/opt/curl/lib:$LDFLAG_PATHS
LDFLAG_PATHS=/usr/local/opt/curl-openssl/lib:$LDFLAG_PATHS
LDFLAG_PATHS=/usr/local/opt/gettext/lib:$LDFLAG_PATHS
LDFLAG_PATHS=/usr/local/opt/icu4c/lib:$LDFLAG_PATHS
LDFLAG_PATHS=/usr/local/opt/krb5/lib:$LDFLAG_PATHS
LDFLAG_PATHS=/usr/local/opt/libffi/lib:$LDFLAG_PATHS
LDFLAG_PATHS=/usr/local/opt/libpq/lib:$LDFLAG_PATHS
LDFLAG_PATHS=/usr/local/opt/openldap/lib:$LDFLAG_PATHS
LDFLAG_PATHS=/usr/local/opt/openssl@1.1/lib:$LDFLAG_PATHS
LDFLAG_PATHS=/usr/local/opt/php@7.2/lib:$LDFLAG_PATHS
LDFLAG_PATHS=/usr/local/opt/python@3.9/lib:$LDFLAG_PATHS
LDFLAG_PATHS=/usr/local/opt/readline/lib:$LDFLAG_PATHS
LDFLAG_PATHS=/usr/local/opt/sqlite/lib:$LDFLAG_PATHS
LDFLAG_PATHS=/usr/local/opt/tcl-tk/lib:$LDFLAG_PATHS

#=== CPPFLAGS =======================================
#CPPFLAG_PATHS=PasteNewValueHere:$CPPFLAG_PATHS
CPPFLAG_PATHS=/usr/local/opt/curl/include:$CPPFLAG_PATHS
CPPFLAG_PATHS=/usr/local/opt/curl-openssl/include:$CPPFLAG_PATHS
CPPFLAG_PATHS=/usr/local/opt/gettext/include:$CPPFLAG_PATHS
CPPFLAG_PATHS=/usr/local/opt/icu4c/include:$CPPFLAG_PATHS
CPPFLAG_PATHS=/usr/local/opt/krb5/include:$CPPFLAG_PATHS
CPPFLAG_PATHS=/usr/local/opt/libpq/include:$CPPFLAG_PATHS
CPPFLAG_PATHS=/usr/local/opt/openldap/include:$CPPFLAG_PATHS
CPPFLAG_PATHS=/usr/local/opt/openssl@1.1/include:$CPPFLAG_PATHS
CPPFLAG_PATHS=/usr/local/opt/php@7.2/include:$CPPFLAG_PATHS
CPPFLAG_PATHS=/usr/local/opt/readline/include:$CPPFLAG_PATHS
CPPFLAG_PATHS=/usr/local/opt/sqlite/include:$CPPFLAG_PATHS
CPPFLAG_PATHS=/usr/local/opt/tcl-tk/include:$CPPFLAG_PATHS

#=== PKG_CONFIG =======================================
#PKG_CONFIG=PasteNewValueHere:$PKG_CONFIG
PKG_CONFIG=/usr/local/opt/curl/lib/pkgconfig:$PKG_CONFIG
PKG_CONFIG=/usr/local/opt/curl-openssl/lib/pkgconfig:$PKG_CONFIG
PKG_CONFIG=/usr/local/opt/icu4c/lib/pkgconfig:$PKG_CONFIG
PKG_CONFIG=/usr/local/opt/krb5/lib/pkgconfig:$PKG_CONFIG
PKG_CONFIG=/usr/local/opt/libffi/lib/pkgconfig:$PKG_CONFIG
PKG_CONFIG=/usr/local/opt/libpq/lib/pkgconfig:$PKG_CONFIG
PKG_CONFIG=/usr/local/opt/openssl@1.1/lib/pkgconfig:$PKG_CONFIG
PKG_CONFIG=/usr/local/opt/python@3.9/lib/pkgconfig:$PKG_CONFIG
PKG_CONFIG=/usr/local/opt/readline/lib/pkgconfig:$PKG_CONFIG
PKG_CONFIG=/usr/local/opt/sqlite/lib/pkgconfig:$PKG_CONFIG
PKG_CONFIG=/usr/local/opt/tcl-tk/lib/pkgconfig:$PKG_CONFIG

#=== EXPORTS =======================================
export LDFLAGS=-L$LDFLAG_PATHS
export CPPFLAGS=-I$CPPFLAG_PATHS
export PKG_CONFIG_PATH=$PKG_CONFIG
export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
export FIRESTORE_EMULATOR_HOST=localhost:8080

#=== REMEMBER- In order to keep above alphabetized 
# and have below appear last - The below must be the last statements.
export PATH=/usr/local/_amkScripts:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH
