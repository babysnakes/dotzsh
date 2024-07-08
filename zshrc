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

# Functions to add and remove elements from the path. Converts
# relative paths to absolute paths.
function add-to-path {
    if [ -z $1 ]; then
        echo "Usage: add_to_path DIR"
        return 1
    else
        PATH_TO_ADD=${1:A}
        export PATH=${PATH_TO_ADD}:${PATH}
        rehash
    fi
}

function remove-from-path {
   if [[ -z $1 ]]; then
        echo "Usage: remove-from-path DIR"
        return 1
    else
        PATH_TO_REMOVE=${1:A}
        if [[ $PATH == *$PATH_TO_REMOVE:* ]]; then
            export PATH=${PATH%$PATH_TO_REMOVE*}${PATH#*$PATH_TO_REMOVE:}
            rehash
        elif [[ $PATH == *$PATH_TO_REMOVE ]]; then
            export PATH=${PATH%$PATH_TO_REMOVE}
            rehash
        fi
    fi
}

# A helper to enable settings file
function enable-settings-file {
    file_name=`basename ${1}`

    if [ -z "$file_name" ]; then
        echo "Must specify settings file"
        exit 1
    fi

    setting=${DOT_ZSH}/settings-available/${file_name}
    ln -s ${setting} ${DOT_ZSH}/settings-enabled/
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

# ls with colors
alias ls='ls -G'

# grep
alias grep='grep --color=auto'
export GREP_COLOR='1;32'

# git
alias gst="git status"

# Editor
export EDITOR=vim
alias edit=$EDITOR

# Source settings from the temporary directory
for i in $DOT_ZSH/settings-enabled/*.zsh(N); do
    source $i
done
