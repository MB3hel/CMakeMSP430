#!/usr/bin/env sh

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

# Run MSPDEBUG with all arguments passed into this script
"$MSPDEBUG" "$@"
