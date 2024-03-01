export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
if type brew &>/dev/null
then
  fpath=($(brew --prefix)/share/zsh/site-functions $fpath)

  autoload -Uz compinit
  compinit
fi
