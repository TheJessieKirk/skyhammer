# Skyhammer
Copyright © 2024 Jessie Kirk

**Skyhammer is in an early development stage and should not be used for anything other than tests!**

Skyhammer is a set of compilers and related development tools that enable Raspberry Pi computers to compile code for other systems.

## Project Goals
* Skyhammer must provide a set of cross-platform compilers and tools so developers can easily use their Raspberry Pis to make software for PCs running Linux or Microsoft Windows, and for Apple Macs.
* It must be fully up-to-date and as standalone as possible, able to [eat it's own dog food](https://en.wikipedia.org/wiki/Eating_your_own_dog_food).
* It must be as full-featured as possible ("everything turned on").
* It may support Raspberry Pi brambles in the future.
* Skyhammer may provide support for similar devices to Raspberry Pis.

## Testing
Skyhammer correctly makes software, including itself, on a [Raspberry Pi 4 Model B 8GB](https://www.raspberrypi.com/products/raspberry-pi-4-model-b/).
It successfully creates software that runs natively on Microsoft Windows 10.

## Supported Architectures, Systems and Languages
**Linux for Raspberry Pi (aarch64-unknown-linux-gnu):** Ada, C, C++, D, Fortran, Go, M2, Objective-C, Objective-C++, Rust<br>
**Microsoft Windows for PC (x86_64-w64-mingw32):** Ada, C, C++, D, Fortran, M2, Objective-C, Objective-C++, Rust

## Bundled Tools and Libraries
*Note: Please forgive the [pleonastic acronym redundancies](https://en.wikipedia.org/wiki/RAS_syndrome)*
* [Dmalloc](https://dmalloc.com/) 5.6.5
* [GNU](https://www.gnu.org/) [autoconf](https://www.gnu.org/software/autoconf/) 2.72
* [GNU](https://www.gnu.org/) [automake](https://www.gnu.org/software/automake/) 1.17
* [GNU](https://www.gnu.org/) [bash](https://www.gnu.org/software/bash/) 5.2.32
* [GNU](https://www.gnu.org/) [binutils](https://www.gnu.org/software/binutils/) 2.43.1
* [GNU](https://www.gnu.org/) [bison](https://www.gnu.org/software/bison/) 3.8.2
* [GNU](https://www.gnu.org/) [gcc](https://www.gnu.org/software/gcc/) 14.2.0
* [GNU](https://www.gnu.org/) [gmp](https://gmplib.org/) 6.3.0
* [GNU](https://www.gnu.org/) [m4](https://www.gnu.org/software/m4/) 1.4.19
* [GNU](https://www.gnu.org/) [make](https://www.gnu.org/software/make/) 4.4.1
* [GNU](https://www.gnu.org/) [mpc](https://www.multiprecision.org/) 1.3.1
* [GNU](https://www.gnu.org/) [mpfr](https://www.mpfr.org/) 4.2.1
* [flex](https://github.com/westes/flex) 2.6.4
* [isl](https://libisl.sourceforge.io/) 0.27
* [MinGW-w64](https://www.mingw-w64.org/) 11.0.0
