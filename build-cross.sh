#!/usr/bin/env bash
# Get target
read -p "Enter target architecture: " arch
# Export compiler parameters
export PREFIX="$HOME/Applications/Panix"
export TARGET=${arch}
export PATH="$PREFIX/bin:$PATH"

read -p "Update binutils? (y/n) " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    # Get binutils
    echo
    read -p "Enter Binutils version: " binver
    # Check if tarball exists
    if [ ! -d binutils-${binver} ]; then
        tarbin="https://ftp.gnu.org/pub/gnu/binutils/binutils-${binver}.tar.gz"
        wget $tarbin
        tar -xf *.tar.gz
    fi
    # Make binutils
    mkdir build-binutils
    cd build-binutils
    ../binutils-${binver}/configure --target=$TARGET --prefix="$PREFIX" --with-sysroot --disable-nls --disable-werror
    make -j$(nproc)
    make install
    cd ..
fi
echo
read -p "Update GCC? (y/n) " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    # Get GCC
    echo
    read -p "Enter GCC version: " gccver
    # Check if tarball exists
    if [ ! -d gcc-${gccver} ]; then
        targcc="https://ftp.gnu.org/gnu/gcc/gcc-10.2.0/gcc-${gccver}.tar.gz"
        wget $targcc
        tar -xf *.tar.gz
    fi
    # Make GCC
    mkdir build-gcc
    cd build-gcc
    ../gcc-${gccver}/configure --target=$TARGET --prefix="$PREFIX" --disable-nls --enable-languages=c,c++ --without-headers
    make -j$(nproc) all-gcc
    make -j$(nproc) all-target-libgcc
    make -j$(nproc) install-gcc
    make -j$(nproc) install-target-libgcc
    cd ..
fi
# Cleanup
rm -rf build-gcc
rm -rf build-binutils