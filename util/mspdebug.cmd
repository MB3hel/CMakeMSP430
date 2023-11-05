@echo off
setlocal

:: Get path to gdb the same way toolchain file gets path for compiler
IF DEFINED MSPDEBUG_ROOT (
    set MSPDEBUG="%MSPDEBUG_ROOT%\mspdebug.exe"
) ELSE (
     set MSPDEBUG="C:\ti\mspdebug\mspdebug.exe"
)

:: Run GDB with all arguments passed into this script
"%MSPDEBUG%" %*

:: Exit with error code from GDB
EXIT /B %ERRORLEVEL%