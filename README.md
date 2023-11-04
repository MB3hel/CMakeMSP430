# Example CMake Project for MSP430

This example is setup for a G2553 launchpad (newer version with ez-FET debugger).

## Required Software

- Uses MSP430 GCC (not TI compiler!)
    - Install from [TI's Site](https://www.ti.com/tool/MSP430-GCC-OPENSOURCE)
    - Install to default location (use installer not toolchain only archives as the support files are needed too).
    - Do not use Linux system packages (these are typically the older non-elf toolchain which is gcc 4.6). The newer elf toolchain is needed!
- Requires CMake 3.20 or newer (necessary because cmake preset are used)
- Requires ninja build system installed
- Flashing and debugging requires [mspdebug](https://github.com/dlbeer/mspdebug) (build from source and make sure it's in your path). Some linux distros may have packages.
- Flashing and debugging may require [MSP Debug Stack USB Drivers Package](https://www.ti.com/tool/MSPDS)


## Building

```sh
cmake --preset default
cmake --build --preset [debug/release]
```

## Flashing

```sh
# TODO
```


## Debugging

TODO
