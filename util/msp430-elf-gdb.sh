#!/usr/bin/env sh

# Get path to gdb the same way toolchain file gets path for compiler
if [ -z "$TI_MSP430_GCC_ROOT" ]; then
    GDB="/opt/ti/msp430-gcc/bin/msp430-elf-gdb"
else
    uanme_s="$(uname -s)"
    case "${unameOut}" in
        Darwin*) GDB="/opt/ti/msp430-gcc/bin/msp430-elf-gdb" ;;
        *) GDB="/Applications/ti/msp430-gcc/bin/msp430-elf-gdb" ;;
    esac
fi

# Run GDB with all arguments passed into this script
"$GDB" "$@"
