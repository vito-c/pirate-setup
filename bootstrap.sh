#!/usr/bin/env sh

endpath="$HOME/.pirate-setup"

warn() {
    echo "$1" >&2
}

die() {
    warn "$1"
    exit 1
}

lnif() {
    if [ ! -e $2 ] ; then
        ln -s $1 $2
    fi
    if [ -L $2 ] ; then
        ln -sf $1 $2
    fi
}

echo "Yar we be swabbing the deck of your brand new pirate vim"

# Backup existing .vim stuff
echo "Stowing your old booty to make room for the new"
today=`date +%Y%m%d`
for i in $HOME/.vim $HOME/.vimrc $HOME/.gvimrc; do [ -e $i ] && [ ! -L $i ] && mv $i $i.$today; done


if [ ! -e $endpath/.git ]; then
    echo "What's got two eyes, two left feet, and two hooks?"
    echo "A pirate and his clone! yaaR"
    git clone --recursive git://github.com/vito-c/pirate-vim.git $endpath
else
    echo "Hoist the main sail and Pull up the achor"
    cd $endpath && git pull
fi

if [ ! -d $endpath/pirate-vim ]; then
    mkdir -p $endpath/pirate-vim
	echo "You can't swim without vim"
    git clone git@github.com:vito-c/pirate-vim.git $endpath/pirate-vim
fi

if [ ! -d $endpath/vim/bundle ]; then
    mkdir -p $endpath/vim/bundle
fi

echo "To the High Seeea-links"
lnif $endpath/gitconfig $HOME/.gitconfig
lnif $endpath/inputrc $HOME/.inputrc
# vim links
lnif $endpath/pirate-vim $HOME/.vim
lnif $endpath/pirate-vim/vimrc.bundles $HOME/.vimrc.bundles
lnif $endpath/pirate-vim/vimrc $HOME/.vimrc

if [ ! -e $HOME/.vim/bundle/vundle ]; then
    echo "Bundles of booty"
    git clone http://github.com/gmarik/vundle.git $HOME/.vim/bundle/vundle
fi

echo "bundles of vundles"
system_shell=$SHELL
export SHELL="/bin/sh"
vim -u $endpath/pirate-vim/vimrc.bundles +BundleInstall! +BundleClean +qall
export SHELL=$system_shell
