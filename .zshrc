#!/usr/bin/env zsh
#                     __
#    __  _____  ___  / /______
#   / / / / _ \/ _ \/ __/ ___/
#  / /_/ /  __/  __/ /_(__  )
#  \__, /\___/\___/\__/____/
# /____/
#                     _____
#   _________  ____  / __(_)___ _
#  / ___/ __ \/ __ \/ /_/ / __ `/
# / /__/ /_/ / / / / __/ / /_/ /
# \___/\____/_/ /_/_/ /_/\__, /
#                       /____/
#                       for zsh :)
# This is a simple config where most settings are set here and functions and aliases are moved
# into seperate files. plugins are managed by zplug

# Keep 10000 lines of history within the shell and save it to ~/.cache/zsh_history:
#history settings
setopt histignorealldups sharehistory
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/zsh_history ## my history file is located here

setopt autocd   # Automatically cd into typed directory.
stty stop undef # Disable ctrl-s to freeze terminal.
setopt interactive_comments

cdpath=(~/code ~/.dotfiles)
# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

bindkey -v #this makes my terminal use the vim mode
export KEYTIMEOUT=1

autoload edit-command-line
zle -N edit-command-line
bindkey '^e' edit-command-line

#exports
export LS_COLORS="$(vivid generate snazzy)"
export ENABLE_CORRECTION= "true"
#autosuggestions configuration
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=4'
bindkey '^ ' autosuggest-accept

[ -d ~/.emacs.d ] && (rmdir ~/.emacs.d)
#zsh functions that i have written/ stole live in here
[ -f $ZDOTDIR/zsh-functions ] && source $ZDOTDIR/zsh-functions
#keybinds will live here
[ -f $ZDOTDIR/zsh-aliases ] && source $ZDOTDIR/zsh-keys
# I like fzf so i use it for stuff
[ -f $ZDOTDIR/fzf.zsh ] && source $ZDOTDIR/fzf.zsh
#aliases for commands
[ -f ~/.config/aliases ] && source ~/.config/aliases

. $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh
## I moved to zplug :) it was a little persnickity but we are all good now :)
export ZPLUG_HOME=$ZDOTDIR/zplug
source $ZPLUG_HOME/init.zsh

export PF_INFO="ascii title os host kernel uptime pkgs shell palette" ## what is shown when pfetch is called
#export PF_SEP=" ->" ## the seporator between the info title and the info data
#export PF_SOURCE="/opt/shell-color-scripts/randomcolors.sh" ## a script to source before running pfetch

export PF_COL1=4 ## colour of info names
export PF_COL2=7 ## colour of info details
export PF_COL3=5 ## color of the title (hostname and all that)
export PF_ALIGN="8"

# zplug "ohmyzsh/ohmyzsh", as:plugin, use:"lib/{clipboard.zsh,correction.zsh,git.zsh,grep.zsh,history.zsh,misc.zsh,prompt_info_functions.zsh,spectrum.zsh,theme-and-appearance.zsh}", defer:0
#zplug "zsh-users/zsh-syntax-highlighting", defer:2 #
zplug "zdharma/fast-syntax-highlighting", defer:2
zplug "zsh-users/zsh-autosuggestions", defer:2
zplug "hlissner/zsh-autopair", defer:2
zplug "jeetelongname/Yeet-theme", as:theme, defer:1, dir:~/code/git-repos/yeet-theme

# zplug "plugins/golang", from:oh-my-zsh
# zplug "plugins/tmux", from:oh-my-zsh, lazy:true
zplug "plugins/alias-finder", from:oh-my-zsh, as:plugin
#zplug "plugins/colored-man-pages", from:oh-my-zsh, lazy:false

if ! zplug check --verbose; then
	printf "Install? [y/N]: "
	if read -q; then
		echo
		zplug install
	fi
fi

zplug load
export PATH="$HOME/.poetry/bin:$PATH"
