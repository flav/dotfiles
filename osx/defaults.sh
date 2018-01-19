#!/usr/bin/env bash

set -e

echo ""
echo "### Writing MacOS defaults configurations"
echo ""

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

for d in $DIR/defaults/*; do
	echo "$d";
	sh "$d";
done
