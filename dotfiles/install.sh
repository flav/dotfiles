#!/usr/bin/env bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

cd $DIR
set -e

function makeLinks {
    DEST=$1
    SOURCE_DIR=$DIR/$2
    for f in `ls -A $SOURCE_DIR`; do
        SOURCE=$SOURCE_DIR/$f
        TARGET=$DEST/$f

        echo "Linking ${DEST}/${f}"

        # Note explicit *link* (-L) and *exists* (-e) checks as a broken links
        # fail the (-e) check.
        if [ -L $TARGET ]; then
            echo " Link exists - removing " $TARGET
            rm $TARGET
        elif [ -e $TARGET ]; then
            BACKUPFILE="${TARGET}.`date +"%Y%m%d_%H%M%S"`.bak"
            echo " File exists - making backup " $BACKUPFILE
            mv $TARGET $BACKUPFILE
        fi

        ln -s ${SOURCE#$DEST/} $TARGET
    done
}

mkdir ~/bin 2>/dev/null || true

touch ~/.gitexcludes

makeLinks $HOME ag
makeLinks $HOME bash
makeLinks $HOME git
makeLinks $HOME screen
makeLinks $HOME tmux
makeLinks $HOME vim
