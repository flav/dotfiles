#!/usr/bin/env bash

set -e

echo ""
echo "### Installing homebrew-cask apps"
echo ""

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

# Check for Homebrew
sh $DIR/install-homebrew.sh

apps=(
  1password
  dash
  docker
  dropbox
  firefox
  gifs
  google-chrome
  google-photos-backup-and-sync
  hammerspoon
  imagealpha
  iterm2
  java
  keyboard-cleaner
  krita
  licecap
  macdown
  nvalt
  omnidisksweeper
  rowanj-gitx
  sequel-pro
  skitch
  skype
  slack
  spotify
  sublime-text
  vagrant
  virtualbox
  viscosity
  vlc
)

echo "installing cask..."
brew tap caskroom/cask

echo "installing apps..."
brew cask install ${apps[@]}

brew cleanup

exit 0
