## @file Initaling hogan enviornment
## @author Arlene Kliewer
## @date 8/22/14

# INCLUDE SYSTEM VARS
export sname="hogan" ## @var System Name
export amkPath="/usr/local/_amk" ## @var
export snamePath="$amkPath/_scripts/_$sname" ## @var

export daemonsPath="/Library/LaunchDaemons"
export webappsPath="/Library/Server/Web/Config/apache2/webapps"

export dbxPath="/Users/admin/Dropbox/amkScripts/_scripts"
export localhostPath="/Library/WebServer/local_websites/localhost"

#export pandaMbkPath="$amkPath/_scripts/_pandaMbk"
#export newkirkPath="$amkPath/_scripts/_newkirk"
#export hoganPath="$amkPath/_scripts/_hogan"
#export carterPath="$amkPath/_scripts/_carter"

# Set Architecture Flags
export ARCHFLAGS="-ARCH X86_64"

# ARLENE SPECIFIC ALIAS
alias amk='cd $amkPath'
alias $sname='cd $amkPath/_$sname'
alias la='ls -al'
alias ll='ls -al'
alias newProfile='source ~/.profile'
alias iphone='open /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Applications/iPhone\ Simulator.app'
#alias amkAWS='cd $amkPath/\_aws/\_amkAWS'
#alias tnkAWS='cd $amkPath/\_aws/\_tnkAWS'

# SHOW / HIDE HIDDEN FILES
alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

## Build Variables & Paths
# PATH STATEMENT ---------------------------------------------------------------------
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
export PATH="$amkPath/_scripts:$PATH"
export PATH="/usr/local/opt/bison/bin:$PATH"
export PATH="/usr/local/opt/sphinx-doc/bin:$PATH"
export PATH="/usr/local/opt/sqlite/bin:$PATH:$PATH"
export PATH="/usr/local/opt/openssl/bin:$PATH"
export PATH="/usr/local/opt/icu4c/bin:$PATH"
export PATH="/usr/local/opt/icu4c/sbin:$PATH"
export PATH="/usr/local/opt/qt/bin:$PATH"
export PATH="/usr/local/opt/llvm/bin:$PATH"
export PATH="/usr/local/opt/apr/bin:$PATH"
export PATH="/usr/local/opt/apr-util/bin:$PATH"

# REMINDER: BELOW STMT ARE SEPARATED ONLY BY A SPACE!
# LDFLAGS ---------------------------------------------------------------------
export LDFLAGS="-L/usr/local/opt/bison/bin/lib"
export LDFLAGS="-L/usr/local/opt/gettext/lib $LDFLAGS"
export LDFLAGS="-L/usr/local/opt/libffi/lib $LDFLAGS"
export LDFLAGS="-L/usr/local/opt/readline/lib $LDFLAGS"
export LDFLAGS="-L/usr/local/opt/sqlite/lib $LDFLAGS"
export LDFLAGS="-L/usr/local/opt/openssl/lib $LDFLAGS"
export LDFLAGS="-L/usr/local/opt/icu4c/lib $LDFLAGS"
export LDFLAGS="-L/usr/local/opt/qt/lib $LDFLAGS"
export LDFLAGS="-L/usr/local/opt/llvm/lib $LDFLAGS"
export LDFLAGS="-L/usr/local/opt/zlib/lib $LDFLAGS"


# CPPFLAGS ---------------------------------------------------------------------
export CPPFLAGS="-I/usr/local/opt/gettext/include"
export CPPFLAGS="-I/usr/local/opt/readline/include $CPPFLAGS"
export CPPFLAGS="-I/usr/local/opt/sqlite/include $CPPFLAGS"
export CPPFLAGS="-I/usr/local/opt/openssl/include $CPPFLAGS"
export CPPFLAGS="-I/usr/local/opt/icu4c/include $CPPFLAGS"
export CPPFLAGS="-I/usr/local/opt/qt/include $CPPFLAGS"
export CPPFLAGS="-I/usr/local/opt/llvm/include $CPPFLAGS"
export CPPFLAGS="-I/usr/local/opt/zlib/include $CPPFLAGS"

# PKG_CONFIG_PATH ---------------------------------------------------------------------
export PKG_CONFIG_PATH="/usr/local/opt/libffi/lib/pkgconfig"
export PKG_CONFIG_PATH="/usr/local/opt/sqlite/lib/pkgconfig:$PKG_CONFIG_PATH"
export PKG_CONFIG_PATH="/usr/local/opt/openssl/lib/pkgconfig:$PKG_CONFIG_PATH"
export PKG_CONFIG_PATH="/usr/local/opt/icu4c/lib/pkgconfig:$PKG_CONFIG_PATH"
export PKG_CONFIG_PATH="/usr/local/opt/qt/lib/pkgconfig:$PKG_CONFIG_PATH"
export PATH="/usr/local/opt/zlib/lib/pkgconfig:$PATH"




