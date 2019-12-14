eval "$(nodenv init - --no-rehash zsh)"
function npm-cmpl {
    source <(npm completion)
}
