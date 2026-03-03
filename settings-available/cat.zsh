if (( $+commands[bat] )); then
  alias cat="bat"
else
  echo "'bat' is not installed, skipping 'cat' alias"
fi
