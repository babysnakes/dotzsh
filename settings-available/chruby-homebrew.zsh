if [ -e /usr/local/opt/chruby/share/chruby/chruby.sh ]; then
    source /usr/local/opt/chruby/share/chruby/chruby.sh
    chruby ruby-1.9.3 >/dev/null
fi
alias R='ruby -v'
