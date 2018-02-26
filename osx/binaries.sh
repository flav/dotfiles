#!/usr/bin/env bash

set -e

echo ""
echo "### Installing homebrew binaries"
echo ""

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

# Check for Homebrew
sh $DIR/install-homebrew.sh

# Update homebrew
brew update

# Install other useful binaries
binaries=(
  ack
  ag
  ansible
  awscli
  colordiff
  ffmpeg
  git
  git-extras
  ipcalc
  node
  packer
  tmux
  tree
  vim
  wget
)

# Install the binaries
brew install ${binaries[@]}

brew tap theseal/ssh-askpass
brew install ssh-askpass

# Remove outdated versions from the cellar
brew cleanup

exit 0
