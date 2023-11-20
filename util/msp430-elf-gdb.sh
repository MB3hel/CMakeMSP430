#!/usr/bin/env sh

# Get path to gdb the same way toolchain file gets path for compiler
if [ -z "$TI_MSP430_GCC_ROOT" ]; then
    uanme_s="$(uname -s)"
    case "${uanme_s}" in
        Darwin*) 
            if [ -d "$HOME/ti/msp430-gcc" ]; then
                GDB="$HOME/ti/msp430-gcc/bin/msp430-elf-gdb"
            else
                GDB="/Applications/ti/msp430-gcc/bin/msp430-elf-gdb"
            fi
        ;;
        *) if [ -d "$HOME/ti/msp430-gcc" ]; then
                GDB="$HOME/ti/msp430-gcc/bin/msp430-elf-gdb"
            else
                GDB="/opt/ti/msp430-gcc/bin/msp430-elf-gdb"
            fi
        ;;
    esac
else
    GDB="$TI_MSP430_GCC_ROOT/bin/msp430-elf-gdb"
fi

# Run GDB with all arguments passed into this script
"$GDB" "$@"
