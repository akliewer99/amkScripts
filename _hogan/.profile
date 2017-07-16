## @file Initaling hogan enviornment
## @author Arlene Kliewer
## @date 8/22/14

# INCLUDE SYSTEM VARS
export sname="hogan" 
export amkPath="/usr/local/_amk/_scripts" 
export snamePath="$amkPath/_$sname" 

export daemonsPath="/Library/LaunchDaemons"
export webappsPath="/Library/Server/Web/Config/apache2/webapps"

export dbxPath="/Users/admin/Dropbox/amkScripts/_scripts"
export localhostPath="/Library/WebServer/local_websites/localhost"

# ARLENE SPECIFIC ALIAS
alias amk='cd $amkPath'
alias $sname='cd $amkPath/_$sname'
alias la='ls -al'
alias nprofile='source ~/.profile'
alias iphone='open /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Applications/iPhone\ Simulator.app'
alias amkAWS='cd $amkPath/\_aws/\_amkAWS'
alias tnkAWS='cd $amkPath/\_aws/\_tnkAWS'

# SHOW / HIDE HIDDEN FILES
alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

# PATH STATEMENT
export PATH="/usr/local/bin:/usr/libexec/java_home/bin:$amkPath:/usr/local/mysql/bin:$PATH:/usr/sbin:/sbin"

# Use have Ruby use Homebrew directories
export RBENV_ROOT="/usr/local/var/rbenv"

# To enable shims and autocompletion add to your profile:
  if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# BUILD VARIABLES
# export ARCHFLAGS="-ARCH X86_64"
export CPPFLAGS="-I/usr/local/opt/llvm/include:/usr/local/opt/curl/include:/usr/local/opt/libxml2/include:/usr/local/opt/zlib/include:/usr/local/opt/gettext/include:/usr/local/opt/sqlite/include:/usr/local/opt/icu4c/include:/usr/local/opt/readline/include:/usr/local/opt/libxml2/include:/usr/local/opt/openssl/include"
export LDFLAGS="-L/usr/local/opt/llvm/lib:/usr/local/opt/curl/lib:/usr/local/opt/libxml2/lib:/usr/local/opt/zlib/lib:/usr/local/opt/gettext/lib:/usr/local/opt/libffi/lib:/usr/local/opt/sqlite/lib:/usr/local/opt/icu4c/lib:/usr/local/opt/openssl/lib:/usr/local/opt/readline/lib:/usr/local/opt/libxml2/lib:/usr/local/opt/openssl/lib"
export GDK_PIXBUF_MODULEDIR="/usr/local/lib/gdk-pixbuf-2.0/2.10.0/loaders"

# JAVA MYSQL CONNECTORS
export JAVA_HOME="/usr/libexec/java_home"
export CLASSPATH="/Library/Java/Extensions" 
	
# FOR PYTHON INSTALLATION
export PYTHON_EGG_CACHE="/tmp/egg-cache"
export PYTHONPATH="/usr/local/lib/python2.7/site-packages:/usr/local/lib/svn-python"

# TRAC Vars
export trac_env_parent_dir="/usr/local/tracs/projects"
export TRAC_ENV_PARENT_DIR="/usr/local/tracs/projects"

# Enable Perlbrew
#source ~/perl5/perlbrew/etc/bashrc
