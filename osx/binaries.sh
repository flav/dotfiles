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
  jq
  kube-ps1
  mkcert
  multitail
  node
  nss
  packer
  stow
  telnet
  tmux
  tree
  vim
  watch
  wget
  yarn
)

# Install the binaries
brew install ${binaries[@]}

# https://github.com/ahmetb/kubectx
brew install kubectx --with-short-names

brew tap theseal/ssh-askpass
brew install ssh-askpass

# Remove outdated versions from the cellar
brew cleanup

exit 0
