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
  bat
  colordiff
  ffmpeg
  fzf
  git
  git-extras
  ipcalc
  jq
  kube-ps1
  kubectx
  mkcert
  mtr
  multitail
  node
  nss
  packer
  shellcheck
  spark
  stow
  telnet
  tmux
  tmuxp
  tree
  vim
  watch
  wget
  yarn
  youtube-dl
)

# Install the binaries
brew install ${binaries[@]}

brew tap theseal/ssh-askpass
brew install ssh-askpass

# https://github.com/jesseduffield/lazydocker
brew tap jesseduffield/lazydocker
brew install lazydocker

# https://github.com/noahgorstein/jqp
brew install noahgorstein/tap/jqp

# Remove outdated versions from the cellar
brew cleanup

exit 0
