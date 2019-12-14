# Depends on https://github.com/Tarrasch/zsh-autoenv
# being installed in ~/.dotfiles/lib/zsh-autoenv

if [ -e ~/.dotfiles/lib/zsh-autoenv/autoenv.zsh ]; then
    source ~/.dotfiles/lib/zsh-autoenv/autoenv.zsh
else
    echo "~/.dotfiles/lib/zsh-autoenv/autoenv.zsh doesn't exist! skipping autoenv..."
fi
