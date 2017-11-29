# dotfiles-for-wsl
My configuration files for WSL

This repository contains a collection of .dot files 
I use to set up WSL for Windows 10 (Fall Creators update)

This was inspired heavily by 
[Jesscia Deen's blog post](http://jessicadeen.com/tech/microsoft/badass-terminal-fcu-wsl-edition-oh-my-zsh-powerlevel9k-tmux-and-more/)

## Configure new system

`configure.sh` has everything you need to set up a fresh ubuntu install.

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/bdurrani/dotfiles-for-wsl/master/configure.sh)" 
```

## install
Run this:

```sh
git clone https://github.com/holman/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
script/bootstrap
```

This will symlink the appropriate files in `.dotfiles` to your home directory.
Everything is configured and tweaked within `~/.dotfiles`.

The main file you'll want to change right off the bat is `zsh/zshrc.symlink`,
which sets up a few paths that'll be different on your particular machine.