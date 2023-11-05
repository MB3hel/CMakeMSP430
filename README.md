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
        - macOS: TODO
        - Linux: `/opt/ti/` (you'll need to do this as root)
- Note that if you install mspdebug or MSP430 GCC to different locations, you can use the `TI_MSP430_GCC_ROOT` and `MSPDEBUG_ROOT` environment variables. If installing MSP430 GCC with the archives (not installers), you also have to install the support files under `include/`.


## Build System Overview

TODO


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
