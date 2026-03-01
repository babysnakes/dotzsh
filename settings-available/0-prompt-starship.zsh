# Starship prompt, Needs to be installed manually.
if (( $+commands[starship] )); then
  eval "$(starship init zsh)"
else
  echo "'starship' is not installed! skipping prompt"
fi
