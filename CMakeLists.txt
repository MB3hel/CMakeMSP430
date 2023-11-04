cmake_minimum_required(VERSION 3.20.0)
project(BlinkDemo C)

################################################################################
# Firmware build
################################################################################
set(TARGET_CHIP g2553)
string(TOUPPER "${TARGET_CHIP}" TARGET_CHIP_UPPER)
file(GLOB_RECURSE SOURCES 
    "${PROJECT_SOURCE_DIR}/src/*.c"
)
set(INCLUDES
    "${MSP430_GCC_PATH}/include"
    "${PROJECT_SOURCE_DIR}/include"
)
set(DEFINES
    __MSP430${TARGET_CHIP_UPPER}__
)
set(SHARED_FLAGS
    -mmcu=msp430${TARGET_CHIP}
    -fno-exceptions

    # Not needed for G2553 chip
    # -msmall or -mlarge
    # -mhwmult=auto
)
set(CFLAGS
    -Wall
    -Wextra
    -ffunction-sections
    -fdata-sections
    -MMD
)
set(LDFLAGS
    -L${MSP430_GCC_PATH}/include/
    -Tmsp430${TARGET_CHIP}.ld
    -Wl,--gc-sections,-u,main
)
add_executable(${CMAKE_PROJECT_NAME} ${SOURCES})
set_property(TARGET ${CMAKE_PROJECT_NAME} PROPERTY C_STANDARD 11)
set_property(TARGET ${CMAKE_PROJECT_NAME} PROPERTY C_STANDARD_REQUIRED ON)
target_include_directories(${CMAKE_PROJECT_NAME} PUBLIC ${INCLUDES})
target_compile_definitions(${CMAKE_PROJECT_NAME} PUBLIC ${DEFINES})
target_compile_options(${CMAKE_PROJECT_NAME} PUBLIC ${SHARED_FLAGS} ${CFLAGS})
target_link_options(${CMAKE_PROJECT_NAME} PUBLIC ${SHARED_FLAGS} ${LDFLAGS})
add_custom_command(TARGET ${CMAKE_PROJECT_NAME}  POST_BUILD
    COMMAND ${CMAKE_OBJCOPY} ARGS -O ihex "$<OUTPUT_CONFIG:$<CONFIG>>/${CMAKE_PROJECT_NAME}.elf" "$<OUTPUT_CONFIG:$<CONFIG>>/${CMAKE_PROJECT_NAME}.hex"
)
################################################################################

################################################################################
# Flash target
################################################################################
add_custom_target(flash-debug
    COMMAND mspdebug --allow-fw-update tilib --force-reset "prog ${CMAKE_BINARY_DIR}/Debug/${CMAKE_PROJECT_NAME}.hex" "verify ${CMAKE_BINARY_DIR}/Debug/${CMAKE_PROJECT_NAME}.hex"
)
################################################################################
