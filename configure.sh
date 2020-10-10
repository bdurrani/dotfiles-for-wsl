#!/usr/bin/env bash

set -euo pipefail

# configuration script based on https://raw.githubusercontent.com/jldeen/dotfiles/wsl/configure.sh
# found via post: http://jessicadeen.com/tech/microsoft/badass-terminal-fcu-wsl-edition-oh-my-zsh-powerlevel9k-tmux-and-more/

# Update pkg lists
echo "Updating package lists..."
sudo apt-get update

# zsh install
echo ''
echo "Now installing zsh..."
echo ''
sudo apt install zsh -y

# Installing git completion
echo ''
echo "Now installing git and bash-completion..." 
sudo apt-get install git bash-completion -y

echo ''
echo "Now installing curl..."
sudo apt-get install curl

echo '' 
echo "Now configuring git-completion..." 
GIT_VERSION=`git --version | awk '{print $3}'` 
URL="https://raw.github.com/git/git/v$GIT_VERSION/contrib/completion/git-completion.bash" 
echo '' 
echo "Downloading git-completion for git version: $GIT_VERSION..." 
if ! curl "$URL" --silent --output "$HOME/.git-completion.bash"; then 	
	echo "ERROR: Couldn't download completion script. Make sure you have a working internet connection." && exit 1 
fi

# install vim with gui
echo ''
echo "Now installing vim with gui..."
echo ''
sudo apt-get install vim-gui-common
sudo apt-get install vim-runtime

# oh-my-zsh install
echo '' 
echo "Now installing oh-my-zsh..." 
echo '' 
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# oh-my-zsh plugin install
echo '' 
echo "Now installing oh-my-zsh plugins..." 
echo '' 
git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions 
git clone git://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions 
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting

# install z.sh
echo ''
echo "Now installing z.sh..."
echo ''
curl https://raw.githubusercontent.com/bdurrani/dotfiles-for-wsl/master/z-plugin/z.sh -o ~/z.sh

# powerlevel9k install
echo ''
echo "Now installing powerlevel9k..."
echo ''
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

# Midnight commander install
echo ''
echo "Now installing Midnight commander..."
echo ''
sudo apt-get install mc -y

# install node 8.x
# https://nodejs.org/en/download/package-manager/#debian-and-ubuntu-based-linux-distributions
echo ''
read -p "Do you want to install nodejs 8.x y/n " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
	curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
	sudo apt-get install -y nodejs
fi

echo ''
read -p "Do you want to install nodejs build tools y/n " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
	sudo apt-get install -y build-essential
fi

echo ''
echo "Setting 0h-my-zsh plug-in defaults for .zshrc and .bashrc..."
echo ''
echo "source $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc && echo "added zsh-syntax-highlighting to .zshrc..."
echo ''
echo "source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc && echo "added zsh-autosuggestions to .zshrc..."
echo ''
echo "source $HOME/.git-completion.bash" >> ${ZDOTDIR:-$HOME}/.bashrc && echo "added git-completion to .bashrc..."
echo ''
echo "source $HOME/z.sh" >> ${ZDOTDIR:-$HOME}/.zshrc && echo "added z.sh to .zshrc..."

# Set default shell to zsh
echo " To make zsh your default shell, add the
following to the top of ~/.bashrc and restart your terminal

 # launch zsh
 if [ -t 1 ]; then
    exec zsh
 fi
"
echo ''
read -p "Do you want to change your default shell? y/n" -n 1 -r
echo ''
if [[ $REPLY =~ ^[Yy]$ ]]
then
	echo "Now setting default shell..."
    chsh -s $(which zsh); exit 0
    if [[ $? -eq 0 ]]
    then
        echo "Successfully set your default shell to zsh..."
    else
        echo "Default shell not set successfully..." >&2
	fi
fi
echo ''

echo 'Install fzf'
sudo apt install fzf
