# My Zsh environment.

## Installation instructions

* Clone this respository as `$HOME/.zsh`.
* Update submodules: `git submodule update --init`.
* Symlink `REPOSITORY_ROOT/zshrc` to `$HOME/.zshrc`.
* Make sure you link one of `REPOSITORY_ROOT/settings-available/0-prompt*.zsh`
  to `settings-enabled` (see [Other directories](#other-directories) below).

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

## Other directories

* `$DOT_ZSH/settings-enabled` - Every `*.zsh` file in this directory will be
  sourced. These files are ignored by git.
* `$DOT_ZSH/settings-available` - Holds various settings. In order to
  enable these settings they are to be copied/linked to
  `$DOT_ZSH/settings-enabled`.

[zsh-completions]: http://github.com/zsh-users/zsh-completions
