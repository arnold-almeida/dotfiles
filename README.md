# dotfiles

A collection of my "dotfiles" :v:

If your terminal starts bugging out, you can turn enable verbose logging to

    setopt XTRACE VERBOSE

to disable

    unsetopt XTRACE


## Setup 0

## Homebrew

1.
    if test ! $(which brew)
    then
      echo "  Installing Homebrew for you."
      ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi

2. Install homebrew deps via "brew bundle"

    https://github.com/Homebrew/homebrew-bundle

### Features

Manage `/etc/hosts` files via

    https://github.com/alphabetum/hosts

## todo

Speed up load time. At time of writing. ~1.x secs. Ugh....

    1.19 real         0.78 user         0.34 sys
    1.15 real         0.76 user         0.33 sys
    1.15 real         0.75 user         0.33 sys
    1.15 real         0.76 user         0.33 sys
    1.16 real         0.76 user         0.33 sys
    1.16 real         0.76 user         0.33 sys
    1.15 real         0.76 user         0.33 sys

  https://carlosbecker.com/posts/speeding-up-zsh/

Use zplug to manage zsh plugins

    https://github.com/zplug/zplug

Plugins

    https://github.com/unixorn/awesome-zsh-plugins

      > https://github.com/b4b4r07/emoji-cli
      > https://github.com/junegunn/fzf
      > https://github.com/b4b4r07/enhancd

Fonts

  > http://input.fontbureau.com/

## Features

Use a `Brewfile` to manage homebrew dependencies

    http://homebrew-file.readthedocs.io/en/latest/

## manual

| Command       | Example           | Description                            |
| :------------ | :---------------: | -------------:                         |
| kill          | `kill <tab>`        | List all processes with PID            |
| ports         | ports :3000       | Find processes using a particular port |


## Install

Install base

    brew install zsh zsh-completions

Set your default shell

    http://zanshin.net/2013/09/03/how-to-use-homebrew-zsh-instead-of-max-os-x-default/

### TBA

This will symlink the appropriate files in `.dotfiles` to your home directory.
Everything is configured and tweaked within `~/.dotfiles`.

The main file you'll want to change right off the bat is `zsh/zshrc.symlink`,
which sets up a few paths that'll be different on your particular machine.

## components

There's a few special files in the hierarchy.

- **bin/**: Anything in `bin/` will get added to your `$PATH` and be made
  available everywhere.
- **topic/\*.zsh**: Any files ending in `.zsh` get loaded into your
  environment.
- **topic/path.zsh**: Any file named `path.zsh` is loaded first and is
  expected to setup `$PATH` or similar.
- **topic/completion.zsh**: Any file named `completion.zsh` is loaded
  last and is expected to setup autocomplete.
- **topic/\*.symlink**: Any files ending in `*.symlink` get symlinked into
  your `$HOME`. This is so you can keep all of those versioned in your dotfiles
  but still keep those autoloaded files in your home directory. These get
  symlinked in when you run `script/bootstrap`.

## Inspired from

- [Zach Holman](http://github.com/holman)
- [Greg](https://github.com/myfreeweb/zshuery)
