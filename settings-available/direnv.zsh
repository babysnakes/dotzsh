if [ -e /usr/local/bin/direnv ]; then
  eval "$(direnv hook zsh)"
else
  echo "direnv not installed"
fi
