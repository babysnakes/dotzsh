DOT_ZSH=${HOME}/.zsh

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd extendedglob nomatch notify
bindkey -e

source $DOT_ZSH/zsh-completions.zsh
