DOT_ZSH=${HOME}/.zsh

## Files and Directories ##
alias pu='pushd'
alias po='popd'
setopt auto_pushd
setopt pushd_ignore_dups
setopt autocd
setopt extendedglob
#setopt pushdminus # do we need it?

## History ##
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
alias history='fc -l 1'
setopt append_history
setopt extended_history # !!!
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history

## Helpers ##
function take() {
    mkdir -p $1
    cd $1
}

## Completions ##
source $DOT_ZSH/zsh-completions.zsh

## Line edit ##
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line
bindkey -e
bindkey "^[m" copy-prev-shell-word # file rename magix
# TODO: What does this WORDCHAR do (except for backward-kill-word)?
WORDCHARS=${WORDCHARS//\//}

## Title and Prompt ##
autoload -U colors && colors
PROMPT="%{$fg[yellow]%}%c ➤ %{$reset_color%}"
precmd(){
    # This seem to work both on terminal and tmux.
    print -Pn "\e]2;%n:%~\a"
}
preexec(){
    # This seem to work both on terminal and tmux.
    print -Pn "\e]2;%n:$(echo "$1" | cut -d" " -f1)\a"
}

## smart urls
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

## jobs
setopt long_list_jobs
setopt notify

## pager
export PAGER="less"
export LESS="-R"

## grep
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;32'
