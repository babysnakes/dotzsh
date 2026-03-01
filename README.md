# My Zsh environment.

## Installation instructions

* Clone this respository as `$HOME/.zsh`.
* Symlink `REPOSITORY_ROOT/zshrc` to `$HOME/.zshrc`.

## Completion directories

If you need custom completion file, you can put it in `$DOT_ZSH/tmp-completions`.

## Other directories

* `$DOT_ZSH/settings-enabled` - Every `*.zsh` file in this directory will be
  sourced. These files are ignored by git.
* `$DOT_ZSH/settings-available` - Holds various settings. In order to
  enable these settings they are to be copied/linked to
  `$DOT_ZSH/settings-enabled`.

use `enable-settings-file` function to enable a settings file.
