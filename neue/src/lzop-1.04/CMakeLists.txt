#
# CMakeLists.txt --- a "CMake" file for building lzop
#
# This file is part of the lzop file compressor.
#   http://www.oberhumer.com/opensource/lzop/
#
# Copyright (C) 1996-2017 Markus Franz Xaver Johannes Oberhumer
# All Rights Reserved.
#

cmake_minimum_required(VERSION 3.0 FATAL_ERROR)

#
# simple usage example (Unix):
#     mkdir -p build && cd build && cmake .. && make
#
# simple usage example (Windows MSVC):
#     md build
#     cd build
#     cmake .. -G "NMake Makefiles"
#     nmake
#
# another usage example (Unix):
#     mkdir -p build/release-i686
#     cd       build/release-i686
#     cmake ../.. \
#         -DCMAKE_C_COMPILER=gcc -DCMAKE_C_FLAGS="-m32 -march=i686" \
#         -DCMAKE_INSTALL_PREFIX=/opt/local/prefix-i686
#     make VERBOSE=1
#     make install
#
# see http://www.cmake.org/ for more info
#

# /***********************************************************************
# // init
# ************************************************************************/

# Disallow in-source builds. Note that you will still have to manually
# clean up a few files if you accidentally try an in-source build.
set(CMAKE_DISABLE_IN_SOURCE_BUILD ON)
set(CMAKE_DISABLE_SOURCE_CHANGES  ON)
if(",${CMAKE_SOURCE_DIR}," STREQUAL ",${CMAKE_BINARY_DIR},")
    message(FATAL_ERROR "ERROR: In-source builds are not allowed.")
endif()

if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE "Release" CACHE STRING "" FORCE)
endif()

project(lzop VERSION 1.04 LANGUAGES C)

# install directories
if(NOT CMAKE_INSTALL_PREFIX)
    message(FATAL_ERROR "ERROR: CMAKE_INSTALL_PREFIX is not defined.")
endif()
include(GNUInstallDirs)

# FindLZO
include(FindPkgConfig QUIET)
pkg_check_modules(LZO lzo2)
if(NOT LZO_INCLUDE_DIRS)
    #set(LZO_INCLUDE_DIRS /usr/local/include)
endif()
if(NOT LZO_LIBRARIES)
    set(LZO_LIBRARIES lzo2)
endif()

# /***********************************************************************
# // targets
# ************************************************************************/

file(GLOB lzop_SOURCES "${CMAKE_CURRENT_SOURCE_DIR}/src/*.c")
list(SORT lzop_SOURCES)

add_executable(lzop ${lzop_SOURCES})
target_include_directories(lzop PRIVATE ${LZO_INCLUDE_DIRS})
target_link_libraries(lzop ${LZO_LIBRARIES})

# /***********************************************************************
# // compilation flags
# // this section currently mostly matches the Autoconf version
# ************************************************************************/

include(CheckFunctionExists)
include(CheckIncludeFile)
include(CheckLibraryExists)
include(CheckSymbolExists)
include(CheckTypeSize)
include(TestBigEndian)

if(MSVC)
    # disable silly warnings about using "deprecated" POSIX functions like fopen()
    add_definitions(-D_CRT_NONSTDC_NO_DEPRECATE)
    add_definitions(-D_CRT_NONSTDC_NO_WARNINGS)
    add_definitions(-D_CRT_SECURE_NO_DEPRECATE)
    add_definitions(-D_CRT_SECURE_NO_WARNINGS)
endif()

# Checks for header files
macro(mfx_check_include_file f var)
    check_include_file("${f}" "mfx_${var}")
    if(NOT ",${mfx_${var}}," STREQUAL ",,")
        add_definitions(-D${var}=1)
        set(mfx_${var} 1)
    else()
        set(mfx_${var} 0)
    endif()
endmacro()
# mfx_ACC_CHECK_HEADERS
set(l assert.h ctype.h dirent.h errno.h fcntl.h float.h limits.h malloc.h memory.h setjmp.h signal.h stdarg.h stddef.h stdint.h stdio.h stdlib.h string.h strings.h time.h unistd.h utime.h sys/mman.h sys/resource.h sys/stat.h sys/time.h sys/types.h sys/wait.h)
foreach(f ${l})
    string(TOUPPER "${f}" var)
    string(REGEX REPLACE "[^0-9A-Z_]" "_" var "${var}")
    mfx_check_include_file("${f}" "HAVE_${var}")
endforeach()

# Checks for typedefs and structures
macro(mfx_check_type_size type var)
    check_type_size("${type}" "mfx_${var}")
    if("${mfx_${var}}" MATCHES "^[1-9][0-9]*$")
        add_definitions(-D${var}=${mfx_${var}})
    else()
        set(mfx_${var} 0)
    endif()
endmacro()
# mfx_ACC_CHECK_SIZEOF + mfx_CHECK_SIZEOF
set(l short int long "long long" __int16 __int32 __int64 "void *" size_t ptrdiff_t intmax_t uintmax_t intptr_t uintptr_t float double "long double" dev_t fpos_t mode_t off_t ssize_t time_t)
foreach(f ${l})
    string(TOUPPER "${f}" var)
    string(REGEX REPLACE " \\*" "_P" var "${var}")
    string(REGEX REPLACE "[^0-9A-Z_]" "_" var "${var}")
    mfx_check_type_size("${f}" "SIZEOF_${var}")
endforeach()

# Checks for library functions
macro(mfx_check_function_exists func var)
    check_function_exists("${func}" "mfx_${var}")
    if(NOT ",${mfx_${var}}," STREQUAL ",,")
        add_definitions(-D${var}=1)
        set(mfx_${var} 1)
    else()
        set(mfx_${var} 0)
    endif()
endmacro()
# mfx_ACC_CHECK_FUNCS
set(l access alloca atexit atoi atol chmod chown clock_getcpuclockid clock_getres clock_gettime ctime difftime fstat getenv getpagesize getrusage gettimeofday gmtime isatty localtime longjmp lstat memcmp memcpy memmove memset mkdir mktime mmap mprotect munmap qsort raise rmdir setjmp signal snprintf strcasecmp strchr strdup strerror strftime stricmp strncasecmp strnicmp strrchr strstr time umask utime vsnprintf)
foreach(f ${l})
    string(TOUPPER "${f}" var)
    string(REGEX REPLACE "[^0-9A-Z_]" "_" var "${var}")
    mfx_check_function_exists("${f}" "HAVE_${var}")
endforeach()

# mfx_ACC_CHECK_ENDIAN
TEST_BIG_ENDIAN(big_endian)
if ("${big_endian}" MATCHES "^1$")
    add_definitions(-DACC_ABI_BIG_ENDIAN=1)
elseif ("${big_endian}" MATCHES "^0$")
    add_definitions(-DACC_ABI_LITTLE_ENDIAN=1)
else()
    message(FATAL_ERROR "ERROR: TEST_BIG_ENDIAN failed with result '${big_endian}'.")
endif()

# LZOP_HAVE_CONFIG_H
add_definitions(-DACC_CFG_NO_CONFIG_HEADER=1)

# warnings
foreach(t lzop)
    if(CMAKE_C_COMPILER_ID MATCHES "^(Clang|GNU)$")
        target_compile_options(${t} PRIVATE -Wall -W -Wcast-qual)
    endif()
endforeach()

# /***********************************************************************
# // "make test"
# ************************************************************************/

include(CTest)
add_test(NAME lzoptest-01 COMMAND lzop "${CMAKE_CURRENT_SOURCE_DIR}/COPYING" -o "COPYING.lzo")

# /***********************************************************************
# // "make install"
# ************************************************************************/

if(DEFINED CMAKE_INSTALL_FULL_LIBDIR)

install(TARGETS lzop DESTINATION "${CMAKE_INSTALL_FULL_BINDIR}")

set(f AUTHORS COPYING NEWS README THANKS doc/lzop.html doc/lzop.man doc/lzop.pod doc/lzop.ps doc/lzop.tex doc/lzop.txt)
install(FILES ${f} DESTINATION "${CMAKE_INSTALL_FULL_DOCDIR}")
install(FILES doc/lzop.1 DESTINATION "${CMAKE_INSTALL_FULL_MANDIR}/man1")

endif() # CMAKE_INSTALL_FULL_LIBDIR

if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/CMakeLists.maint.txt")
include("${CMAKE_CURRENT_SOURCE_DIR}/CMakeLists.maint.txt")
endif()

# finally print some info about the build-type
if(CMAKE_CONFIGURATION_TYPES)
message(STATUS "CMAKE_CONFIGURATION_TYPES = ${CMAKE_CONFIGURATION_TYPES}")
endif()
if(CMAKE_BUILD_TYPE)
message(STATUS "CMAKE_BUILD_TYPE = ${CMAKE_BUILD_TYPE}")
endif()

# vim:set ft=cmake ts=4 sw=4 tw=0 et:
