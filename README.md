# Example CMake Project for MSP430

This example is setup for a G2553 launchpad (newer version with ez-FET debugger).

## Required Software

- Uses MSP430 GCC (not TI compiler!)
    - Install from [TI's Site](https://www.ti.com/tool/MSP430-GCC-OPENSOURCE)
    - Install to default location (use installer not toolchain only archives as the support files are needed too).
    - Do not use Linux system packages (these are typically the older non-elf toolchain which is gcc 4.6). The newer elf toolchain is needed!
- Requires CMake 3.20 or newer
- Requires ninja build system installed and in your path
- Flashing and debugging requires [mspdebug](https://github.com/dlbeer/mspdebug)
    - Download one the pre-built archives from release section of this repo (TODO)
    - Extract to one of the following locations based on your OS
        - Windows: `C:\ti\`
        - macOS: `/Applications/ti`
        - Linux: `/opt/ti/` (you'll need to do this as root)
- Note that if you install mspdebug or MSP430 GCC to different locations, you can use the `TI_MSP430_GCC_ROOT` and `MSPDEBUG_ROOT` environment variables. If installing MSP430 GCC with the archives (not installers), you also have to install the support files under `include/`.


## Build System Overview

- CMake is used as a build system
    - The `msp430-gcc-toolchain.cmake` toolchain file searches for the msp430 gcc toolchain at default installation locations for the OS. If the `TI_MSP430_GCC_ROOT` environment variable is set, this is used as the location of the toolchain instead.
    - The CMake build system uses presets (see `CMakePresets.json` file). In this file a configuration preset is defined for each supported chip. Four build presets (debug, release, minsizerel, relwithdebinfo) are defined for each configuration preset.
    - This preset structure allows easily supporting multiple chips and supporting multiple build configurations
    - Note that the ninja build system is used as this supports multi config setups with cmake.
    - Aside from presets defining target chip, the rest of build configuration is handled in `CMakeLists.txt` including chip specific arguments.
- The CMake system also defines various helper targets (`gdb`, `flash`, and `mspdebug-server`)
    - These helper targets allow the build system to handle paths to the binaries for the selected build configuration.
    - `flash`: used to flash the selected build configuration's binary
    - `mspdebug-server`: used to flash the selected build configuration's binary then start a gdb server for gdb to connect to
    - `gdb`: used to launch the debugger with the selected build configuration's binary. Must launch `mspdebug-server` first.
- Various util scripts are provided for windows cmd and unix style shells.
    - `msp430-elf-gdb / mspdebug`: These scripts search the same way for `msp430-elf-gdb` and `mspdebug` (search the default locations described in required tools section or use `TI_MSP430_GCC_ROOT` / `MSPDEBUG_ROOT` environment variables if defined). These are used by cmake build system to invoke these tools.
    - `mspdebug_flash_gdb_helper`: Can be used by IDEs to flash the binary and launch the `mspdebug` gdb server. Necessary because most IDEs are not aware of the `hex` file output, but only the `elf` which `mspdebug` cannot use.
- VSCode tasks and launch file provided to allow flashing & debugging in VSCode
    - Flash simply invokes cmake build for flash target of the selected configuration
    - Debug uses the `mspdebug_flash_gdb_helper` script to flash & start the gdb server. The it uses the `msp430-elf-gdb` script to launch the debugger.



## VSCode Build, Flash, Debug

Note: you need the C/C++ extension and CMake tools extension installed in VSCode.

### Configure

On the bottom toolbar, choose a configure preset (eg MSP430G2553). Also choose a build preset (usually named "Debug", "Release", "MinSizeRel", and "RelWithDebInfo").


### Build

Click the Build button on the bottom toolbar. This will build the selected configuration.


### Flash

- Press Ctrl+P (cmd+P on mac)
- Search for `Tasks: Run Task`
- Choose the task named `Flash`


### Debug

*Note: Debugging will flash too!*

In the left panel, choose the "Run and Debug" section. Choose "Launch via GDB" in the dropdown and click the run button.


## Command Line Build, Flash, Debug

### Configure

Must run before build, flash, or debug. Choose the preset based on the target chip.

```sh
cmake --preset g2553
```

### Build

Run the following command to build a debug, release, MinSizeRel, or RelWithDebInfo configuration. Change the first part (`g2553`) based on target chip.

```sh
cmake --build --preset g2553-[debug/release/minsizerel/relwithdebinfo]
```

### Flash

Make sure only one MSP430 ez-FET is connected. Then run the following command to flash for the given configuration.

```sh
cmake --build --preset g2553-[debug/release/minsizerel/relwithdebinfo] --target flash
```


### Debug

*Note: Debugging will flash too!*

Flash firmware for the given configuration and start gdb server

```sh
cmake --build --preset g2553-[debug/release/minsizerel/relwithdebinfo] --target mspdebug-server
```

Leave the debug server running. Then, in another terminal run the following. Use the same preset. Then use gdb as normal.

```sh
cmake --build --preset g2553-[debug/release/minsizerel/relwithdebinfo] --target gdb
```
