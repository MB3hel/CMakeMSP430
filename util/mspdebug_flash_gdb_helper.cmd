@echo off
setlocal

:: Get path to gdb the same way toolchain file gets path for compiler
IF DEFINED MSPDEBUG_ROOT (
    set MSPDEBUG="%MSPDEBUG_ROOT%\mspdebug.exe"
) ELSE (
     set MSPDEBUG="C:\ti\mspdebug\mspdebug.exe"
)

:: First arg to this script is the elf file name
:: Change extension from elf to hex
:: Then program the hex and run gdb
:: VSCode can't subtitute elf for hex, so can't do this directly in IDE
set ELFFILE=%1
set FILE=%ELFFILE:~0,-4%
"%MSPDEBUG%" --allow-fw-update tilib --force-reset "prog %FILE%.hex" "gdb"
