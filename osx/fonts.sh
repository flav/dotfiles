#!/usr/bin/env bash

set -e

echo ""
echo "### Installing homebrew-cask fonts"
echo ""

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

# Check for Homebrew
sh $DIR/install-homebrew.sh

fonts=(
  font-hack
  font-kreon
  font-lato
  font-league-gothic
  font-libre-baskerville
  font-montserrat
  font-open-sans
  font-open-sans-condensed
  font-pt-mono
  font-pt-sans
  font-pt-serif
  font-roboto
  font-source-code-pro
  font-ubuntu
  font-work-sans
)

fonts_not_available_in_cask=(
  "JennaSue http://www.dafont.com/jenna-sue.font"
)

echo "installing cask..."
brew tap phinze/homebrew-cask

# Tap the fonts
echo "installing caskroom/fonts"
#brew tap caskroom/cask-fonts
brew tap homebrew/cask-fonts

# install fonts
echo "installing fonts..."
brew cask install ${fonts[@]}

brew cleanup

exit 0
