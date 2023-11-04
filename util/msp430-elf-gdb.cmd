@echo off
setlocal

:: Get path to gdb the same way toolchain file gets path for compiler
IF DEFINED TI_MSP430_GCC_ROOT (
    set GDB="%TI_MSP430_GCC_ROOT%\msp430-elf-gdb.exe"
) ELSE (
     set GDB="C:\ti\msp430-gcc\bin\msp430-elf-gdb.exe"
)

:: Run GDB with all arguments passed into this script
"%GDB%" %*

:: Exit with error code from GDB
EXIT /B %ERRORLEVEL%