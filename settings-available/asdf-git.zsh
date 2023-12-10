[ -f ${HOME}/.asdf/asdf.sh ] && . ${HOME}/.asdf/asdf.sh

export PATH=${HOME}/.asdf/shims:${PATH}

# append completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)
# initialise completions with ZSH's compinit
autoload -Uz compinit && compinit
