#!/usr/bin/env bash

# Ask for the administrator password upfront
sudo -v

# Brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# ZSH
brew install node zsh zsh-completions
chsh -s $(which zsh)

# Node
npm install grunt gulp elint -g 

# Homestead
vagrant plugin install vagrant-hostmanager
vagrant plugin install vagrant-cachier

# Submile 
ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin

# Pods 
sudo gem install cocoapods