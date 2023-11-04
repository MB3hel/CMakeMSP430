if(CMAKE_HOST_WIN32)
    set(MSP430_GCC_PATH "C:/ti/msp430-gcc")
    set(MSPDEBUG_PATH "C:/ti/mspdebug")
elseif(CMAKE_HOST_APPLE)
    # TODO: Path for macos?
else()
    set(MSP430_GCC_PATH "/opt/ti/msp430-gcc")
    set(MSPDEBUG_PATH "/opt/ti/mspdebug")
endif()

set(CMAKE_SYSTEM_NAME               Generic)
set(CMAKE_SYSTEM_PROCESSOR          msp430)
set(CMAKE_CROSSCOMPILING 1)

set(TOOLCHAIN_PREFIX                ${MSP430_GCC_PATH}/bin/msp430-elf-)
set(CMAKE_C_COMPILER                ${TOOLCHAIN_PREFIX}gcc CACHE FILEPATH "C Compiler path")
set(CMAKE_ASM_COMPILER              ${CMAKE_C_COMPILER} CACHE FILEPATH "ASM Compiler path")
set(CMAKE_CXX_COMPILER              ${TOOLCHAIN_PREFIX}g++ CACHE FILEPATH "C++ Compiler path")
set(CMAKE_AR                        ${TOOLCHAIN_PREFIX}ar CACHE FILEPATH "AR path")
set(CMAKE_RANLIB                    ${TOOLCHAIN_PREFIX}ranlib CACHE FILEPATH "RANLIB path")
set(CMAKE_OBJCOPY                   ${TOOLCHAIN_PREFIX}objcopy CACHE FILEPATH "OBJCOPY path")
set(CMAKE_SIZE                      ${TOOLCHAIN_PREFIX}size CACHE FILEPATH "SIZE path")

set(MSPDEBUG_BINARY                 ${MSPDEBUG_PATH}/mspdebug CACHE FILEPATH "MSPDEBUG path")

set(CMAKE_EXECUTABLE_SUFFIX_ASM     ".elf")
set(CMAKE_EXECUTABLE_SUFFIX_C       ".elf")
set(CMAKE_EXECUTABLE_SUFFIX_CXX     ".elf")

set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)