#!/usr/local/bin/bash
#--------------------------------------------------------------------------------
# Information { #-------------------------------------------------------------------------------- By: Vito C.  }
#--------------------------------------------------------------------------------
# Environment {
#--------------------------------------------------------------------------------
# currently borken completions
# Source Files:
shopt -s direxpand
export PATH="/usr/local/sbin:/usr/local/bin:$PATH:~/Library/Python/2.7/bin:$HOME/code/configs/pirate-setup/bin:/usr/texbin:/usr/local/opt/go/libexec/bin"
# export PATH="/usr/local/opt/scala@2.11/bin:/usr/local/octave/3.8.0/bin:$PATH"
export GOPATH="$HOME/code/go"
PATH="$PATH:$GOPATH/bin"
PATH="$PATH:$HOME/.cargo/bin"
PATH="$PATH:$HOME/code/personal/KotlinLanguageServer/server/build/install/server/bin"

strip_color()
{
  gsed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g"
}

if hash brew 2>/dev/null; then
    for completion_file in $(brew --prefix)/etc/bash_completion.d/*; do
        source "$completion_file"
    done
    if [[ -f $(brew --prefix)/share/bash-completion/bash_completion ]]; then
        source $(brew --prefix)/share/bash-completion/bash_completion;
        for completion_file in $(brew --prefix)/share/bash-completion/completions/*; do
            source "$completion_file"
        done

	fi
    # if [[ -f $(brew --prefix)/etc/bash_completion ]]; then
    #     . $(brew --prefix)/etc/bash_completion
    # fi
fi
export ASYNC_PROFILER_DIR=$HOME/code/playground/async-profiler  
export FLAME_GRAPH_DIR=$HOME/code/playground/FlameGraph  

# # causing shell to exit
# # source "$(git --exec-path)/git-sh-setup"
# if hash aws 2>/dev/null; then
#     complete -C aws_completer aws
# fi

export CODE_CONFIGS=$HOME/code/configs
if [[ -f ./secrets ]]; then
	source ./secrets
fi
if [[ -f ~/.pirate-setup/secrets ]]; then
	source ~/.pirate-setup/secrets
fi
if [[ -f $CODE_CONFIGS/pirate-setup/secrets ]]; then
	source $CODE_CONFIGS/pirate-setup/secrets
fi
if [ -f $CODE_CONFIGS/pirate-setup/bash/facebook ]; then
	source $CODE_CONFIGS/pirate-setup/bash/facebook
fi
if [ -f $CODE_CONFIGS/pirate-setup/bash/zynga ]; then
	source $CODE_CONFIGS/pirate-setup/bash/zynga
fi

if [[ -f /Users/vcutten/Library/Python/2.7/lib/python/site-packages/powerline/bindings/bash/powerline.sh ]]; then
	/Users/vcutten/Library/Python/2.7/bin/powerline-daemon -q
	export POWERLINE_COMMAND=/Users/vcutten/Library/Python/2.7/bin/powerline
	export POWERLINE_CONFIG=/Users/vcutten/Library/Python/2.7/bin/powerline-config
	source '/Users/vcutten/Library/Python/2.7/lib/python/site-packages/powerline/bindings/bash/powerline.sh'
fi
# Java And Ant OPTS
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export ANT_OPTS="-Xmx1024m -Xms512m -XX:MaxPermSize=512m"
export JAVA_OPTS="-Xmx2024m -Xms1024m"

# Bindings
# bind 'set bind-tty-special-chars off'
bind '\C-Space':complete
bind '\C-i':menu-complete
bind '"\C-f": forward-word'
bind '"\C-b": backward-word'
# bind '"\u26F5": unix-word-rubout'
bind '"\C-w": backward-kill-word'
bind '"\e[B": history-search-forward'
bind '"\e[A": history-search-backward'

# Android
export ANDROID_HOME=/usr/local/opt/android-sdk
export ANDROID_NDK=/usr/local/opt/android-ndk

# Shopts
# shopt -s histappend
shopt -s extglob
shopt -s cdspell
shopt -s nocaseglob
shopt -u expand_aliases
shopt -s globstar
shopt -s lithist cmdhist

# Use Vim for editor
export HOMEBREW_EDITOR=nvim
export EDITOR=nvim

# External bash history.
# ---------------------
# https://unix.stackexchange.com/questions/18212/bash-history-ignoredups-and-erasedups-setting-conflict-with-common-history
# Undocumented feature which sets the size to "unlimited".
# http://stackoverflow.com/questions/9457233/unlimited-bash-history
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "
# Change the file location because certain bash sessions truncate .bash_history file upon close.
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
export HISTFILE=~/.bash_external_history
# Force prompt to write history after every command.
# http://superuser.com/questions/20900/bash-history-loss
# PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
export HISTIGNORE="ls:ll:fg:eb:ev:fc:pwd:exit:history:cb:git st"
# PROMPT_COMMAND="history -a; history -n"
# PROMPT_COMMAND="history -n; history -w; history -c; history -r; $PROMPT_COMMAND"

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

# Configs
if hash hostname 2>/dev/null; then
    export HOSTNAME=$(hostname)
else 
    export HOSTNAME="dorker"
fi
export P4CONFIG=/Users/vcutten/.p4env #$HOME
# }
#--------------------------------------------------------------------------------


#############################################################################################################################
#                                                                                                                           #
#                                          Core CPU Values (Environment Variables                                           #
#                                                                                                                           #
#############################################################################################################################
# xml sel -t -v '/items/item[@autocomplete="d*"]/title' ./address.xml


# regen ssh pub key openssh -y -f id_rsa > id_rsa.pub

#stty werase undef

# Override defaults

###
# GIT BS!
##
# git-pump-current()
# {
#     cb=$(git rev-parse --abbrev-ref HEAD)
#     git stash
#     git checkout master
#     git pull upstream master
#     git checkout ${cb}
#     git pull upstream master
#     git stash pop
# }

rot13()
{
    tr '[A-Za-z]' '[N-ZA-Mn-za-m]'
}

git-pum()
{
    # cb=$(git rev-parse --abbrev-ref HEAD)
    git stash
    git pull upstream master
    git stash pop
}

export NVIM_TUI_ENABLE_TRUE_COLOR=1

#############################################################################################################################
#                                                                                                                           #
#                                           Completion Specific Bash Stuff                                                  #
#                                                                                                                           #
#############################################################################################################################
unalias ll 2>/dev/null
unalias ls 2>/dev/null
export ECLIPSE_HOME="/Applications/Eclipse.app/Contents/Eclipse"
s3dax()
{
    command /usr/local/bin/s3cmd -c ~/.s3confs/s3audax.cfg "$@"
}

s3prod()
{
    command /usr/local/bin/s3cmd -c ~/.s3confs/s3prod.cfg "$@"
}

lockme()
{
    open /System/Library/CoreServices/ScreenSaverEngine.app
}

#export NVIM_LISTEN_ADDRESS=8000

nv()
{
    if [[ -z $VIMRUNTIME ]]; then 
        command /usr/local/bin/nvim "${@}"
    else
        command /usr/local/bin/nvr "${@}"
     fi
}

vi() {
    start_addr=8000
    if [[ -z $NEOVIM_LISTEN_ADDRESS ]]; then
        # not running inside nvim
        nvim "$@"
    else
        python -c "from neovim import attach; nvim = attach('tcp', '127.0.0.1','$start_addr'); nvim.command('args $@');"
    fi
}

jl()
{
    if [[ $1 == "up" ]]; then
        command launchctl list | grep -v '^-'
    elif [[ $1 == "down" ]]; then
        command launchctl list | grep '^-'
    elif [[ $1 == "list" ]]; then
        if [[ -z $2 ]]; then
            command launchctl list
        else
            command launchctl list $2 | sed -e 's/;/,/g' -e 's/=/:/' -e 's/(/[/' -e 's/),/]/' -e 's/},/}/' | gsed 'N;s/,\n\t*]/\n]/;' | jq '.'
        fi
    else
        command launchctl "${@}"
    fi
}

s3rally()
{
    command /usr/local/bin/s3cmd -c ~/.s3confs/s3rally-dev.cfg "$@"
}


#TODO: export your java home too brah
if [[ $(uname) =~ Darwin || $(uname) =~ FeeBSD ]]; then
	# export FLEX_HOME="/usr/local/bin/flexsdks/4.6.0.23201B"
	# export PAGER=vimpager
	export FLEX_HOME=/Users/vcutten/local/flash/flex/sdk
	export vimdir=$HOME/.vim
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
    export SCALA_HOME="/usr/local/Cellar/scala/2.11.7"


	search-history(){
		history | grep -v history | gawk '{ $1=""; print $0 }' | sort | uniq | grep $1
	}

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

	eb()
	{
		# echo -e "\033];BASHRC\007";
		#trap 'echo -e "\033];bash\007"' SIGTERM SIGKILL SIGQUIT
		#trap 'echo -e "\033];bash\007";' EXIT
		# command /usr/local/bin/nvim $@ $CODE_CONFIGS/pirate-setup/bashrc;
        nv $CODE_CONFIGS/pirate-setup/bashrc;
	}
	eg() { nv $CODE_CONFIGS/pirate-setup/gitconfig; }
	ev() { nv $CODE_CONFIGS/pirate-vim/rc/vimrc; }
	cb() { source ~/.bash_profile; }
	ls() { command ls -G "$@"; }
	# fn() { command find . -iname "$@"; }
	ehco() { command echo "$@"; }
	gti() { command git "$@"; }
	cmhod() { command chmod "$@"; }
	fw() {
		file='*'"$1"'*'
		ff $file $2 $3
	}
	gfj() {
		find ./Farm3/Data/Json -name \*.json -exec grep -in "$@" {} +
	}
	gfc() {
		find . -name \*.cs -exec grep -in "$@" {} +
	}
	ff() {
		if [[ "$2" == "" ]]; then
			type='*.*';
		else
			type='*.'"$2";
		fi
		#echo "root: $1  stem: $type"
		if [[ "$3" == "" ]]; then
			find . \( -name .\*~ -o -name \*.meta -prune -o -name \*.prefab -prune \) -o -iname "$1""$type" -print;
		else
			find "$3" \( -name .\*~ -o -name \*.meta -prune -o -name \*.prefab -prune \) -o -iname "$1""$type" -print;
		fi
	}
	fcs() {
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
#export GREP_OPTIONS='--color=auto -i'

	#grep() { command /usr/local/bin/grep -in --color='auto' "$@"; }
	gr() { command /usr/local/bin/grep -in --color='auto' "$@"; }
	ll() { command ls -lGh "$@"; }
	la() { command ls -lGha "$@"; }
	# might be causing vim diff issues
	nd() { command nvim -d "$@"; }
    vimdiff() { command nvim -d "$@"; }
	vif() {
		#if [[ "$2" == "" || "$2" == "*.cs" ]]; then
#re='^[0-9]+$'
#if ! [[ $yournumber =~ $re ]] ; then
#   echo "error: Not a number" >&2; exit 1
#fi

		if [[ "$(pwd -P)" =~ $HOME/workrepos/farm3/dev.* ]]; then
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
    eb() { nvim $@ ~/.bash_awesome; }
    cb() { source ~/.bash_awesome; }
    ls() { command ls --color=always "$@"; }
    ll() { command ls --color=always -lh "$@"; }
    la() { command ls --color=always -lha "$@"; }
fi

export FCSH=$FLEX_HOME/bin/fcsh
export PLAN9=/usr/local/plan9


function gradient() {
    local start=$([ -z "${1+x}" ] && echo "255;0;0" || echo $1)
    local end=$([ -z "${2+x}" ] && echo "0;0;255" || echo $2)
    local text=$([ -z "${3+x}" ] && echo "\\t" || echo $3)
    local perc=$([ -z "${4+x}" ] && echo "100" || echo $4)
    local tcol=$(echo $text | wc -c)

    local sr=$(echo $start | awk -F";" '{print $1}')
    local sg=$(echo $start | awk -F";" '{print $2}')
    local sb=$(echo $start | awk -F";" '{print $3}')

    local er=$(echo $end | awk -F";" '{print $1}')
    local eg=$(echo $end | awk -F";" '{print $2}')
    local eb=$(echo $end | awk -F";" '{print $3}')
    gawk -v term_cols="${tcol}" -v txt="${text}" -v p="${perc}" \
        -v r="${sr}" -v g="${sg}" -v b="${sb}" \
        -v re="${er}" -v ge="${eg}" -v be="${eb}" \
    'BEGIN {

    ri = (p == 0)? re : 100*(re - r)/(p*term_cols);
    gi = (p == 0)? ge : 100*(ge - g)/(p*term_cols);
    bi = (p == 0)? be : 100*(be - b)/(p*term_cols);

    for (colnum = 1; colnum<term_cols; colnum++) {
        s = substr(txt, colnum,1);
        r = (r + ri >= re && ri > 0 || r + ri <= 0 && ri < 0)? re : r + ri;
        g = (g + gi >= ge && gi > 0 || g + gi <= 0 && gi < 0)? ge : g + gi;
        b = (b + bi >= be && bi > 0 || b + bi <= 0 && bi < 0)? be : b + bi;
        printf "\033[48;2;%d;%d;%dm", r,g,b;
        printf "\033[38;2;%d;%d;%dm", 255-r,255-g,255-b;
        printf "%s\033[0m", s;
    }
    printf "\n";
}'
}
function dump_colors() {
    awk -v term_cols="${width:-$(tput cols || echo 80)}" 'BEGIN{
    s="/\\";
    for (colnum = 0; colnum<term_cols; colnum++) {
        r = 255-(colnum*255/term_cols);
        g = (colnum*510/term_cols);
        b = (colnum*255/term_cols);
        if (g>255) g = 510-g;
        printf "\033[48;2;%d;%d;%dm", r,g,b;
        printf "\033[38;2;%d;%d;%dm", 255-r,255-g,255-b;
        printf "%s\033[0m", substr(s,colnum%2+1,1);
    }
    printf "\n";
}'
}

function ps1_start() {
    # "77;77;77" "77;77;255"
    [[ -z "${1+x}" ]] && local scbg="77;77;77"  || local scbg="$1"
    [[ -z "${2+x}" ]] && local ecbg="77;77;255" || local ecbg="$2"
    [[ -z "${3+x}" ]] && local ncbg="30;50;30"  || local ncbg="$3"
    [[ -z "${4+x}" ]] && local itxt="$OS_ICON xx" || local itxt="$4"
    local tcfg="255;0;0"

    local otxt=$(gradient "${scbg}" "${ecbg}" " ${itxt} " "30")
    # printf "\n\e[38;2;${scbg}m\e[48;2;${scbg}m \e[0m%s\e[48;2;${ecbg}m\e[38;2;${ecbg}m \e[48;2;${ncbg}m\e[0m" "${otxt}"
    # \n\[\33[47m\]
    echo -e "\033[38;2;${scbg}m\033[48;2;${scbg}m \033[0m${otxt}\033[48;2;${ecbg}m\033[38;2;${ecbg}m \033[48;2;${ncbg}m\033[0m"
}

function ps1_jobs() {
    [[ -z "${1+x}" ]] && local scbg="30;50;30"  || local scbg="$1"
    [[ -z "${2+x}" ]] && local ecbg="98;206;80" || local ecbg="$2"
    [[ -z "${3+x}" ]] && local ncbg="255;0;0"   || local ncbg="$3"
    [[ -z "${4+x}" ]] && local itxt="🏃 x"     || local itxt="$4"
    local otxt=$(gradient "${scbg}" "${ecbg}" " ${itxt} " "0")

    printf "\e[38;2;${scbg}m\e[48;2;${scbg}m \e[0m%s\e[48;2;${ecbg}m\e[38;2;${ecbg}m \e[48;2;${ncbg}m\e[0m" "${otxt}"
}

function ps1_mid() {
    #115,174,233
    [[ -z "${1+x}" ]] && local scbg="30;50;30"  || local scbg="$1"
    [[ -z "${2+x}" ]] && local ecbg="98;206;80" || local ecbg="$2"
    [[ -z "${3+x}" ]] && local ncbg="255;0;0"   || local ncbg="$3"
    [[ -z "${4+x}" ]] && local itxt=" xx"   || local itxt="$4"
    local tcfg="255;0;0"

    local otxt=$(gradient "${scbg}" "${ecbg}" " ${itxt} " "30")
    printf "\e[38;2;${scbg}m\e[48;2;${scbg}m \e[0m%s\e[48;2;${ecbg}m\e[38;2;${ecbg}m \e[48;2;${ncbg}m\e[0m" "${otxt}"
}

function ps1_beforelast() {
    #115,174,233
    [[ -z "${1+x}" ]] && local scbg="30;50;30"  || local scbg="$1"
    [[ -z "${2+x}" ]] && local ecbg="98;206;80" || local ecbg="$2"
    [[ -z "${3+x}" ]] && local ncbg="255;0;0"   || local ncbg="$3"
    [[ -z "${4+x}" ]] && local itxt=" xx"   || local itxt="$4"
    local tcfg="255;0;0"

    local otxt=$(gradient "${scbg}" "${ecbg}" " ${itxt} " "30")
    printf "\e[38;2;${scbg}m\e[48;2;${scbg}m \e[0m%s\e[48;2;${ecbg}m\e[38;2;${ecbg}m \e[0m\n" "${otxt}"
}

function ps1_git() {
    [[ -z "${1+x}" ]] && local scbg="30;50;30"  || local scbg="$1"
    [[ -z "${2+x}" ]] && local ecbg="98;206;80" || local ecbg="$2"
    [[ -z "${3+x}" ]] && local ocbg="255;0;0"   || local ocbg="$3"
    [[ -z "${4+x}" ]] && local itxt="master"    || local itxt="$4"

    local tcfg="255;0;0"
    # $( git branch 2>/dev/null | grep '^*' | colrm 1 2)

    if [[ ${itxt} == "" ]]; then
      printf "\e[0m\e[38;2;${ocbg}m\e[0m"
    else 
      local otxt=$(gradient "${scbg}" "${ecbg}" "🔀 ${itxt} " "50")
      printf "\e[38;2;${ocbg}m\e[48;2;${scbg}m\e[38;2;${scbg}m \e[0m%s\e[48;2;${ecbg}m\e[38;2;${ecbg}m \e[0m\e[38;2;${ecbg}m\e[0m\n" "${otxt}"
    fi
}


# function ps1-end() {
#     local sbkg=$([ -z "${1+x}" ] && echo "\e[47m" || echo $1)
#     local fgrd=$([ -z "${2+x}" ] && echo "\e[0;30m" || echo $2)
#     local nbkg=$([ -z "${3+x}" ] && echo "\e[44m" || echo $3)
#     local farr="\e[0;37m"
#     echo -e "${farr}${fgrd}${sbkg} $OS_ICON \A ${farr}${nbkg}\e[0m"
# }
#
if [[ $HOSTNAME == "dorker" ]]; then
    # export PS1="\[\e[36;1m\][\A] \[\e[31;1m\]\w> \[\e[0m\]"
    # export PS2="\[\e[31;1m\]> \[\e[0m\]"
    echo "WELCOME TO DOCKER"
    export OS_ICON=🐳
    export PS1="\t \j \\w\$(git branch 2>/dev/null | grep '^*'| colrm 1 2)\\n> "
    # export PS1_ORIG="\n \[\033[41m\]\[\033[0;31m\]\[\033[0;37m\]\[\033[41m\] $OS_ICON \A \[\033[0m\]\[\033[0;31m\]\[\033[44m\]\[\033[0;34m\]\[\033[44m\]\[\033[0;30m\]\[\033[44m\] \w \[\033[0m\]\[\033[0;34m\] \n \[\033[0;34m\]╰ \[\033[1;36m\]\$ \[\033[0m\]"
    export PS1="\n\[\033[47m\]\[\033[0;37m\]\[\033[0;30m\]\[\033[47m\] 🐳 \A \[\033[0m\]\[\033[0;37m\]\[\033[44m\]\[\033[0;34m\]\[\033[44m\]\[\033[1;37m\]\[\033[44m\] \j \[\033[0m\]\[\033[0;34m\] \n\[\033[1;35m\]$ \[\033[0m\]"
    export PS1='$(ps1_start "77;77;77" "33;33;255" "77;77;77" "$OS_ICON \t")$(ps1_jobs "77;77;77" "77;77;77" "33;33;255" "🏃 \j")$(ps1_beforelast "33;33;255" "77;77;77" "255;0;0"  "\w")$(ps1_git "33;33;255" "77;77;77" "77;77;77" "$(echo $(git branch 2>/dev/null | grep '^*' | colrm 1 2))")\n$ '
    export PS2="|   "
else 
    export OS_ICON=🍎
    export PS1='$(ps1_start "77;77;77" "33;33;255" "77;77;77" "$OS_ICON \t")$(ps1_jobs "77;77;77" "77;77;77" "33;33;255" "🏃 \j")$(ps1_beforelast "33;33;255" "77;77;77" "255;0;0"  "\w")$(ps1_git "33;33;255" "77;77;77" "77;77;77" "$(echo $(git branch 2>/dev/null | grep '^*' | colrm 1 2))")\n$ '
    export PS2="|   "
fi
# export PS1="\[\e[36;1m\][\[\e[0;35m\]$HOSTSTUB\[\e[36;1m\]] \[\e[0;35m\]$HOSTSTUB \[\e[31;1m\]\w> \[\e[0m\]"
# export PS2="\[\e[31;1m\]> \[\e[0m\]"
# export PS1='\W> '

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

# fd()
# {
# 	case "$1" in
# 		'r'|'repo'|'root')
# 			startdir=$PWD;
# 			while [[ $PWD != $HOME && $(ls -a | grep '^.git$') != '.git' && $PWD != / ]]; do cd ..; done;
# 			enddir=$PWD;
# 			cd $startdir;
# 			cd $enddir;
# 		;;
# 	esac
# }

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

#Execute Apple Scripts
#alias ttheme='osascript "$PATH_ASCRIPTS/SetTerminalTheme.scpt"'
#alias mbdesktop='osascript "$PATH_ASCRIPTS/SpacesMobile.scpt"'
#alias wrkdesktop='osascript "$PATH_ASCRIPTS/SpacesWork.scpt"'

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
	tail -F "/Users/vcutten/Library/Preferences/Macromedia/Flash Player/Logs/flashlog.txt"
}

trcomni()
{
	tail -F "$@" "/Users/$USER/.pirate-setup/pirate-vim/bundle/Omnisharp/server/Omnisharp/bin/Debug/server.log"
}
export UNITY_LOG="/Users/$USER/Library/Logs/Unity/Editor.log"
trcunity()
{
	tail -F "$@" "/Users/$USER/Library/Logs/Unity/Editor.log"
	#less +F "$@" "/Users/$USER/Library/Logs/Unity/Editor.log"
}

trcphp()
{
	#TODO: add -a -e (default is -e) for access log
	if [[ $(uname) =~ Darwin ]]; then
		tail -F $1 | sed $'s/\\\\n/\\\n/g'
	fi
	if [[ $(uname) =~ Linux ]]; then
		tail -F /mnt/farm2dev/apps/$1/logs/error.log | sed $'s/\\\\n/\\\n/g'
	fi
	#tail -F /private/var/log/apache2/$1-error_log | sed $'s/\\\\n/\\\n/g'
	# sed -e 's/\\n/\n/g'; -cent os
	# also works 's/\\n/\'$'\n'/g - it's essentially inserting a literal carriage return

}


# export a display
vdisplay(){ (Xvfb :$@ &); export DISPLAY=:$@; }

listenPort(){ sudo ngrep -d lo0 -W byline port $@; }

ldapquick-ad()
{
	ldapsearch -x -D 'cn=Vito Cutten,cn=Users,dc=corp,dc=zynga,dc=com' -W -h sfo-dc03.corp.zynga.com -b "dc=corp,dc=zynga,dc=com" "(sAMAccountName=$1)" telephoneNumber mail sn givenName
}

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

	app_fid="XX"
	app_sec="YY"
	acc_tkn=$(curl -F type=client_cred -F client_id=$app_fid -F client_secret=$app_sec -F grant_type=client_credentials $GRAPH/oauth/access_token | sed -nE 's|access_token=(.*)$|\1|p');
	echo "curl -F "password=$password" -F "name=$name" $GRAPH/$fbid?access_token=$acc_tkn";
	curl -F "name=$name" -F "password=$password" $GRAPH/$fbid?access_token=$acc_tkn;
}

# Get test user login
getRoboDomo()
{
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
		$GRAPH/$app_fid/accounts/test-users?access_token=$acc_tkn | sed -nE 's|.*"login_url":"([^"]*)".*|\1|p'
}

cvl_test()
{
	name=$1 password=$2 fbid=$3

	app_fid="$1"
	app_sec="$2"
	echo "curl -F "password=$password" -F "name=$name" $GRAPH/$fbid?access_token=$acc_tkn";
	curl -F "name=$name" -F "password=$password" $GRAPH/$fbid?access_token=$acc_tkn;
}

access_token()
{
    if [[ -z $1 ]]; then
        APP_ID=$DEFAULT_APP_ID;
        #user passed in a app name you should be able to set the values
        #ie access_token cvl-dev ...easiest way to do this is to change config to json values
    fi
    if [[ -z $2 ]]; then
        APP_SEC=$DEFAULT_APP_SEC;
    fi

    curl -s -F client_id=$APP_ID \
        -F client_secret=$APP_SEC \
        -F grant_type=client_credentials $GRAPH/oauth/access_token |
    sed -nE 's|access_token=(.*)$|\1|p';
}

get_friends()
{
	if [[ -z $1 ]]; then
		ACC_TKN=$(access_token);
	else
		ACC_TKN=$1;
	fi
	if [[ -z $2 ]]; then
		fbid=$FB_ID;
	else
		fbid=$2;
	fi

	curl -s $GRAPH/$FB_ID/friends?access_token=$ACC_TKN | jq '.'
}

# Manage my ap
updateDevUser()
{
	name=$1 password=$2 fbid=$3

	app_fid="$1"
	app_sec="$2"
	acc_tkn=$(curl -F type=client_cred -F client_id=$app_fid -F client_secret=$app_sec -F grant_type=client_credentials $GRAPH/oauth/access_token | sed -nE 's|access_token=(.*)$|\1|p');
	echo "curl -F "password=$password" -F "name=$name" $GRAPH/$fbid?access_token=$acc_tkn";
	curl -F "name=$name" -F "password=$password" $GRAPH/$fbid?access_token=$acc_tkn;
}

# Script needs to be run from repo root directory.
manage_allApps()
{
	apps=(art blue feature{10..20} feature0{1..9} green rainbow red tractor trunk silver);
	for APP in "${apps[@]}"; do
		app_fid=$(sed -En "s|.*'FB_APP_ID', ?'([^']*)'.*|\1|p" ~/workrepos/${AWESOMEVILLE}-main/Server/game/config/$app/local.inc.php);
		app_sec=$(sed -En "s|.*'FB_API_SECRET', ?'([^']*)'.*|\1|p" ~/workrepos/${AWESOMEVILLE}-main/Server/game/config/$app/local.inc.php);
		acc_tkn=$(curl -F type=client_cred -F client_id=$app_fid -F client_secret=$app_sec -F grant_type=client_credentials $GRAPH/oauth/access_token | sed -nE 's|access_token=(.*)$|\1|p');
		echo -e Exucing on app: $app\n;
		echo -e curl $1 $GRAPH/$app_fid?access_token=$acc_tkn\n;
		curl $1 $GRAPH/$app_fid?access_token=$acc_tkn;
	done;
}

test_v2d2()
{
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

#takes in a file name and a destination path
p4move()
{
	find . -iname $1 -exec sh -c 'p4 move {} '$2'/$(basename {} )' \;
}
barncopy()
{
	find . -iname $1 -exec sh -c 'file={};
		dir=/Users/vcutten/workrepos/farm3/branches/dev/src/FarmMobile/${file#./*};
		if [ ! -d ${dir} ]; then mkdir -p ${dir}; echo "created ${dir}"; fi;
		cp ${file} /Users/vcutten/workrepos/farm3/branches/dev/src/FarmMobile/${file#./*};' \;
}

#function __p4_find_command() {
#   for file in $(find . -type f -iname $2); do
#       p4 $1 $file
#   done
#}
#
#alias p4o='p4 opened'
#alias p4og='p4 opened | grep $*'
#alias p4e='__p4_find_command edit $*'
#alias p4d='__p4_find_command delete $*'
#alias p4r='__p4_find_command revert $*'
# perforce commands

v2d2-addjoke()
{
    v2d2dir="/Users/vitocutten/playground/V2D2-old"
    v2d2ans="${v2d2dir}/src/org/v2d2/skype/jokes/Answers.java"
    v2d2cls="${v2d2dir}/src/org/v2d2/skype/jokes/Clues.java"
    printf '%s\n' 161i "        \"${1}\"," . w | ed -s ${v2d2cls}
    printf '%s\n' 801i "        \"${2}\"," . w | ed -s ${v2d2ans}
    git --work-tree=${v2d2dir} --git-dir=${v2d2dir}/.git diff -- ${v2d2ans} ${v2d2cls}
}

# export DEV=$HOME/workrepos/farm3/branches/dev/src;
# export dev=$DEV;
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
	ZID="${LZID}";
	BLOB="player";
	APPID="${FVN_ZLIVE_APP}";
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
	# curl -i -X 'PUT'
    #   'https://api.zynga.com/storage/v1/app/${FVN_ZLIVE_APP}/blob/player/user/${LZID}'
    #   -H 'app-id:${FVN_ZLIVE_APP}'
    #   -H 'auth-type:app'
    #   -H 'Content-Type: application/json'
    #   -d '{ "payload":
    #             { "cas": "'$CAS'",
    #                 "value":"'"$( getblob
    #                   | jq '( .resources[]
    #                     | select(.id == "consu_ribbon" )
    #                     | .amount )=5000
    #                     | .leaderboardName="GodFather"' | gsed 's|"|\\"|g' | xargs | gsed 's|"|\\"|g')"'"}}'
	echo "no op";
}

leaderboard_getcheater_names()
{
	ZID="${LZID}";
	BOARD="countyfair-dev10";
	if [[ -n ${1+_} ]]; then ZID="$1"; fi;
	if [[ -n ${2+_} ]]; then BOARD="$2"; fi;
	leaderboard_get_players | jq -c '.data["'$BOARD'"]["'$LZID'"][] | {id: .id, ch: .extra|fromjson|.ch, name: .extra|fromjson|.name} | select( .ch == true ).name'
}

leaderboard_getcheater_ids()
{
	ZID="${LZID}";
	BOARD="countyfair-dev10";
	if [[ -n ${1+_} ]]; then ZID="$1"; fi;
	if [[ -n ${2+_} ]]; then BOARD="$2"; fi;
	leaderboard_get_players | jq -c '.data["'$BOARD'"]["'$LZID'"][] | {id: .id, ch: .extra|fromjson|.ch, name: .extra|fromjson|.name} | select( .ch == true ).id'
}

leaderboard_settings()
{
	ZID="${LZID}";
	APPID="${FVN_ZLIVE_APP}";
	ZAPI="https://api.zynga.com";
	curl -s -X 'GET' "${ZAPI}/leaderboards/v2/app/${APPID}/settings" -H "app-id: ${APPID}" -H "player-id: ${ZID}" -H 'auth-type: app'
}

leaderboard_get_players()
{
	ZID="${LZID}";
	BOARD="countyfair-dev10";
	START=0;
	END=40;
	APPID="${FVN_ZLIVE_APP}";
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

leaderboard_get()
{
	BOARD="countyfair-dev10";
	START=0;
	END=40;
	APPID="${FVN_ZLIVE_APP}";
	if [[ -n ${1+_} ]]; then BOARD="$1"; fi;
	if [[ -n ${2+_} ]]; then APPID="$2"; fi;
	ZAPI="https://api.zynga.com"
	STORAGE="leaderboards/v2/app/$APPID/leaderboard/$BOARD?after=14&rank=0&tier=level-low";
	export RAW=$(curl -s -X 'GET' "$ZAPI/$STORAGE" -H "app-id:$APPID" -H 'auth-type:app');
	echo $RAW
}

leaderboard_delete_all_cheaters()
{
	for id in $(leaderboard_getcheater_ids | tr -d '"'); do leaderboard_delete_player $id; done
}
leaderboard_delete_player()
{
	ZID="${LZID}";
	BOARD="countyfair-dev10";
	APPID="${FVN_ZLIVE_APP}";
	if [[ -n ${1+_} ]]; then ZID="$1"; fi;
	if [[ -n ${2+_} ]]; then BOARD="$2"; fi;
	ZAPI="https://api.zynga.com"
	STORAGE="leaderboards/v2/app/$APPID/leaderboard/$BOARD/id/$ZID/period_offset/0"
	export RAW=$(curl -s -X 'DELETE' "$ZAPI/$STORAGE" -H "player-id:${ZID}" -H "app-id:$APPID" -H 'auth-type:app');
	echo $RAW
}

leaderboard_get_player()
{
	ZID="${LZID}";
	APPID="${FVN_ZLIVE_APP}";
	if [[ -n ${1+_} ]]; then ZID="$1"; fi;
	if [[ -n ${2+_} ]]; then APPID="$2"; fi;
	ZAPI="https://api.zynga.com"
	STORAGE="leaderboards/v2/app/$APPID/id/$ZID?extra=true"
	export RAW=$(curl -s -X 'GET' "$ZAPI/$STORAGE" -H "app-id:$APPID" -H 'auth-type:app');
	echo $RAW
}

leaderboard_set_player()
{
	ZID="${LZID}";
	BOARD="countyfair-dev10";
	APPID="${FVN_ZLIVE_APP}";
	if [[ -n ${2+_} ]]; then ZID="$2"; fi;
	if [[ -n ${3+_} ]]; then BOARD="$3"; fi;
	if [[ -n ${4+_} ]]; then APPID="$4"; fi;
	STORAGE="leaderboards/v2/app/$APPID/leaderboard/$BOARD/id/$ZID"
	curl -s -X 'PUT' "$ZAPI/$STORAGE" -H "app-id:$APPID" -H 'auth-type:app' -H 'Content-Type: application/json'  -d @-
}

#leaderboard_cheat()
#{
#	topscore=$(leaderboard_get_players | jq  '.data["countyfair-dev10"]["'${LZID}'"][0].score');
#	leaderboard_get_player |
#		jq '.data["'$LZID'"]["countyfair-dev10"][0]' |
#		jq '{extra, score, "tier":"level-low"}' |
#		jq '.score ='"$topscore"'' |
#		jq '.score += 4' | leaderboard_set_player
#}

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

#App Specific
#FVN_ZLIVE_SEC=$(pattern="'ZLIVE_APP_SECRET' *, *'([a-z0-9]*)'"; grep -oE "$pattern" ~/workrepos/mobile/admin/farm2mobile/config.php | sed -E "s|$pattern|\1|g")
#FVN_ZLIVE_APP=5000880;
#ZAPI="https://api.zynga.com"
#LZID=$(strings ~/Library/Preferences/unity.Zynga\ Inc..FarmVille\ 4.plist | perl -ne '/"zid":([^,]*),/xg && print "$1\n"' | uniq)
if [[ -f ~/workrepos/mobile/admin/farm2mobile/config.php ]]; then
	FVN_ZLIVE_SEC=$(pattern="'ZLIVE_APP_SECRET' *, *'([a-z0-9]*)'"; grep -oE "$pattern" ~/workrepos/mobile/admin/farm2mobile/config.php | sed -E "s|$pattern|\1|g")
	FVN_ZLIVE_APP=5000880;
	ZAPI="https://api.zynga.com"
	#LZID=$(strings ~/Library/Preferences/unity.Zynga\ Inc..FarmVille\ 3.plist | perl -ne '/"zid":([^,]*),/xg && print "$1\n"' | uniq)
fi

zlive_identities()
{
	ZID="${LZID}";
	APPID="${FVN_ZLIVE_APP}";
	SNIDS="1,22,31,104";
	if [[ -n ${1+_} ]]; then ZID="$1"; fi;
	if [[ -n ${2+_} ]]; then APPID="$2"; fi;
	if [[ -n ${2+_} ]]; then SNIDS="$2"; fi;
	if [[ -n ${4+_} ]]; then ="$4"; fi;

	secret="$FVN_ZLIVE_SEC";
	echo $req
	req="p={\"c\": [{\"m\": \"identities.get\", \"al\": {\"zids\":[${ZID}], \"snids\":[$SNIDS]}}], \"t\": {\"appId\": \"$APPID\", \"snId\": \"1\", \"secret\": \"$secret\"}}";
	curl -s -d v=1.2 -d "$req" $ZAPI | jq '.'
}

zlive_disassociate()
{

	ZID="${LZID}";
	APPID="${FVN_ZLIVE_APP}";
	SNIDS="1,22,31,104";
	if [[ -n ${1+_} ]]; then ZID="$1"; fi;
	if [[ -n ${2+_} ]]; then APPID="$2"; fi;
	if [[ -n ${2+_} ]]; then SNIDS="$2"; fi;

	secret="$FVN_ZLIVE_SEC";

	#if [[ "stage" -eq "$6" ]]
	#then
	#	host="http://api.staging.zynga.com";
	#	appId="_YOUR_APP_ID_";
	#	secret="_YOUR_APP_SECRET_";
	#fi


	req="p={\"c\": [{\"m\": \"identities.appDisassociate\", \"al\": {\"zid\":$ZID}], \"t\": {\"appId\": \"$APPID\", \"snId\": \"1\", \"secret\":\"$secret\"}}";
	echo $req

	curl -s -d v=1.2 -d "$req" $ZAPI | jq '.'
}

count_filetypes()
{
	#find . -iname \*.meta -prune -o -iname \*.png -prune -o -iname \*.anim -prune -o -iname \*.unity -prune -o -iname \*.jpg -prune -o -iname \*.wav -prune -o -iname \*.prefab -prune -o -iname \*.fbx -prune -o -iname \*.asset -prune -o -iname \*.mp3 -prune -o -iname \*.tga -prune -o -iname \*.psd -prune -o -iname \*.mat -prune -o -type d -iname Temp -prune -o -type d -iname metadata -prune -o -type f -print | awk -F . '{print $NF}' | sort | uniq -c | sort -n
	findignores=$(cat ~/.pirate-setup/find-ignores.json | jq '.commands = ["-iname *." + .filetypes[] + " -prune -o"] + ["-type d -iname " + .directories[] + " -prune -o"] | .commands[]' | tr -d '"' | tr '\n' ' ');
	find . $findignores -type f -print | awk -F . '{print $NF}' | sort | uniq -c | sort -n
}

#p4 opened -sc default | grep add | awk '{ print $1 }' | sed 's|//farm3/branches/dev/src/|./|g'

unzip_stream()
{
	python -c "import zipfile,sys,StringIO;zipfile.ZipFile(StringIO.StringIO(sys.stdin.read())).extractall(sys.argv[1] if len(sys.argv) == 2 else '.')";
}

diff-temp()
{
	file=$1;
	name=$(basename $1);
	tfile=$(find ~/workrepos/farm3/development/src/Farm3/Temp -name ${name} );
	vimdiff $tfile $file
}
#editing lots of json files (adding a an array)
#for file in $(find . -name \*.json -exec grep -l PartsRequired {} + | grep -v 'jsonMapping' | grep -v 'plot' ); do echo $file; cat $file | jq -S '.components.UpgradeComponent.Requirement.PartsRequired[] += {"$type": "UpgradePartData, Assembly-CSharp"}' > ; done
clean-mxmlc()
{
	awk '/\/Users/,/ *\^/ {printf "%s\0",$0} / *\^/ {print ""} END {print ""}' |
		sort -t'\0' -k3,3 |
		tr '\0' '\n' |
		gsed '/^$/d'
		# | filter needs to be added here
		# | number-mxmlc
}

number-mxmlc()
{
	gawk '/\/Users/ {count++; prev=0; } { if(prev != count){ printf("%d: %s\n", count, $0); } else { print; }  prev=count; }' |
		gsed 's|/Users/.*/StagingArea/||g' |
		gsed 's|: col:|:\n\tcol:|g'
}

disk-speed()
{
	output=$(dd if=/dev/zero bs=2048k of=tstfile count=1024 2>&1 | grep sec | awk '{print $1 / 1024 / 1024 / $5, "MB/sec" }')
	echo write $output
	sudo purge
	output=$(dd if=tstfile bs=2048k of=/dev/null count=1024 2>&1 | grep sec | awk '{print $1 / 1024 / 1024 / $5, "MB/sec" }')
	echo read $output
	rm tstfile
}

vimc()
{
	UNITY_RUNNING=$( command /usr/local/bin/vim --servername UNITY --remote-send "" && echo $? );
	osascript ~/.pirate-setup/pirate-wench/unity-cli.scpt "$@"
	if [[ $UNITY_RUNNING ]]; then
		command /usr/local/bin/vim --servername UNITY --remote-silent "$@";
	fi
}


#cat app.json | jq -r '.[] | select( .name == "''" ) | .facebook.id '
# md finder
#mdfind -onlyin ~/workrepos -name app.json
# jenkins build
#curl -s http://vcutten:@ci.farm3.zynga.com/job/U02_UTW/build
# history cleaner
#cat ~/.bash_history | nl | sort -k 2 | uniq -f 1 | sort -n | cut -f2 > ~/.bash_history.clean
shelve()
{

	branch=$(git branch | grep '*' | sed 's/\* //g')
	git diff p4/master > ${branch}.patch
	mv ${branch}.patch /Users/vcutten/workrepos/farm3-p4/development/
	cd /Users/vcutten/workrepos/farm3-p4/development
	p4 sync /Users/vcutten/workrepos/farm3-p4/development/...#head
	patch -p1 < ${branch}.patch
	mkdir -p /Users/vcutten/workrepos/.patches
	mv ${branch}.patch /Users/vcutten/workrepos/.patches/${branch}.$(date "+%s").patch
	p4 change
	cd /Users/vcutten/workrepos/farm3-git-all
	#todo shelve files added to change lsit
}

gcp4()
{
	output=`lget_gp4_diffs ${@}`
	if [ $# -eq 0 ]; then
		echo git co p4/master
	elif [[ ${#output[@]} == 0 || ${output[0]} == "" ]]; then
		echo no matches
	else
		git co p4/master -- ${output[@]}
	fi
}

gdp4()
{
	if [ $# -eq 0 ]; then
		git diff p4/master
	elif [[ $1 == "l" || $1 == "name" ]]; then
		git diff --name-only p4/master
	elif [[ $1 == "n" ]]; then
		git diff --name-only p4/master | nl -v0
	else
		output=`lget_gp4_diffs ${@}`
		git diff p4/master -- ${output[@]}
	fi
}

gdp4_completer()
{

	#list=(`git diff --name-only p4/master | xargs basename `)
	local list=();
	local branch;

	while read -r branch; do list+=("${branch##*/}"); done < <(git diff --name-only p4/master)
	for word in "${list[@]}"; do
		[[ $word = "${COMP_WORDS[COMP_CWORD]}"* ]] && COMPREPLY+=("$word");
	done

	#for (( i=0; i < ${#list[@]}; i++ )); do
		#COMPREPLY+=(${list[$i]})
	#done
}

complete -F gdp4_completer gdp4
complete -F gdp4_completer gcp4

gdiff() 
{
    git diff --no-index ${1} ${2}
}

lget_gp4_diffs()
{
	list=(`git diff --name-only p4/master`)
	declare -A mymap
	output=()
	for var in "${list[@]}"
	do
		bn=$(basename $var)
		mymap[$var]=$var;
		mymap[$bn]=$var;
	done

	for var in "$@"
	do
		if [[ $var =~ ^[0-9]+$  ]]; then #single numero
			if [[ ${list[$var]} != "" ]]; then
				output+=(${list[$var]})
			fi
		elif [[ $var =~ ^.*?\..*$ ]]; then #wild card
			for item in ${list[@]}; do
				if [[ $item == $var ]]; then
					output+=($item)
				fi
			done
		elif [[ $var =~ ^[0-9]+\.\.[0-9]+$ ]]; then #range
			start=${var%..*};
			end=${var#*..};
			for (( i=${start}; i <= ${end}; i++ )); do
				output+=(${list[$i]})
			done
		elif [[ ${mymap[$var]} != ""  ]]; then
			mat=${mymap[$var]}
			echo $mat
			output+=($mat)
		else
			echo no match $var
		fi
	done

	if [[ ${#output[@]} != 0 ]]; then
		printf "%s\n" "${output[@]}"
	else
		return
	fi
}

gdfn()
{
	git diff --name-only
}

gdf()
{
	git diff
}

p4shelved()
{
	p4 changes -s shelved -u vcutten
}

AWK_COLORS='-v "red=$(tput setaf 1)" -v "reset=$(tput sgr0)" -v "green=$(tput setaf 2)" -v "yellow=$(tput setaf 3)" -v "cyan=$(tput setaf 6)"'
ios-log-startup()
{
	logname=ios-$(date "+%Y-%m-%d-%H:%M:%S")
	tail -F /Users/vcutten/workrepos/lldb.log |
	tee -a /Users/vcutten/workrepos/ios-log/${logname}.log |
	awk '/VC:/{ match( $0, /[^"]*"?(VC:[^"]*)(".*)?/, arr ); print arr[1]; fflush();}' |
	/Users/vcutten/workrepos/awkbackup/log-parse.awk |
	tee -a /Users/vcutten/workrepos/ios-log/${logname}-vc.log |
	/Users/vcutten/workrepos/awkbackup/log-color.awk -v "red=$(tput setaf 1)" -v "reset=$(tput sgr0)" -v "green=$(tput setaf 2)" -v "yellow=$(tput setaf 3)" -v "cyan=$(tput setaf 6)"
}

editor-log-startup()
{
	tail -F "/Users/$USER/Library/Logs/Unity/Editor.log" |
	/Users/vcutten/workrepos/awkbackup/log-parse.awk |
	tee -a /Users/vcutten/workrepos/editor-log/editor-$(date "+%Y-%m-%d-%H:%M:%S").log |
	/Users/vcutten/workrepos/awkbackup/log-color.awk -v "red=$(tput setaf 1)" -v "reset=$(tput sgr0)" -v "green=$(tput setaf 2)" -v "yellow=$(tput setaf 3)" -v "cyan=$(tput setaf 6)"
}

ios-log-parse()
{
	awk '/VC:/{ match( $0, /[^"]*"?(VC:[^"]*)(".*)?/, arr ); print arr[1]; fflush();}' |
	/Users/vcutten/workrepos/awkbackup/log-parse.awk |
	/Users/vcutten/workrepos/awkbackup/log-color.awk -v "red=$(tput setaf 1)" -v "reset=$(tput sgr0)" -v "green=$(tput setaf 2)" -v "yellow=$(tput setaf 3)" -v "cyan=$(tput setaf 6)"
}

startup-ldb-parse()
{
	gawk '/(]? INITIALIZER)/ { if( $5 == "COMPLETE:" ){ split($2,ac,":"); comp=(ac[1]*3600*1000+ac[2]*60*1000+ac[3]*1000); print (comp-start) " " $6 }else if( $5 == "STARTING:" ){ split($2,ac,":"); start=(ac[1]*3600*1000+ac[2]*60*1000+ac[3]*1000); }else{ print $0;} } END { print "===================================\nsum " sum}' | sort -n
}
startup-ldb-parse-nosort()
{
	gawk '/(]? INITIALIZER)/ { if( $5 == "COMPLETE:" ){ split($2,ac,":"); comp=(ac[1]*3600*1000+ac[2]*60*1000+ac[3]*1000); print (comp-start) " " $6 }else if( $5 == "STARTING:" ){ split($2,ac,":"); start=(ac[1]*3600*1000+ac[2]*60*1000+ac[3]*1000); }else{ print $0;} } END { print "===================================\nsum " sum}'
}
startup-parse()
{
	gawk '/(INITIALIZER|^ALL STARTUP)/ { if( $5 == "COMPLETE" ){ split($2,ac,":"); comp=(ac[1]*3600*1000+ac[2]*60*1000+ac[3]*1000); split($6,name,"."); printf("%40s %s\n", name[1], (comp-start) ); sum += (comp-start); }else if( $5 == "STARTING:" ){ split($2,ac,":"); start=(ac[1]*3600*1000+ac[2]*60*1000+ac[3]*1000); split($6,name,"."); run+=1; printf("%s------------\n", name[1]); }else if( $1 == "ALL" ){ print "===================================================\n" sum; sum = 0;} }'
}
hl()
{
	#ack --passthru $@
	grep -E --color -i '^|'$@
}

parse_yaml()
{
   local prefix=$2
   local s='[[:space:]]*' w='[a-zA-Z0-9_]*' fs=$(echo @|tr @ '\034')
   sed -ne "s|^\($s\):|\1|" \
        -e "s|^\($s\)\($w\)$s:$s[\"']\(.*\)[\"']$s\$|\1$fs\2$fs\3|p" \
        -e "s|^\($s\)\($w\)$s:$s\(.*\)$s\$|\1$fs\2$fs\3|p"  $1 |
   awk -F$fs '{
      indent = length($1)/2;
      vname[indent] = $2;
      for (i in vname) {if (i > indent) {delete vname[i]}}
      if (length($3) > 0) {
         vn=""; for (i=0; i<indent; i++) {vn=(vn)(vname[i])("_")}
         printf("%s%s%s=\"%s\"\n", "'$prefix'",vn, $2, $3);
      }
   }'
}

source $CODE_CONFIGS/pirate-setup/rally/scripts.sh
source $CODE_CONFIGS/pirate-setup/rc/fzf
# source ~/.pirate-setup/itermbkg

port-validate() 
{
    # for file in /code/mesos-apps/**/*.json; do 
    #     env=$(echo $file | gsed -E 's,./([^/]*)/([^\.]*)\.json,\1,g'); 
    #     app=$(echo $file | gsed -E 's,./([^/]*)/([^\.]*)\.json,\2,g');
    #     port=""; port=$(jq '.. | .servicePort? //empty' $file); 
    #     if [[ $port != "" ]]; then 
    #         echo "env: ${env}, app: ${app}, port: ${port}"; 
    #     fi; 
    # done
    
    jq --slurpfile ports /code/mesos-apps/ports.json '{ "ports": $ports[0] }' \
        /code/chef/environments/mesos-apps-dev.json
}

port-update()
{
    # port = $1  env = $2 dev-yolo  app = $3 rewards/calvinballweb
    mesosfile = /code/mesos-apps/${2}/${3}.json
    chefapp = ${3##*/}
    cheffile = /code/chef/environments/mesos-apps-dev.json
    jq --argjson port ${1} --arg env ${2} --arg app ${chefapp} \
        '.default_attributes.loadbalancer.sites["mesos_apps.werally.in"].apps[($app+"-"+$env)].port |= $port' \
        ${cheffile} > ${cheffile}.tmp && mv ${cheffile}.tmp ${cheffile}
    jq --argjson port ${1} '.container.docker.portMappings[0].servicePort |= $port' \
        ${mesosfile} > ${mesosfile}.tmp && mv ${mesosfile}.tmp ${mesosfile}
}

RALLY_CI_TOKEN='aea81b3742fe7e58aa8dcc052ca01d4e'
RALLY_CI_USER='vito-c'
RALLY_CI_API='https://rally-jenkins.werally.in/'

HIPCHAT_API='https://api.hipchat.com/v2'

if [[ -f $CODE_CONFIGS/pirate-setup/wintermute/bin/jumpto ]]; then
    source $CODE_CONFIGS/pirate-setup/wintermute/bin/jumpto 
fi

env_parallel() 
{
    export -f rally-ip
    export -f rally-servers
    export -f rally-healthy
    export -f rally-mesos-parse
    export -f rally-mongo
    export -f rally-status
    /usr/local/bin/parallel "$@"
}

dev-yolo-reward-stats()
{
    curl -s -w "%{http_code}\n" -X GET https://rewards-dev-yolo.werally.in$(jq -r '.healthChecks[].path' /code/mesos-apps/dev-yolo/rewards/rewardweb.json) -o /dev/null
}
dev-yolo-servers()
{
    aws ec2 describe-instances --filter "Name=tag-value,Values=dev-yolo" |
    jq '[.Reservations[].Instances[]|
        {"name":.Tags|map(select(.Key=="aws:autoscaling:groupName"))[].Value,
        "ip":.PrivateIpAddress, 
        "status":.State.Name, "id":.InstanceId}]'
}
rcu-servers() 
{
    curl -X POST -sS -H "Content-Type: text/plain" --data '!servers '"$1" $HIPCHAT_API/user/cloudops@rallyhealth.com/message?auth_token=$HIPCHAT_TOKEN
    sleep 6
    curl -sS $HIPCHAT_API/user/cloudops@rallyhealth.com/history/latest?auth_token=$HIPCHAT_TOKEN | 
        jq '[.items[] | .message][-1] | split("\n") | [.[] | split("\t") ] | map( { "host": .[0], "status": .[1], "mesos-id": .[2], "ip": .[3] } )'
}

backup()
{
    if [[ ! -f ${1}.bak ]]; then
        mv ${1} ${1}.bak
    fi
}
restore()
{
    mv ${1}.bak ${1}.bak.tmp
    mv ${1} ${1}.bak
    mv ${1}.bak.tmp ${1}
}
ytoj()
{
    for file in "${@}"; do 
        parse=$(python3 -c 'import sys, yaml, json; json.dump(yaml.load(sys.stdin), sys.stdout, indent=4)' < "$file" 2> /dev/null)
        err="$?"
        if [[ "$err" -gt 0 ]]; then
            python3 -c 'import datetime, sys, yaml, json; json.dump(yaml.load(sys.stdin), sys.stdout, indent=4, default= lambda o: o.__str__() if isinstance(o, datetime.datetime) else None)' < "$file"
        else
            echo "${parse}"
        fi
    done
    # only works for one file in the stream so 
    if [[ -z "$1" ]]; then
        python3 -c 'import datetime, sys, yaml, json; json.dump(yaml.load(sys.stdin), sys.stdout, indent=4, default= lambda o: o.__str__() if isinstance(o, datetime.datetime) else None)'
    fi
}
jtoy()
{
    if [[ -n "$2" ]]; then
        python3 -c 'import sys, yaml, json; yaml.safe_dump(json.load(sys.stdin), sys.stdout, default_flow_style=False)' < $1 > $2
    elif [[ -n "$1" ]]; then
        python3 -c 'import sys, yaml, json; yaml.safe_dump(json.load(sys.stdin), sys.stdout, default_flow_style=False)' < $1
    else
        python3 -c 'import sys, yaml, json; yaml.safe_dump(json.load(sys.stdin), sys.stdout, default_flow_style=False)'
    fi
}

clip()
{
    [ -t 0 ] && pbpaste || pbcopy
}
jmap()
{
    filter="$1"
    some_func="$2"
    json_file="$3"
    echo $filter
    jfilter=$(jq -c "${filter}" ${json_file})
    echo $jfilter
    echo $some_func
    for ((j=0; j< $(echo $jfilter | jq 'length'); ++j )); do
        item=$(echo $jfilter | jq -c '.['$j']');
        echo $item
        echo "${item}" | ${some_func}
    done;
}

rv_services() {
    ytoj ~/code/rally-versions/prod/*-rally-compose.yaml | jq --slurp 'map(.services|to_entries|map(.key))|add'
}
mc_port_map() {
    python -c 'import datetime, sys, yaml, json; json.dump(yaml.load(sys.stdin), sys.stdout, indent=4, default= lambda o: o.__str__() if isinstance(o, datetime.datetime) else None)' < ~/.maestro/maestro-compose.yaml | jq  -S '.compositions | map( .data.services ) | add | to_entries | map( {service:  .key, ports: .value.ports[0]}) | reduce .[] as $i ({}; .[$i.service] = $i.ports )'
}

env_secrets() {
    mc_dump $1 | jq -S '.env' |
    jq -S "${secret_filter}"
    # for ((j=0; j< $(echo $jfilter | jq 'length'); ++j )); do item=$(echo $jfilter | jq -c '.['$j']' | jq -r '.'); echo $item; done
}

json_columns() {
    # Non recursive output will only be two columns and the input needs to be in the form of a key value pair
    # i.e. input { "key1": "value1", "key2": "value2", "key3": "value3" }
    # output:
    # key1 value1
    # key2 value2
    # key3 value3

    if [[ ${#} -gt 0 ]]; then
        obj="${@}"
    else
        read -r obj
    fi
    keys=$(echo "$obj" | jq -c 'to_entries | map(.key)')
    values=$(echo "$obj" | jq -c 'to_entries | map(.value)')

    # echo kyes $keys
    # echo values $values
    for ((j=0; j< $(echo "$keys" | jq 'length'); ++j )); do 
        key="$(echo $keys | jq -c '.['$j']' | jq -r '.')"; 
        value="$(echo $values | jq -c '.['$j']' | jq -r '.')"; 
        printf "%-10s %10s\n" "$key" "$value";
    done
}

json_array_columns() {
    # Non recursive output will only be two columns and the input needs to be in the form of a key value pair
    # i.e. input { "key1": "value1", "key2": "value2", "key3": "value3" }
    # output:
    # key1 value1
    # key2 value2
    # key3 value3

    if [[ ${#} -gt 0 ]]; then
        obj="${@}"
    else
        read -r obj
    fi
    keys=$(echo "$obj" | jq -c 'to_entries | map(.key)')
    values=$(echo "$obj" | jq -c 'to_entries | map(.value)')
    headers=$(echo "$obj" | jq -c 'to_entries | map(.value)|.[0]|map(to_entries|map(.key))|add')
    map=$(echo "$obj" | jq -c 'to_entries|map({(.key):.value|add})|add')
    len=$(echo "$keys" | jq 'length')
    echo $len
    # echo kyes $keys
    # echo values $values
    for ((j=0; j<$len; ++j )); do 
        key="$(echo $keys | jq -c '.['$j']' | jq -r '.')"; 
        prod="$(echo $map | jq -c '.["'"$key"'"]["'"prod/sortinghat/web"'"]' | jq -r '.')"; 
        devc="$(echo $map | jq -c '.["'"$key"'"]["'"dev-core/sortinghat/web"'"]' | jq -r '.')"; 
        blue="$(echo $map | jq -c '.["'"$key"'"]["'"bluesteel/sortinghat/web"'"]' | jq -r '.')"; 
        inte="$(echo $map | jq -c '.["'"$key"'"]["'"integration/sortinghat/web"'"]' | jq -r '.')"; 
        load="$(echo $map | jq -c '.["'"$key"'"]["'"load-test/sortinghat/web"'"]' | jq -r '.')"; 
        printf "%-10s %10s %10s %10s %10s %10s\n" "$key" "$prod" "$blue" "$inte" "$load" "$devc";
    done
}


[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[ -f ~/code/configs/pirate-setup/rally ] && source ~/code/configs/pirate-setup/rally/*

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

source <(kubectl completion bash)
