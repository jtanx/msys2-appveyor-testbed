#!/bin/bash

BASE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

PACKAGES=(
    mingw-w64-cross-winstorecompat-git
)

# Colourful text
# Red text
function log_error() {
    echo -ne "\e[31m"; echo "$@"; echo -ne "\e[0m"
}

# Yellow text
function log_status() {
    echo -ne "\e[33m"; echo "$@"; echo -ne "\e[0m"
}

# Green text
function log_note() {
    echo -ne "\e[32m"; echo "$@"; echo -ne "\e[0m"
}

function bail () {
    echo -ne "\e[31m\e[1m"; echo "!!! Build failed at: ${@}"; echo -ne "\e[0m"
    exit 1
}

for dir in ${PACKAGES[*]}; do
    cd $BASE

    if [ ! -d $dir ]; then
        bail "$dir doesn't exist"
    else
        log_note "Building $dir"
        cd $dir
        makepkg -sLfci --noconfirm --noprogressbar || bail "Failed to build $dir"
        #pacman -U --force --noconfirm *any.pkg.tar.xz
    fi
done

log_note "Done."