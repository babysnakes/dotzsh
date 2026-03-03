DOT_ZSH=${HOME}/.zsh

function exit_with_error() {
  echo $1
  exit -1
}

# ZAP - https://www.zapzsh.com/
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] || \
  exit_with_error "It seems that zap is not installed. Please install it first"

source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"

## Files and Directories ##
alias pu='pushd'
alias po='popd'
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt AUTO_CD
setopt EXTENDED_GLOB
#setopt pushdminus # do we need it?

## History ##
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
alias history='fc -l 1'
setopt APPEND_HISTORY
# setopt EXTENDED_HISTORY # !!!
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_VERIFY # ?
setopt INC_APPEND_HISTORY
# setopt SHARE_HISTORY # this imports shared history. Can trigger manually with fc -RI

# A git ignored file that contains PATH directories that are required for the plugins
# (e.g. where fzf, exa, etc are installed)
[[ -f ${DOT_ZSH}/paths.zsh ]] || touch ${DOT_ZSH}/paths.zsh
plug "${DOT_ZSH}/paths.zsh"

## Plugins ##
if (( $+commands[fzf] )); then
    plug "Aloxaf/fzf-tab"
else
    echo "no fzf installed, skipping fzf-tab"
fi
plug "zsh-users/zsh-autosuggestions"
# plug "zap-zsh/supercharge"
plug "zap-zsh/zap-prompt" # just in case we don't override this
plug "zsh-users/zsh-syntax-highlighting"
plug "zap-zsh/exa"

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

# git
alias gst="git status"

## Source all enabled settings
plug "${DOT_ZSH}/settings-enabled/*"

