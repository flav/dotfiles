#!/usr/bin/env bash

set -e

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

sh $DIR/defaults.sh
sh $DIR/binaries.sh
sh $DIR/apps.sh
sh $DIR/fonts.sh
