#!/usr/local/bin/bash
#############################################################################################################################
#                                                                                                                           #
#                                          Core CPU Values (Environment Variables                                           #
#                                                                                                                           #
#############################################################################################################################
export ANT_OPTS="-Xmx1024m -Xms512m -XX:MaxPermSize=512m"
export JAVA_OPTS="-Xmx2024m -Xms1024m -XX:MaxPermSize=512m"
export HOSTNAME=$(hostname)
bind '\C-Space':complete
bind '\C-i':menu-complete
bind '"\ew": backward-kill-word'

# Override defaults
export HISTSIZE=1500
export HISTCONTROL=erasedups

#export SCALA_HOME=/Users/vcutten/workrepos/apparat/scala-2.8.2.final
#export PYTHONPATH=/usr/lib/python2.6/site-packages

#Enable Colors
#export CLICOLOR=1
#export LSCOLORS=ExFxCxDxBxegedabagacad
#export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
#export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
#export LESS_TERMCAP_me=$'\E[0m'           # end mode
#export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
#export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
#export LESS_TERMCAP_ue=$'\E[0m'           # end underline
#export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline

#############################################################################################################################
#                                                                                                                           #
#                                           Completion Specific Bash Stuff                                                  #
#                                                                                                                           #
#############################################################################################################################
unalias ll 2>/dev/null
unalias ls 2>/dev/null
#TODO: export your java home too brah
if [[ $(uname) =~ Darwin ]]; then
	# export FLEX_HOME="/usr/local/bin/flexsdks/4.6.0.23201B"
	# export PAGER=vimpager
	source ~/.pirate-setup/secrets
	export FLEX_HOME="/usr/local/bin/flexsdks/4.6.0.23201Bair3.5"
	export vimdir=$HOME/.vim
	export EDITOR=/Applications/MacVim.app/Contents/MacOS/Vim
	if [[ $HOSTNAME =~ "vito-mbp" ]]; then                                                                           
		export HOSTSTUB="vito-mbp";
	elif [[ $HOSTNAME =~ "vito-tower" ]]; then
		export HOSTSTUB="vito-tower";
	elif [[ $HOSTNAME =~ "destro-tower" ]]; then
		export HOSTSTUB="destro-tower";
	else
		export HOSTSTUB=$HOSTNAME;
	fi
	export JAVA_HOME=$(/usr/libexec/java_home)

	if [ -f $(brew --prefix)/share/bash-completion/bash_completion ]; then
		. $(brew --prefix)/share/bash-completion/bash_completion
	fi

	vbp() { vim $@ ~/.pirate-setup/bashrc; }
	cbp() { source ~/.bashrc; }
	ls() { command ls -G "$@"; }
	fn() { command find . -iname "$@"; }
	ff() { 

		if [[ "$2" == "" ]]; then 
			type='*.cs';
		else
			type='*.'"$2";
		fi
		#echo "root: $1  stem: $type"
		if [[ "$3" == "" ]]; then 
			find . \( -name .\*~ -o -name \*.meta -prune \) -o -iname "$1""$type" -print; 
		else
			find "$3" \( -name .\*~ -o -name \*.meta -prune \) -o -iname "$1""$type" -print; 
		fi
	}
	grep() { command grep --color=auto "$@"; }
	ll() { command ls -lGh "$@"; }
	la() { command ls -lGha "$@"; }
	vimdiff() { command vim -d "$@"; }
	vif() { command vim $(ff "$@"); }
else
	export FLEX_HOME="/var/lib/flexsdks/4.6.0.23201B"
	export HOSTSTUB=$(regex='.*([A-Za-z]{3}-[0-9][0-9]).*'; [[ "$HOSTNAME" =~ $regex ]] && echo "${BASH_REMATCH[1]}");
	if [[ $HOSTSTUB == "" ]]; then
    	export HOSTSTUB=$(hostname -s);
	fi
	vbp() { vim $@ ~/.bash_awesome; }
	cbp() { source ~/.bash_awesome; }
	ls() { command ls --color=always "$@"; }
	grep() { command grep --color=always "$@"; }
	ll() { command ls --color=always -lh "$@"; }
	la() { command ls --color=always -lha "$@"; }
fi

export FCSH=$FLEX_HOME/bin/fcsh
export PLAN9=/usr/local/plan9
PATH=$PATH:$PLAN9/bin
export PATH="/usr/local/bin:/usr/local/bin/bash:/usr/sbin/user:~/.pirate-vim/bin:$FLEX_HOME/bin:$PATH:$PLAN9/bin:/usr/local/share/npm/bin:/usr/local/Cellar/node/0.10.7/lib/node_modules/npm/bin/node-gyp-bin"
#export HOSTSTUB=$(hostStub);                                                                                      
export PS1="\[\e[36;1m\][\A] \[\e[0;35m\]$HOSTSTUB \[\e[31;1m\]\w> \[\e[0m\]"                                     
export PS2="\[\e[31;1m\]> \[\e[0m\]"                                                                              
#echo -e "\033];$HOSTSTUB\007";
if [ -f /usr/local/git/contrib/completion/git-completion.bash ]; then
	. /usr/local/git/contrib/completion/git-completion.bash
fi

#####################################################
# Navigation commands
####################################################

# Find Directory there are going to be named short cuts here
# $1 = sub dir to find ?
# repo traverse up to either home dir or repo git repo dir
fd()
{
	case "$1" in
		'repo')
			startdir=$PWD;
			while [[ $PWD != $HOME && $(ls -a | grep '^.git$') != '.git' ]]; do cd ..; done;
			enddir=$PWD;
			cd $startdir;
			cd $enddir;
		;;
	esac
}

rename()
{
	find -E . -regex '\./[0-9]..*' -exec bash -c 'name=${1##*/}; mv "$name" "${name:2}";' _ {} \;
}

bump()
{
	echo "bump" >> util/bump.txt;
	git ci -m "bumping build"
	git push origin rainbow-pod
}

blame-game()
{
	echo "" | pbcopy; for file in $1; do line="---------$file----------"; bar=$(git blame --line-porcelain "$file" | sed -n 's|^author||p' | sed -E '/(tz|time|mail)/d' | sort | uniq -c | sort -rn); printf '%s\n%s\n%s\n' "$(pbpaste)" "$line" "$bar" | pbcopy; done;
}

list-size() 
{
	du -sk "$@" | sort -rn | awk -F '\t' -v OFS='\t' '{if ($1 > 1048576) $1 = sprintf("%.1fG",$1/1048576); else if ($1 > 1024) $1 = sprintf("%.1fM",$1/1024); else $1 = sprintf("%sK",$1)} 1'
	#du -sk "$@" | sort -n | awk '{if ($1 > 1048576) printf("%.1fG\t%s\n",$1/1048576,$2); else if ($1 > 1024) printf("%.1fM\t%s\n",$1/1024,$2); else printf("%sK\t%s\n",$1,$2) }'
}

ql(){
	qlmanage -p "$@" >& /dev/null &
}

git-revive()
{
	git checkout $(git rev-list -n 1 HEAD -- "$1")~1 -- "$1"
}

git-branch-diff()
{
	git d $2:$1 $3:$1
}

yumdiff()
{
	vimdiff <($1 'yum list installed') <($2 'yum list installed')
}

badassets()
{
	for line in $(grep -irn 'jxr' assets/**/*.json | sed 's|[\"|,]||g' | sed "s|\'||g" | awk '{print $1 "," $3}'); do 
		img="assets/${line#*,}";
		json=${line%,*}; 
		if [[ ! -f $img ]]; then 
			echo "file: $json   img: $img";
		fi 
	done
}

#hostStub()                                                                                                        
#{                                                                                                                 
#	if [[ $HOSTNAME =~ "local" ]]; then                                                                           
#		echo $(hostname -s);                                                                                      
#	else                                                                                                          
#		if [[ $(regex='.*([A-Za-z]{3}-[0-9][0-9]).*'; [[ "$HOSTNAME" =~ $regex ]] && echo "${BASH_REMATCH[1]}") =~ "" ]]; then
#			echo $(hostname -s);
#		else
#			echo $(regex='.*([A-Za-z]{3}-[0-9][0-9]).*'; [[ "$HOSTNAME" =~ $regex ]] && echo "${BASH_REMATCH[1]}"); 
#		fi
#	fi                                                                                                            
#}                                                                                                                 
#
#alias ld="ls -lh !(Icon?)"
#ll { 
#	if [[ $1 =~ "-" ]]; then
#		ls -lh $1 !(Icon?) $2
#	else
#		ls -lh !(Icon?) $1
#	fi
#}
shopt -s extglob
shopt -s cdspell
shopt -s nocaseglob
shopt -s histappend
shopt -u expand_aliases
shopt -s globstar

#Execute Apple Scripts
alias ttheme='osascript "$PATH_ASCRIPTS/SetTerminalTheme.scpt"'
alias mbdesktop='osascript "$PATH_ASCRIPTS/SpacesMobile.scpt"'
alias wrkdesktop='osascript "$PATH_ASCRIPTS/SpacesWork.scpt"'

#svn() { command svn "$@" | say; }
#kickers
#alias khttpd='sudo /etc/init.d/httpd restart'
#alias kjenk='sudo /etc/init.d/jenkins restart'

# Test remote host:port availability (TCP-only as UDP does not reply)
    # $1 = hostname
    # $2 = port
function port() {
    (echo >/dev/tcp/$1/$2) &>/dev/null
    if [ $? -eq 0 ]; then
        echo "$1:$2 is open"
    else
        echo "$1:$2 is closed"
    fi
}

checkPort(){
	exec 6<>/dev/tcp/127.0.0.1/$1
}

#############################################################################################################################
#                                                                                                                           #
#                                           Utility Functions with some server specific                                     #
#                                                                                                                           #
#############################################################################################################################
export dev1=${AWESOMEVILLE}-dev-01.zc1.zynga.com;
export dev2=${AWESOMEVILLE}-dev-02.zc1.zynga.com;
export dev3=${AWESOMEVILLE}-dev-03.zc1.zynga.com;
export dev4=${AWESOMEVILLE}-dev-04.zc1.zynga.com;
export dev5=${AWESOMEVILLE}-dev-05.zc1.zynga.com;
export dev6=${AWESOMEVILLE}-dev-06.zc1.zynga.com;
export dev7=${AWESOMEVILLE}-dev-07.zc1.zynga.com;
export slave01=${AWESOMEVILLE}-build-slave01.zc1.zynga.com;
export slave02=${AWESOMEVILLE}-build-slave02.zc1.zynga.com;
export slave03=${AWESOMEVILLE}-build-slave03.zc1.zynga.com;
export master=${AWESOMEVILLE}-build-master.zc1.zynga.com;
export zconold=${VILLE}-staging-zcon-01.zc2.zynga.com;

cpd1() { scp -r ${AWESOMEVILLE}-dev-01.zc1.zynga.com $@; } 
cpd2() { scp -r ${AWESOMEVILLE}-dev-02.zc1.zynga.com $@; }   
cpd3() { scp -r ${AWESOMEVILLE}-dev-03.zc1.zynga.com $@; }   
cpd4() { scp -r ${AWESOMEVILLE}-dev-04.zc1.zynga.com $@; }   
cpd5() { scp -r ${AWESOMEVILLE}-dev-05.zc1.zynga.com $@; }   
cpd6() { scp -r ${AWESOMEVILLE}-dev-06.zc1.zynga.com $@; }   
cpd7() { scp -r ${AWESOMEVILLE}-dev-07.zc1.zynga.com $@; }   
cpl1(){ scp -r ${AWESOMEVILLE}-build-slave01.zc1.zynga.com $@; }   
cpl2(){ scp -r ${AWESOMEVILLE}-build-slave02.zc1.zynga.com $@; }   
cpl3(){ scp -r ${AWESOMEVILLE}-build-slave03.zc1.zynga.com $@; }   
cpm(){ scp -r ${AWESOMEVILLE}-build-master.zc1.zynga.com $@; }   
cpfstage() { scp -r ${VILLE}-staging-zcon-01.zc2.zynga.com $@; }

ssd1() { ssh ${AWESOMEVILLE}-dev-01.zc1.zynga.com $@; } 
ssd2() { echo -e "\033];dev-02\007"; ssh ${AWESOMEVILLE}-dev-02.zc1.zynga.com $@; }   
ssd3() { echo -e "\033];dev-03\007"; ssh ${AWESOMEVILLE}-dev-03.zc1.zynga.com $@; }   
ssd4() { echo -e "\033];dev-04\007"; ssh ${AWESOMEVILLE}-dev-04.zc1.zynga.com $@; }   
ssd5() { echo -e "\033];dev-05\007"; ssh ${AWESOMEVILLE}-dev-05.zc1.zynga.com $@; }   
ssd6() { echo -e "\033];dev-06\007"; ssh ${AWESOMEVILLE}-dev-06.zc1.zynga.com $@; }   
ssd7() { echo -e "\033];dev-07\007"; ssh ${AWESOMEVILLE}-dev-07.zc1.zynga.com $@; }   
ssl1(){ echo -e "\033];fslave-01\007"; ssh ${AWESOMEVILLE}-build-slave01.zc1.zynga.com $@; }   
ssl2(){ echo -e "\033];fslave-02\007"; ssh ${AWESOMEVILLE}-build-slave02.zc1.zynga.com $@; }   
ssl3(){ echo -e "\033];fslave-03\007"; ssh ${AWESOMEVILLE}-build-slave03.zc1.zynga.com $@; }   
ssm(){ echo -e "\033];fmaster\007"; ssh ${AWESOMEVILLE}-build-master.zc1.zynga.com $@; }   
ssb(){ echo -e "\033];brobot\007"; ssh farm-brobot $@; }   
ssvt(){ ssh vcutten@vito-tower.local $@; }
ssdt(){ ssh redhand@destro-tower.local $@; }
ssmb(){ ssh vcutten@vito-mbp.local $@; }
ssfstage() { echo -e "\033];fstage\007"; ssh ${VILLE}-staging-zcon-01.zc2.zynga.com $@; }
#farm2-staging-web-fb-22

openFlex()                                                                                               
{                                                                                                                 
	open -n "/Applications/Adobe Flash Builder 4.6/Adobe Flash Builder 4.6.app"                                   
}                                                                                                                 
                                                                                                                  
#RedTamarin 
#redrun
#{
#	#/Users/vcutten/workspaces/${AWESOMEVILLE}-files/vcutten-repo/prototype/RedServer/bin/redshell $1
#	#/Users/vcutten/workspaces/greenpod/RedServer/bin/redshell $1
#}
#
#asc
#{
#	java -jar /Users/vcutten/workspaces/${AWESOMEVILLE}-files/vcutten-repo/prototype/RedServer/bin/asc.jar -AS3 -strict\
#			-import /Users/vcutten/workspaces/${AWESOMEVILLE}-files/vcutten-repo/prototype/RedServer/bin/builtin.abc\
#			-import /Users/vcutten/workspaces/${AWESOMEVILLE}-files/vcutten-repo/prototype/RedServer/bin/toplevel.abc\
#			-import /Users/vcutten/workspaces/${AWESOMEVILLE}-files/vcutten-repo/prototype/RedServer/bin/avmglue.abc $1; 
#}

#../redtamarin/bin-release/redshell ./src/ASIncludes.abc ./src/rtServer.abc -- 1000 8888 ~/dev/kingdoms/assets 0.0.0.0

trcflash()
{
	tail -f "/Users/vcutten/Library/Preferences/Macromedia/Flash Player/Logs/flashlog.txt"
}

trcunity()
{
	tail -f "$@" "/Users/$USER/Library/Logs/Unity/Editor.log"
}

trcphp()
{
	#TODO: add -a -e (default is -e) for access log
	if [[ $(uname) =~ Darwin ]]; then
		tail -f $1 | sed $'s/\\\\n/\\\n/g'
	fi
	if [[ $(uname) =~ Linux ]]; then
		tail -f /mnt/farm2dev/apps/$1/logs/error.log | sed $'s/\\\\n/\\\n/g'
	fi
	#tail -f /private/var/log/apache2/$1-error_log | sed $'s/\\\\n/\\\n/g'
	# sed -e 's/\\n/\n/g'; -cent os
	# also works 's/\\n/\'$'\n'/g - it's essentially inserting a literal carriage return

}

# Find File by Name Not part of svn
nfind()
{       
	find . -name $1
}

# export a display
vdisplay(){
    (Xvfb :$@ &); export DISPLAY=:$@
}

listenPort(){
    sudo ngrep -d lo0 -W byline port $@
}

ldapquick(){
    ldapsearch -x -h ds1.sv2.zynga.com -b  "dc=zynga,dc=com" "(memberUid=$1)" cn
}

#############################################################################################################################
#                                                                                                                           #
#                                           Utility Functions with some server specific                                     #
#                                                                                                                           #
#############################################################################################################################
checkService(){
	if ps ax | grep -v grep | grep $1 > /dev/null
	then
	    echo "$1 service running, everything is fine"
	else
		echo "$1 is not running"
	fi
}

alive(){
	if kill -0 "$1"; then echo "please don't kill me $1"; fi
}
showAll(){
	defaults write com.apple.Finder AppleShowAllFiles $1
	killall Finder
}
nonunicode(){
    grep --color='auto' -Prn "[\x80-\xFF]" $1
}

brobot-jira(){
	curl -u $JIRA_ACCT:$JIRA_PSWD https://jira.corp.zynga.com/rest/api/latest/issue/FARMTWO-39652.json
}

brobot-merge(){
	chat='Farm%202%20MERGE%20CHAT%20|%20Release%202012.08.13.01%20GH%20update%20|%20App:%20R1%20|%20Status:%20https://docs.google.com/a/zynga.com/spreadsheet/ccc?key=0AoX0nX5wfzbNdDd6Ql96NEVMU05aRTNMRUFrNlVtOVE#gid=186'
	msg=$1
	bot=http://skype.${AWESOMEVILLE}-dev-11.ec2.zynga.com/put_message.php
	curl -F body="$msg" $bot/put_message.php?toChat=$chat
	echo "curl -F body="$msg" $bot/put_message.php?toChat=$chat"
}

brobot-farmops(){
	#string=$1
	#msg="${string// /%20}"
	msg=$1
	bot=http://skype.${AWESOMEVILLE}-dev-11.ec2.zynga.com/put_message.php
	curl -F body="$msg" $bot/put_message.php?toChat=Farm%202%20-%20Ops
}

brobot-jenkins(){
	#string=$1
	#msg="${string// /%20}"
	msg=$1
	bot=http://skype.${AWESOMEVILLE}-dev-11.ec2.zynga.com/put_message.php
	curl -F body="$msg" $bot/put_message.php?toChat=Jenkins%20Test
}

brobot-test(){
	#string=$1
	#msg="${string// /%20}"
	msg=$1
	bot=http://skype.${AWESOMEVILLE}-dev-11.ec2.zynga.com/put_message.php
	curl -F body="$msg" $bot/put_message.php?toChat=Farm%202%20Robo%20Test
}

getFBUser(){
	name=
	100003778250086
}

# TODO: Fix this
updateStageUser(){
	name=$1 password=$2 fbid=$3

	GRAPH=https://graph.facebook.com;
	APP_FID="XX"
	APP_SEC="YY"
	ACC_TKN=$(curl -F type=client_cred -F client_id=$APP_FID -F client_secret=$APP_SEC -F grant_type=client_credentials $GRAPH/oauth/access_token | sed -nE 's|access_token=(.*)$|\1|p');
	echo "curl -F "password=$password" -F "name=$name" $GRAPH/$fbid?access_token=$ACC_TKN";
	curl -F "name=$name" -F "password=$password" $GRAPH/$fbid?access_token=$ACC_TKN;
}

# Get test user login
getRoboDomo(){
	GRAPH=https://graph.facebook.com;
	APP_FID="$1"
	APP_SEC="$2"
	FB_ID="100003999105669"
	ACC_TKN=$(curl -F type=client_cred -F client_id=$APP_FID -F client_secret=$APP_SEC -F grant_type=client_credentials $GRAPH/oauth/access_token | sed -nE 's|access_token=(.*)$|\1|p');
	#echo "curl -F "password=$password" -F "name=$name" $GRAPH/$fbid?access_token=$ACC_TKN";
	#curl -F "name=$name" -F "password=$password" $GRAPH/$fbid?access_token=$ACC_TKN;
	curl -F "installed=true" \
		-F "name=Robo Domo" \
		-F "locale=en_US" \
		-F "permissions=read_stream" \
		-F "method=post" \
		$GRAPH/$APP_FID/accounts/test-users?access_token=$ACC_TKN | sed -nE 's|.*"login_url":"([^"]*)".*|\1|p'
}

# Manage my ap
updateDevUser(){
	name=$1 password=$2 fbid=$3

	GRAPH=https://graph.facebook.com;
	APP_FID="$1"
	APP_SEC="$2"
	ACC_TKN=$(curl -F type=client_cred -F client_id=$APP_FID -F client_secret=$APP_SEC -F grant_type=client_credentials $GRAPH/oauth/access_token | sed -nE 's|access_token=(.*)$|\1|p');
	echo "curl -F "password=$password" -F "name=$name" $GRAPH/$fbid?access_token=$ACC_TKN";
	curl -F "name=$name" -F "password=$password" $GRAPH/$fbid?access_token=$ACC_TKN;
}

# Script needs to be run from repo root directory. 
manage_allApps(){
	GRAPH=https://graph.facebook.com;
	apps=(art blue feature{10..20} feature0{1..9} green rainbow red tractor trunk silver);
	for APP in "${apps[@]}"; do
		APP_FID=$(sed -En "s|.*'FB_APP_ID', ?'([^']*)'.*|\1|p" ~/workrepos/${AWESOMEVILLE}-main/Server/game/config/$APP/local.inc.php);
		APP_SEC=$(sed -En "s|.*'FB_API_SECRET', ?'([^']*)'.*|\1|p" ~/workrepos/${AWESOMEVILLE}-main/Server/game/config/$APP/local.inc.php);
		ACC_TKN=$(curl -F type=client_cred -F client_id=$APP_FID -F client_secret=$APP_SEC -F grant_type=client_credentials $GRAPH/oauth/access_token | sed -nE 's|access_token=(.*)$|\1|p');
		echo -e Exucing on app: $APP\n;
		echo -e curl $1 $GRAPH/$APP_FID?access_token=$ACC_TKN\n;
		curl $1 $GRAPH/$APP_FID?access_token=$ACC_TKN;
	done;
}

grepjson()
{ 
	find . -name .json -o -type f -exec grep --color=always "$@" /dev/null {} +; 
}

grepassetfree() 
{ 
	grep -E . -regex ".*\.(png|f3d|jxr|jpg|jegp|gif|json)" -prune -o -type f -exec grep --color=always "$@" /dev/null {} +;
}

# git(){ command git "?@" ; say }

# Find non-svn files then grep them
grepsvn() 
{ 
	find . -name .svn -prune -o -type f -exec grep "$@" /dev/null {} +; 
}

function grepfiles() 
{ 
	find . -name "$1" -exec grep -in --color="always" "$2" /dev/null {} +; 
}

navigate(){
	osascript -e 'tell application "Chrome" activate do JavaScript "window.open(http://www.yahoo.com)" in document 1 end tell'
	#osascript -e tell application "Chrome" \
	#	activate \
	#	do JavaScript "window.open('http://www.yahoo.com')" in document 1 \
	#end tell
}

cgame(){
	php /Users/vcutten/workrepos/${AWESOMEVILLE}-$1/Server/game/scripts/stitch_settings.php
}


function loadBlobToTest(){

	curl \
		-F action=load_user_blob \
		-F SN=1 \
		-F zyAuthHash=dd93517a5f8d83d2291a81596eb5b09b \
		-F zySig=1cf23cdb1aff583988fe5e0b151ba0f412ae051fc199a0de7a45dcc12e313641 \
		-F ZID=20192501005 \
		-F userblob_name=staging-lame \
		-F namespace=vcutten \
		http://fb.feature12.farmville2-dev-02.zc1.zynga.com/automation/api.php?
}

loadBlobTo(){
	curl -F action=load_user_blob \
		-F SN=1 \
		-F zyAuthHash=dd93517a5f8d83d2291a81596eb5b09b \
		-F zySig=1cf23cdb1aff583988fe5e0b151ba0f412ae051fc199a0de7a45dcc12e313641 \
		-F ZID=20192501005 \
		-F userblob_name=automationTest \
		http://fb.vcutten.${AWESOMEVILLE}-dev-04.zc1.zynga.com/public/automation/api.php?
}

prettyJson(){
	cat $1 | python -mjson.tool > $1.pt
}

loadBlobToStage(){
	curl -F action=load_user_blob \
		-F SN=1 \
		-F zyAuthHash=4871087f18221fcab65fbe58bdcfdd8d \
		-F zySig=c17cc50e2f5d033e172e94baea256a3ec75eb533177ba95887afd4c76c2f254e \
		-F ZID=20192501005 \
		-F userblob_name=staging-lame \
		http://farm2-staging-admin-01.zc2.zynga.com:8966/api.php
}
