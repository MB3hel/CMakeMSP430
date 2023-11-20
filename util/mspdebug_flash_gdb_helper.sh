#!/usr/bin/env sh

# Get path to mspdebug the same way toolchain file gets path for compiler
# Get path to mspdebug the same way toolchain file gets path for compiler
if [ -z "$MSPDEBUG_ROOT" ]; then
    uanme_s="$(uname -s)"
    case "${uanme_s}" in
        Darwin*) 
            if [ -d "$HOME/ti/mspdebug" ]; then
                MSPDEBUG="$HOME/ti/mspdebug/mspdebug"
            else
                MSPDEBUG="/Applications/ti/mspdebug/mspdebug"
            fi
        ;;
        *)
            if [ -d "$HOME/ti/mspdebug" ]; then
                MSPDEBUG="$HOME/ti/mspdebug/mspdebug"
            else
                MSPDEBUG="/opt/ti/mspdebug/mspdebug"
            fi
        ;;
    esac
else
    MSPDEBUG="$MSPDEBUG_ROOT/mspdebug"
fi

# First arg to this script is the elf file name
# Change extension from elf to hex
# Then program the hex and run gdb
# VSCode can't subtitute elf for hex, so can't do this directly in IDE
FILE=$(echo "$1" | sed 's/.elf/.hex/g')
"$MSPDEBUG" --allow-fw-update tilib --force-reset "prog $FILE" "gdb"
