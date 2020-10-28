#!/usr/local/bin/bash
export BASH_CONFIGS=$HOME/code/configs/pirate-setup

source $BASH_CONFIGS/rc/core        # ~/code/configs/pirate-setup/rc/core
source $BASH_CONFIGS/rc/completions # ~/code/configs/pirate-setup/rc/completions
source $BASH_CONFIGS/rc/fzf         # ~/code/configs/pirate-setup/rc/fzf
source $BASH_CONFIGS/rc/git         # ~/code/configs/pirate-setup/rc/git
source $BASH_CONFIGS/rc/history     # ~/code/configs/pirate-setup/rc/history
source $BASH_CONFIGS/rc/json        # ~/code/configs/pirate-setup/rc/json
source $BASH_CONFIGS/rc/ps1         # ~/code/configs/pirate-setup/rc/ps1
source $BASH_CONFIGS/rc/utils       # ~/code/configs/pirate-setup/rc/utils

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
