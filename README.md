# My Zsh environment.

## Installation instructions

* Clone this respository as `$HOME/.zsh`.
* Update submodules: `git submodule update --init`.
* Symlink `REPOSITORY_ROOT/zshrc` to `$HOME/.zshrc`.

## Completion directories
Here's a list of the directories were completions are searched
(`$fpath`). Completions are searched in the following order:

* `$DOT_ZSH/tmp-completions` - Directory to place completions that
  should not be in this repository.
* `$DOT_ZSH/custom-completions` - Custom completions (saved in the
  repository).
* `$DOT_ZSH/zsh-completions` - A git submodule, the
  [zsh-completions][] project.
* Directories in the default `$fpath`.

[zsh-completions]: http://github.com/zsh-users/zsh-completions
