##
## A prompt without the need of external tools
##

# prompt helpers
function indicate_git_dirty_directory() {
    local GIT_STATUS
    GIT_STATUS=$(git status -s 2>/dev/null | tail -n1)
    if [[ -n $GIT_STATUS ]]; then
        echo '*'
    fi
}

function git_info_prompt() {
    ref=$(git rev-parse --abbrev-ref HEAD 2>/dev/null) || return
    echo "git:${ref}$(indicate_git_dirty_directory)"
}

## Title and Prompt ##
setopt prompt_subst
autoload -U colors && colors
local right_prompt='$(git_info_prompt)'
PROMPT="%(?.%{$fg[yellow]%}✓.%{$fg[red]%}✗) %{$fg[yellow]%}%c ➤ %{$reset_color%}"
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
