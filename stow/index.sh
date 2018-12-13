#!/usr/bin/env bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

cd $DIR
set -e

mkdir ~/bin 2>/dev/null || true

stow --target=$HOME ag
stow --target=$HOME bash
stow --target=$HOME git
stow --target=$HOME screen
stow --target=$HOME tmux
stow --target=$HOME vim
