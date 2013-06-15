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
# Searched by started commands
bindkey '^X^P' up-line-or-search
bindkey '^X^N' down-line-or-search

## Helpers ##
function take() {
    mkdir -p $1
    cd $1
}

# manage .chef links
function dot-chef() {
    if [ -z "$1" ]; then
        [ -L .chef ] && \
            echo ".chef currently points to $(readlink .chef)" || \
            echo "There is no .chef link!"
        echo "Run: dot-chef <DIR> in order to link .chef to <DIR>"
    elif [ ! -d "$1" ]; then
        echo "Directory \"$1\" doesn't exist!"
        return 1
    else
        [ -L .chef ] && unlink .chef
        ln -s "$1" .chef
        ls -l .chef
    fi
}

# Functions to add and remove elements from the path. Converts
# relative paths to absolute paths.
function add-to-path {
    if [ -z $1 ]; then
        echo "Usage: add_to_path DIR"
        return 1
    else
        PATH_TO_ADD=$(echo "$1"(:A))
        export PATH=${PATH_TO_ADD}:${PATH}
        rehash
    fi
}

function remove-from-path {
    if [[ -z $1 ]]; then
        echo "Usage: remove-from-path DIR"
        return 1
    else
        PATH_TO_REMOVE=$(echo "$1"(:A))
        if [[ $PATH == *$PATH_TO_REMOVE:* ]]; then
            export PATH=${PATH%$PATH_TO_REMOVE*}${PATH#*$PATH_TO_REMOVE:}
            rehash
        elif [[ $PATH == *$PATH_TO_REMOVE ]]; then
            export PATH=${PATH%$PATH_TO_REMOVE}
            rehash
        fi
    fi
}

# prompt helpers
function indicate_git_dirty_directory() {
    local GIT_STATUS
    GIT_STATUS=$(git status -s 2>/dev/null | tail -n1)
    if [[ -n $GIT_STATUS ]]; then
        echo '*'
    fi
}

function git_info_prompt() {
    ref=$(git symbolic-ref HEAD 2> /dev/null) || \
        ref=$(git rev-parse --short HEAD 2> /dev/null) || return
    echo "git:${ref#refs/heads/}$(indicate_git_dirty_directory)"
}

## Completions search path ##
fpath=($DOT_ZSH/tmp-completions $DOT_ZSH/custom-completions $DOT_ZSH/zsh-completions/src $fpath)

## Completions ##
source $DOT_ZSH/completions.zsh

## Line edit ##
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line
bindkey -e
bindkey "^[m" copy-prev-shell-word # file rename magix
# TODO: What does this WORDCHAR do (except for backward-kill-word)?
WORDCHARS=${WORDCHARS//\//}

## Title and Prompt ##
setopt prompt_subst
autoload -U colors && colors
local right_prompt='$(git_info_prompt)'
PROMPT="%{$fg[yellow]%}%c%(?. . %{$fg[red]%})➤ %{$reset_color%}"
RPROMPT="%{$fg[yellow]%}${right_prompt}%{$reset_color%}"
precmd(){
    # iterm tab title (last 15 characters of path).
    print -Pn "\e]1;%15<..<%~%<<\a"
    # This seem to work both on terminal and tmux.
    print -Pn "\e]2;%n@%m:%~\a"
}
preexec(){
    # iterm tab title (not sure exactly how it operates).
    print -Pn "\e]1;%100>...>${2:gs/%/%%}%<<\a"
    # This seem to work both on terminal and tmux.
    print -Pn "\e]2;%n@%m:$(echo "$1" | cut -d" " -f1)\a"
}

## Shell customizations ##

# smart urls
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

# jobs
setopt long_list_jobs
setopt notify

## Application Specific ##

# pager
export PAGER="less"
export LESS="-R"

# grep
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;32'

# nvm
[[ -s /Users/haim/.nvm/nvm.sh ]] && . /Users/haim/.nvm/nvm.sh

# bundler
alias be="bundle exec"

# allow square brackets for rake task invocation
alias rake='noglob rake'

# git
alias gst="git status"

# tmuxinator
 [[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source \
     $HOME/.tmuxinator/scripts/tmuxinator

# Source settings from the temporary directory
for i in $DOT_ZSH/settings-enabled/*.zsh(N); do
    source $i
done

# Local Variables:
# mode: shell-script
# End:
