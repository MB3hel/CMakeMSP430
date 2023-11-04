# Example CMake Project for MSP430

This example is setup for a G2553 launchpad (newer version with ez-FET debugger).

## Required Software

- Uses MSP430 GCC (not TI compiler!)
    - Install from [TI's Site](https://www.ti.com/tool/MSP430-GCC-OPENSOURCE)
    - Install to default location (use installer not toolchain only archives as the support files are needed too).
    - Do not use Linux system packages (these are typically the older non-elf toolchain which is gcc 4.6). The newer elf toolchain is needed!
- Requires CMake 3.20 or newer (necessary because cmake preset are used)
- Requires ninja build system installed
- Flashing and debugging requires [mspdebug](https://github.com/dlbeer/mspdebug)
    - Download the pre-built package from release section of this repo
    - Extract to one of the following locations based on your OS
        - Windows: `C:\ti\`
        - macOS: TODO
        - Linux: `/opt/ti/` (you'll need to do this as root)


## Building

```sh
cmake --preset default
cmake --build --preset [debug/release]
```

## Flashing

Make sure only one MSP430 ez-FET is connected. Then run the following command.

```sh
cmake --preset default
cmake --build build --target flash-[debug/release]
```


## Debugging

TODO
