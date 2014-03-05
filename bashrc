#!/usr/local/bin/bash
#############################################################################################################################
#                                                                                                                           #
#                                          Core CPU Values (Environment Variables                                           #
#                                                                                                                           #
#############################################################################################################################
export ANT_OPTS="-Xmx1024m -Xms512m -XX:MaxPermSize=512m"
export JAVA_OPTS="-Xmx2024m -Xms1024m -XX:MaxPermSize=512m"
export HOSTNAME=$(hostname)
##
## Android SDK
##
export ANDROID_HOME=/usr/local/opt/android-sdk
export ANDROID_NDK=/usr/local/opt/android-ndk
export HOMEBREW_GITHUB_API_TOKEN="9a68042998770190facf2aedeab4a1794ac9a36f"

bind '\C-Space':complete
bind '\C-i':menu-complete
bind '"\ew": backward-kill-word'

# Override defaults
#export HISTSIZE=3600
#export PROMPT_COMMAND='history -a; history -r'
#PROMPT_COMMAND="history -a"
#shopt -s histappend
HISTFILESIZE=400000000
#HISTCONTROL=ignoredups:erasedups:ignoreboth
HISTCONTROL=ignoredups:erasedups
HISTSIZE=10000
PROMPT_COMMAND="history -n; history -w; history -c; history -r; $PROMPT_COMMAND"
PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
export HISTSIZE PROMPT_COMMAND HISTCONTROL
shopt -s histappend


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
export HOMEBREW_EDITOR=vim

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

	if [[ -f `brew --prefix`/share/bash-completion/bash_completion ]]; then
		source `brew --prefix`/share/bash-completion/bash_completion;
	fi

	disable-spotlight(){
		sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.metadata.mds.plist
	}

	enable-spotlight(){
		sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.metadata.mds.plist
	}
	omnisharp() {
		if [[ "$1" == "" ]]; then 
			slnloc=~/workrepos/mobile/FarmMobile/FarmMobile.sln;
		else
			slnloc="$1";
		fi

		omnisev=~/.pirate-setup/pirate-vim/bundle/Omnisharp/server;
		omnidir=$omnisev/OmniSharp/bin/Debug;

		if [[ -f $omnidir/OmniSharp.exe ]]; then
			mono $omnidir/OmniSharp.exe -s "$slnloc" "$@" > $omnidir/server.log 2>&1 & omnipid=$!;
		elif [[ -f $omnisev/OmniSharp.sln ]]; then
			xbuild $omnisev/OmniSharp.sln;
			mono $omnidir/OmniSharp.exe -s "$slnloc" "$@" > $omnidir/server.log 2>&1 & omnipid=$!;
		else
			echo "Unable to find Omnisharp";
		fi
	}

	vb() { vim $@ ~/.pirate-setup/bashrc; }
	vg() { vim $@ ~/.pirate-setup/gitconfig; }
	vv() { vim $@ ~/.vim/vimrc; }
	cb() { source ~/.bashrc; }
	ls() { command ls -G "$@"; }
	fn() { command find . -iname "$@"; }
	ehco() { command echo "$@"; }
	chmod() { command chmod "$@"; }
	fw() {
		file='*'"$1"'*'
		ff $file $2 $3
	}
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
	grep() { command grep --color='auto' "$@"; }
	ll() { command ls -lGh "$@"; }
	la() { command ls -lGha "$@"; }
	# might be causing vim diff issues
	vimdiff() { command vim -d "$@"; }
	vif() { 
		#if [[ "$2" == "" || "$2" == "*.cs" ]]; then 
#re='^[0-9]+$'
#if ! [[ $yournumber =~ $re ]] ; then
#   echo "error: Not a number" >&2; exit 1
#fi

		if [[ "$(pwd -P)" == "$HOME/workrepos/mobile"* ]]; then
			echo -e "\033];UNITY\007"
			if [[ -f "$1" ]]; then 
				command vim --servername UNITY --remote-silent "$@";
			else
				command vim --servername UNITY --remote-silent $(fw "$@"); 
			fi
		else
			command vim $(fw "$@" );
		fi
	}
	# pass profile name you want to set eg Dark or Light
	setProfile() {
		echo -e "\033]50;SetProfile=$1\a"
	}  
else
	export FLEX_HOME="/var/lib/flexsdks/4.6.0.23201B"
	export HOSTSTUB=$(regex='.*([A-Za-z]{3}-[0-9][0-9]).*'; [[ "$HOSTNAME" =~ $regex ]] && echo "${BASH_REMATCH[1]}");
	if [[ $HOSTSTUB == "" ]]; then
    	export HOSTSTUB=$(hostname -s);
	fi
	vb() { vim $@ ~/.bash_awesome; }
	cb() { source ~/.bash_awesome; }
	ls() { command ls --color=always "$@"; }
	grep() { command grep --color=always "$@"; }
	ll() { command ls --color=always -lh "$@"; }
	la() { command ls --color=always -lha "$@"; }
fi

export FCSH=$FLEX_HOME/bin/fcsh
export PLAN9=/usr/local/plan9
PATH="/usr/local/bin:$PATH"
#export PATH="~/.pirate-setup/bin:/usr/sbin/user:$PATH:/usr/local/share/npm/bin:/usr/local/Cellar/node/0.10.7/lib/node_modules/npm/bin/node-gyp-bin"
#PATH=$PATH:$PLAN9/bin
#export PATH="~/.pirate-setup/bin:/usr/sbin/user:$FLEX_HOME/bin:$PATH:$PLAN9/bin:/usr/local/share/npm/bin:/usr/local/Cellar/node/0.10.7/lib/node_modules/npm/bin/node-gyp-bin:/usr/local/bin"
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
count-files()
{
	find . -type d \( -name util -o -name AirLauncher \) -prune -o -name \*.mk -exec bash -c 'echo $1 $(cat $1 | wc -l) ' _ {} \;
}

count-lines()
{
	if [[ $1 == "" ]]; then dir="."; else dir="$1"; fi
	if [[ $2 == "" ]]; then name="*.cs"; else name="$2"; fi
	find $dir -type f -name $name -exec bash -c 'echo $(cat $1 | wc -l) $1' _ {} \;
}

fd()
{
	case "$1" in
		'r'|'repo'|'root')
			startdir=$PWD;
			while [[ $PWD != $HOME && $(ls -a | grep '^.git$') != '.git' && $PWD != / ]]; do cd ..; done;
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
	echo "" | pbcopy; 
	for file in $1; do 
		line="---------$file----------"; 
		bar=$(git blame --line-porcelain "$file" | sed -n 's|^author||p' | sed -E '/(tz|time|mail)/d' | sort | uniq -c | sort -rn); printf '%s\n%s\n%s\n' "$(pbpaste)" "$line" "$bar" | pbcopy; 
	done;
}

# find ./FarmMobile/Assets/Scripts -iname \*test\*.cs -print -exec sh -c 'file=$0; git --no-pager blame --line-porcelain "$file" | sed -n "s|^author||p" | sed -E "/(tz|time|mail)/d" | sort | uniq -c | sort -rn ' {} \;

list-size() 
{
	du -sk "$@" | sort -rn | awk -F '\t' -v OFS='\t' '{if ($1 > 1048576) $1 = sprintf("%.1fG",$1/1048576); else if ($1 > 1024) $1 = sprintf("%.1fM",$1/1024); else $1 = sprintf("%sK",$1)} 1'
	#du -sk "$@" | sort -n | awk '{if ($1 > 1048576) printf("%.1fG\t%s\n",$1/1048576,$2); else if ($1 > 1024) printf("%.1fM\t%s\n",$1/1024,$2); else printf("%sK\t%s\n",$1,$2) }'
}

ql()
{
	qlmanage -p "$@" >& /dev/null &
}

excuse()
{
	curl -s http://developerexcuses.com/ | perl -ne '/center.*nofollow.*?>(.*?)<\/a>/ and print "$1\n"'
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

checkPort()
{
	exec 6<>/dev/tcp/127.0.0.1/$1
}

#############################################################################################################################
#                                                                                                                           #
#                                           Utility Functions with some server specific                                     #
#                                                                                                                           #
#############################################################################################################################

ssb(){ echo -e "\033];brobot\007"; ssh farm2-brobot-01.zc2.zynga.com $@; }   
ssvt(){ ssh vcutten@vito-tower.local $@; }
ssdt(){ ssh redhand@destro-tower.local $@; }
ssmb(){ ssh vcutten@vito-mbp.local $@; }

export MINI01="mbx-farm201-zgn04689b";
export MINI02="mbx-farm202-zgn23872";
export MINI03="mbx-farm203-ga13051";
export MINI04="mbx-farm204-zyn04450b";
export MINI05="mbx-farm205-ca14769";
export MINI06="mbx-farm206-ca14774";
export MINI07="mbx-farm207-ca14757";
export MINI08="mbx-farm208-ca14766";
export MINI09="mbx-farm209-ca14735";

mini01(){ ssh z_farmville2_build@$MINI01 $@; }
mini02(){ ssh z_farmville2_build@$MINI02 $@; }
mini03(){ ssh z_farmville2_build@$MINI03 $@; }
mini04(){ ssh z_farmville2_build@$MINI04 $@; }
mini05(){ ssh z_farmville2_build@$MINI05 $@; }
mini06(){ ssh z_farmville2_build@$MINI06 $@; }
mini07(){ ssh z_farmville2_build@$MINI07 $@; }
mini08(){ ssh z_farmville2_build@$MINI08 $@; }
mini09(){ ssh z_farmville2_build@$MINI09 $@; }

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

trcomni()
{
	tail -f "$@" "/Users/$USER/.pirate-setup/pirate-vim/bundle/Omnisharp/server/Omnisharp/bin/Debug/server.log"
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


# export a display
vdisplay(){ (Xvfb :$@ &); export DISPLAY=:$@; }

listenPort(){ sudo ngrep -d lo0 -W byline port $@; }

ldapquick()
{
    ldapsearch -x -h ds1.ca2.zynga.com -b  "dc=zynga,dc=com" "(memberUid=$1)" cn
}

#############################################################################################################################
#                                                                                                                           #
#                                           Utility Functions with some server specific                                     #
#                                                                                                                           #
#############################################################################################################################
checkService()
{
	if ps ax | grep -v grep | grep $1 > /dev/null
	then
	    echo "$1 service running, everything is fine"
	else
		echo "$1 is not running"
	fi
}

alive()
{
	if kill -0 "$1"; then echo "please don't kill me $1"; fi
}
showAll()
{
	defaults write com.apple.Finder AppleShowAllFiles $1
	killall Finder
}
nonunicode(){ grep --color='auto' -Prn "[\x80-\xFF]" $1; }

brobot-jira()
{
	curl -u $JIRA_ACCT:$JIRA_PSWD https://jira.corp.zynga.com/rest/api/latest/issue/FARMTWO-39652.json
}

jira-get()
{
	curl -u $1:$2 -X 'POST' -H "Content-Type: application/json" 'https://jira.corp.zynga.com/rest/api/latest/search' -d '{"jql":"reporter=vcutten AND status=open","fields":["id","key"]}' | jq '.'
}

jira-close()
{
	curl -i -u $1:$2 -X 'POST' -H "Content-Type: application/json" 'https://jira.corp.zynga.com/rest/api/latest/issue/1778018/transitions' -d '{ "update": { "comment": [ { "add": { "body":"Resolved by farmbot" } } ] }, "transition": { "id" : "5" }, "fields": { "resolution": { "name": "Fixed" } } }'
	#curl -i -u $1:$2 -X 'POST' -H "Content-Type: application/json" 'https://jira.corp.zynga.com/rest/api/latest/issue/1778018/transitions' -d '{ "transition": { "id" : "5" }, "fields": { "resolution": { "name": "Duplicate" } } }'
}

brobot-merge()
{
	chat='Farm%202%20MERGE%20CHAT%20|%20Release%202012.08.13.01%20GH%20update%20|%20App:%20R1%20|%20Status:%20https://docs.google.com/a/zynga.com/spreadsheet/ccc?key=0AoX0nX5wfzbNdDd6Ql96NEVMU05aRTNMRUFrNlVtOVE#gid=186'
	msg=$1
	bot=http://skype.${AWESOMEVILLE}-dev-11.ec2.zynga.com/put_message.php
	curl -F body="$msg" $bot/put_message.php?toChat=$chat
	echo "curl -F body="$msg" $bot/put_message.php?toChat=$chat"
}

brobot-farmops()
{
	#string=$1
	#msg="${string// /%20}"
	msg=$1
	bot=http://skype.${AWESOMEVILLE}-dev-11.ec2.zynga.com/put_message.php
	curl -F body="$msg" $bot/put_message.php?toChat=Farm%202%20-%20Ops
}

brobot-jenkins()
{
	#string=$1
	#msg="${string// /%20}"
	msg=$1
	bot=http://skype.${AWESOMEVILLE}-dev-11.ec2.zynga.com/put_message.php
	curl -F body="$msg" $bot/put_message.php?toChat=Jenkins%20Test
}

brobot-test()
{
	#string=$1
	#msg="${string// /%20}"
	msg=$1
	bot=http://skype.${AWESOMEVILLE}-dev-11.ec2.zynga.com/put_message.php
	curl -F body="$msg" $bot/put_message.php?toChat=Farm%202%20Robo%20Test
}

get-config()
{
	JOB_NAME="$1"
	PASS="$2"
	SOURCE="http://vcutten:$PASS@ci.farm2mobile.zynga.com/view/All/job"
	#Here is the job
	echo "$SOURCE/$JOB_NAME/config.xml"
	curl -X GET "$SOURCE/$JOB_NAME/config.xml" -o tempconfig.xml
}

build-m17()
{
	TOKEN="2caddd33af1a18e53cee7645d82144e1"
	SOURCE="http://ci.farm3.zynga.com"
	JOB_NAME="M17_Pod_iOS"
	URL="$SOURCE/buildByToken/buildWithParameters?job=$JOB_NAME&token=$TOKEN"
	JSON="{\"parameter\": [{\"name\": \"taskfile\", \"value\": \"$taskfile\"},
			{\"name\": \"task\", \"value\": \"$task\"},
			{\"name\": \"jobParameters\", \"value\": \"$jobargs\"}], \"\": \"\"}"
	#wget --auth-no-challenge --http-user=user --http-password=apiToken http://jenkins.yourcompany.com/job/your_job/build?token=TOKEN
	#curl -X POST $url -d token=zorn --data-urlencode json="$json"
	# --data-urlencode json="$JSON"
	echo $URL
	curl -X POST $URL
}

copy-job()
{
#<<<<<<< HEAD
#	JOB_NAME="$1"
#	PASS="$2"
#	TOKEN="2caddd33af1a18e53cee7645d82144e1"
#	SOURCE="http://vcutten:$PASS@ci.farm2mobile.zynga.com:8080"
#	DESTINATION="http://10.84.209.85:8080"
#=======
#	pass="$1"
#	job_name="$2"
#	if [[ "$3" == "" ]]; then 
#		new_job_name="$1"
#	else
#		new_job_name="$3"
#	fi
#
#	target="http://vcutten:$pass@ci.farm2mobile.zynga.com:8080"
#	destination="http://farm2mobile-build-master.zc2.zynga.com"
#>>>>>>> a1f76f7f1ab30ac62ec16b013dfabd229c1e8f63
	#Here is the job
	curl -X GET "$target/job/$job_name/config.xml" -o tempconfig.xml

	#Update the configuration via posting a local configuration file
	#curl -X POST http://user:password@hudson.server.org/job/myjobname/config.xml --data-binary "@mymodifiedlocalconfig.xml"

	#Creating a new job via posting a local configuration file
	curl -X POST "$destination/createItem?name=$new_job_name" --data-binary "@tempconfig.xml" -H "Content-Type: text/xml"
	
	rm tempconfig.xml
}

edit-job-params(){
	pass="$1"
	job_name="$2"
	param="$3"
	query=
	#value="git submodule update --force --init; git submodule update --force"
	value="$4"
	target="http://vcutten:$pass@ci.farm2mobile.zynga.com"
	curl -X GET "$target/job/$job_name/config.xml" -o tempconfig.xml
	echo "-- Before Edit ----------------------------------------------"
	xpath tempconfig.xml "$3/text()" 2>/dev/null
	echo -e "\n-------------------------------------------------------------"
	xml ed -L -u "$query" -v "$value" tempconfig.xml
	echo "-- After Edit -----------------------------------------------"
	xpath tempconfig.xml "$3/text()" 2>/dev/null
	echo -e "\n-------------------------------------------------------------"
	#curl -X POST "$target/job/$job_name/config.xml" --data-binary "@tempconfig.xml" -H "Content-Type: text/xml"
	#rm -f tempconfig.xml
	echo -e "-- Complete -------------------------------------------------"
	#for job in M{01..16}_Pod_{iOS,Android}; do edit-job $pass $job; done
}

edit-job(){
	pass="$1"
	job_name="$2"
	#query="//builders/hudson.tasks.Shell[1]/command"
	query="$3"
	#value="git submodule update --force --init; git submodule update --force"
	value="$4"
	target="http://vcutten:$pass@ci.farm2mobile.zynga.com"
	curl -X GET "$target/job/$job_name/config.xml" -o tempconfig.xml
	echo "-- Before Edit ----------------------------------------------"
	xpath tempconfig.xml "$3/text()" 2>/dev/null
	echo -e "\n-------------------------------------------------------------"
	xml ed -L -u "$query" -v "$value" tempconfig.xml
	echo "-- After Edit -----------------------------------------------"
	xpath tempconfig.xml "$3/text()" 2>/dev/null
	echo -e "\n-------------------------------------------------------------"
	curl -X POST "$target/job/$job_name/config.xml" --data-binary "@tempconfig.xml" -H "Content-Type: text/xml"
	#rm -f tempconfig.xml
	echo -e "-- Complete -------------------------------------------------"
	#for job in M{01..16}_Pod_{iOS,Android}; do edit-job $pass $job; done
}

getFBUser()
{
	name=
	100003778250086
}

# TODO: Fix this
updateStageUser()
{
	name=$1 password=$2 fbid=$3

	graph=https://graph.facebook.com;
	app_fid="XX"
	app_sec="YY"
	acc_tkn=$(curl -F type=client_cred -F client_id=$app_fid -F client_secret=$app_sec -F grant_type=client_credentials $graph/oauth/access_token | sed -nE 's|access_token=(.*)$|\1|p');
	echo "curl -F "password=$password" -F "name=$name" $graph/$fbid?access_token=$acc_tkn";
	curl -F "name=$name" -F "password=$password" $graph/$fbid?access_token=$acc_tkn;
}

# Get test user login
getRoboDomo()
{
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
		$graph/$app_fid/accounts/test-users?access_token=$acc_tkn | sed -nE 's|.*"login_url":"([^"]*)".*|\1|p'
}

# Manage my ap
updateDevUser()
{
	name=$1 password=$2 fbid=$3

	graph=https://graph.facebook.com;
	app_fid="$1"
	app_sec="$2"
	acc_tkn=$(curl -F type=client_cred -F client_id=$app_fid -F client_secret=$app_sec -F grant_type=client_credentials $graph/oauth/access_token | sed -nE 's|access_token=(.*)$|\1|p');
	echo "curl -F "password=$password" -F "name=$name" $graph/$fbid?access_token=$acc_tkn";
	curl -F "name=$name" -F "password=$password" $graph/$fbid?access_token=$acc_tkn;
}

# Script needs to be run from repo root directory. 
manage_allApps()
{
	GRAPH=https://graph.facebook.com;
	apps=(art blue feature{10..20} feature0{1..9} green rainbow red tractor trunk silver);
	for APP in "${apps[@]}"; do
		app_fid=$(sed -En "s|.*'FB_APP_ID', ?'([^']*)'.*|\1|p" ~/workrepos/${AWESOMEVILLE}-main/Server/game/config/$app/local.inc.php);
		app_sec=$(sed -En "s|.*'FB_API_SECRET', ?'([^']*)'.*|\1|p" ~/workrepos/${AWESOMEVILLE}-main/Server/game/config/$app/local.inc.php);
		acc_tkn=$(curl -F type=client_cred -F client_id=$app_fid -F client_secret=$app_sec -F grant_type=client_credentials $graph/oauth/access_token | sed -nE 's|access_token=(.*)$|\1|p');
		echo -e Exucing on app: $app\n;
		echo -e curl $1 $graph/$app_fid?access_token=$acc_tkn\n;
		curl $1 $graph/$app_fid?access_token=$acc_tkn;
	done;
}

test_v2d2()
{
	GRAPH=https://graph.facebook.com;
	TOKEN=$(curl -F type=client_cred -F client_id=$FB_APP_V2D2 -F client_secret=$FB_SEC_V2D2 -F grant_type=client_credentials $GRAPH/oauth/access_token | sed -nE 's|access_token=(.*)$|\1|p');
	echo curl -F 'name=test' -F 'description=test group fun' -F 'privacy=secret' -F 'admin=true' $GRAPH/$FB_APP_V2D2/groups?access_token=$TOKEN;
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

navigate()
{
	osascript -e 'tell application "Chrome" activate do JavaScript "window.open(http://www.yahoo.com)" in document 1 end tell'
	#osascript -e tell application "Chrome" \
	#	activate \
	#	do JavaScript "window.open('http://www.yahoo.com')" in document 1 \
	#end tell
}

cgame()
{
	php /Users/vcutten/workrepos/${AWESOMEVILLE}-$1/Server/game/scripts/stitch_settings.php
}


function loadBlobToTest()
{

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

loadBlobTo()
{
	curl -F action=load_user_blob \
		-F SN=1 \
		-F zyAuthHash=dd93517a5f8d83d2291a81596eb5b09b \
		-F zySig=1cf23cdb1aff583988fe5e0b151ba0f412ae051fc199a0de7a45dcc12e313641 \
		-F ZID=20192501005 \
		-F userblob_name=automationTest \
		http://fb.vcutten.${AWESOMEVILLE}-dev-04.zc1.zynga.com/public/automation/api.php?
}

prettyJson()
{
	cat $1 | python -mjson.tool > $1.pt
}

loadBlobToStage()
{
	curl -F action=load_user_blob \
		-F SN=1 \
		-F zyAuthHash=4871087f18221fcab65fbe58bdcfdd8d \
		-F zySig=c17cc50e2f5d033e172e94baea256a3ec75eb533177ba95887afd4c76c2f254e \
		-F ZID=20192501005 \
		-F userblob_name=staging-lame \
		http://farm2-staging-admin-01.zc2.zynga.com:8966/api.php
}

#source ~/.pirate-setup/itermbkg
# perforce commands
export DEV=$HOME/workrepos/farm3/branches/dev/src;
export dev=$DEV;
diff-dev() 
{
	diff <(find ../dev -name $1 -exec md5 {} + | gsed 's|./dev||g') <(find . -name $1 -exec md5 {} +)
}

p4-art-cleanup() 
{ 
	for type in {"controller","mask","meta","png","psd","xml","fbx","anim","jpg","prefab","json","mat","tga","properties"}; do 
		p4 reopen -c $1 //farm3/....$type;
	done; 
}

getblob()
{
	ZID="37114529746";
	BLOB="player";
	APPID="5000880"; 
	if [[ $1 != "" ]]; then ZID="$1"; fi;
	if [[ $2 != "" ]]; then BLOB="$2"; fi;
	if [[ $3 != "" ]]; then APPID="$3"; fi;
	#echo "params: $ZID $BLOB $APPID";
	ZAPI="https://api.zynga.com"
	STORAGE="storage/v1/app/$APPID/blob/$BLOB/user/$ZID"
	export RAW=$(curl -s -X 'GET' "$ZAPI/$STORAGE" -H "app-id:$APPID" -H 'auth-type:app');
	export CAS=$(echo $RAW | jq ".data.$BLOB[\"$ZID\"].data.cas" | tr -d '"' );
	DATA=$( echo $RAW | jq ".data.$BLOB[\"$ZID\"].data.blob" | sed 's|\\"|"|g' | gsed -E 's/(^"|"$)|//g' );
	echo $DATA
}

setblob()
{
	#curl -i -X 'PUT' 'https://api.zynga.com/storage/v1/app/5000880/blob/player/user/37114529746' -H 'app-id:5000880' -H 'auth-type:app' -H 'Content-Type: application/json' -d '{ "payload":{ "cas": "'$CAS'", "value":"'"$(getblob  | jq '(.resources[] | select(.id == "consu_ribbon" ) | .amount)=5000 | .leaderboardName="GodFather"' | gsed 's|"|\\"|g' | xargs | gsed 's|"|\\"|g')"'"}}'
	echo "no op";
}

getleaderboards()
{
	ZID="37114529746";
	BOARD="countyfair-dev4";
	START=0;
	END=40;
	APPID="5000880"; 
	if [[ -n ${1+_} ]]; then ZID="$1"; fi;
	if [[ -n ${2+_} ]]; then BOARD="$2"; fi;
	if [[ -n ${3+_} ]]; then START="$3"; fi;
	if [[ -n ${4+_} ]]; then END="$4"; fi;
	if [[ -n ${5+_} ]]; then APPID="$5"; fi;
	ZAPI="https://api.zynga.com"
	STORAGE="leaderboards/v2/app/$APPID/leaderboard/$BOARD/id/$ZID?after=$END&rank=$START&extra=true"
	export RAW=$(curl -s -X 'GET' "$ZAPI/$STORAGE" -H "app-id:$APPID" -H 'auth-type:app');
	echo $RAW
}

getleaderboardPlayer()
{
	ZID="37114529746";
	APPID="5000880"; 
	if [[ -n ${1+_} ]]; then ZID="$1"; fi;
	if [[ -n ${2+_} ]]; then APPID="$2"; fi;
	ZAPI="https://api.zynga.com"
	STORAGE="leaderboards/v2/app/$APPID/id/$ZID?extra=true"
	export RAW=$(curl -s -X 'GET' "$ZAPI/$STORAGE" -H "app-id:$APPID" -H 'auth-type:app');
	echo $RAW
}

setleaderboardPlayer()
{
	ZID="37114529746";
	BOARD="countyfair-dev4";
	APPID="5000880"; 
	if [[ -n ${2+_} ]]; then ZID="$2"; fi;
	if [[ -n ${3+_} ]]; then BOARD="$3"; fi;
	if [[ -n ${4+_} ]]; then APPID="$4"; fi;
	ZAPI="https://api.zynga.com"
	STORAGE="leaderboards/v2/app/$APPID/leaderboard/$BOARD/id/$ZID"
	curl -s -X 'PUT' "$ZAPI/$STORAGE" -H "app-id:$APPID" -H 'auth-type:app' -H 'Content-Type: application/json'  -d @-
}

readtest()
{ 
	if [ -n "${*+_}" ]; then
		printf '***%s***\n' "$@";
	else
		read; printf '***%s***\n' "$REPLY";
	fi;
}
#foo(){ if [[ -z ${*+_} ]]; then read; printf '***%s***\n' "$REPLY"; else printf '+++%s+++\n' "$*"; echo $*; echo $2; fi; }; foo "" "world";
#foo(){ if [[ -z ${*+_} ]]; then while read line; do printf "$line" | gsed 's/l/d/g'; done; else printf '+++%s+++\n' "$*"; fi; }; echo "hello world" | foo
jsonify()
{
	if [[ -z ${*+_} ]]; then 
		gsed -E 's|\\"|"|g; s/(^"|"$)//g' | jq '.';
	else
		printf "$*" | gsed -E 's|\\"|"|g; s/(^"|"$)//g' | jq '.';
	fi;
}

jsonstringy()
{
	if [[ -z ${*+_} ]]; then 
		jq -c '.' | gsed 's|"|\\"|g; s|^{|"{|g; s|}$|}"|g';
	else
		printf "$*" | jq -c '.' | gsed 's|"|\\"|g; s|^{|"{|g; s|}$|}"|g';
	fi;
}
