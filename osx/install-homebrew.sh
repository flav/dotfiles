#!/usr/bin/env bash

set -e

if [ "$(uname)" == "Darwin" ] && test ! $(which brew); then
  echo "Installing homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
