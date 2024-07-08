if [ -e ${HOMEBREW_PREFIX}/bin/direnv ]; then
  eval "$(direnv hook zsh)"
else
  echo "direnv not installed"
fi
