setopt auto_menu
setopt complete_in_word
setopt always_to_end

# case insensitive completions
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# use cache
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path $DOT_ZSH/cache/

# Ignore completion functions for commands I don't have
zstyle ':completion:*:functions' ignored-patterns '_*'

# just copied from oh-my-zsh
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u `whoami` -o pid,user,comm -w -w"

# Host list to search from when looking for hosts. The known_hosts is
# not in this list.
[ -r ~/.ssh/config ] && _ssh_config=($(cat ~/.ssh/config | sed -ne 's/Host[=\t ]//p')) || _ssh_config=()
[ -r /etc/hosts ] && : ${(A)_etc_hosts:=${(s: :)${(ps:\t:)${${(f)~~"$(</etc/hosts)"}%%\#*}##[:blank:]#[^[:blank:]]#}}} || _etc_hosts=()
hosts=(
    "$_ssh_config[@]"
    "$_etc_hosts[@]"
    "$HOST"
    localhost
)
zstyle ':completion:*:hosts' hosts $hosts
zstyle ':completion:*' users off

autoload -Uz compinit
compinit

# Local Variables:
# mode: shell-script
# End:
