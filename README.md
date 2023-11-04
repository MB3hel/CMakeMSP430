# Example CMake Project for MSP430

This example is setup for a G2553 launchpad (newer version with ez-FET debugger).

## Required Software

- Uses MSP430 GCC (not TI compiler!)
    - Install from [TI's Site](https://www.ti.com/tool/MSP430-GCC-OPENSOURCE)
    - Install to default location (use installer not toolchain only archives as the support files are needed too).
    - Do not use Linux system packages (these are typically the older non-elf toolchain which is gcc 4.6). The newer elf toolchain is needed!
- Requires CMake
- Requires ninja build system installed
- Flashing and debugging requires [mspdebug](https://github.com/dlbeer/mspdebug)
    - Download one the pre-built archives from release section of this repo (TODO)
    - Extract to one of the following locations based on your OS
        - Windows: `C:\ti\`
        - macOS: TODO
        - Linux: `/opt/ti/` (you'll need to do this as root)


## VSCode Build, Flash, Debug

Note: you need the C/C++ extension.

TODO: Document this.



## Command Line Build, Flash, Debug

### Configuring

Must run before build, flash, or debug.

```sh
# Note: If on windows, use rmdir /s build instead of rm -rf build/
rm -rf build
mkdir build
cd build
cmake .. -DCMAKE_TOOLCHAIN_FILE=../msp430-gcc-toolchain.cmake -DCMAKE_BUILD_TYPE=[TYPE]
```

Replace `[TYPE]` with one of 

- `Debug`: No optimization and includes debug symbols.
- `Release`: Optimized for speed. No debug symbols.
- `MinSizeRel`: Optimized for size. No debug symbols.
- `RelWithDebInfo`: Optimized for speed, but includes debug info.

### Building

```sh
# Run in build/ folder
cmake --build .
```

### Flashing

Make sure only one MSP430 ez-FET is connected. Then run the following command.

```sh
# Run in build/ folder
cmake --build . --target flash
```


### Debugging

TODO
