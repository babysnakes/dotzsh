# z
if (( $+commands[zoxide] )); then
  eval "$(zoxide init zsh)"
else
  echo "'zoxide' is not installed! skipping 'z'"
fi
