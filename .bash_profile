# BASIC CONFIGURATION
#   ------------------------------------------------------------
export PATH="/usr/local/sbin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"

# Modify Bash Prompt
export PS1="\033[38;5;34m\$ \033[0m" #00af00
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
export EDITOR=/usr/local/sbin/emacs
export LANG="en_US.UTF-8"
export LC_CTYPE='en_US.UTF-8'
export BASH_SILENCE_DEPRECATION_WARNING=1

# History handling
export HISTCONTROL=erasedups # Erase duplicates
export HISTSIZE=10000 # resize history size
shopt -s histappend # append to bash_history if Terminal.app quits

# GIT
git config --global color.diff auto
git config --global color.status auto
git config --global color.branch auto

# Bash autocomplete
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

# Nu ENV
export NU_HOME=~/dev/nu
export PATH="$NU_HOME/nucli:$PATH"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
