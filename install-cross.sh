#!/usr/bin/env bash
# Get target
read -p "Enter target architecture: " arch
read -p "Enter install destination: " dest
# Export compiler parameters
export PREFIX=${dest}
export TARGET=${arch}
export PATH="$PREFIX/bin:$PATH"

binutils() {
    # Get binutils
    echo
    read -p "Enter Binutils version: " binver
    # Check if tarball exists
    if [ ! -d binutils-${binver} ]; then
        tarbin="https://ftp.gnu.org/pub/gnu/binutils/binutils-${binver}.tar.gz"
        wget $tarbin
        tar -xf binutils-${binver}.tar.gz
    fi
    # Make binutils
    mkdir build-binutils
    cd build-binutils
    ../binutils-${binver}/configure --target=$TARGET --prefix="$PREFIX" --with-sysroot --disable-nls --disable-werror
    make -j$(nproc)
    make install
    cd ..
}

gcc() {
    # Get GCC
    echo
    read -p "Enter GCC version: " gccver
    # Check if tarball exists
    if [ ! -d gcc-${gccver} ]; then
        targcc="https://ftp.gnu.org/gnu/gcc/gcc-${gccver}/gcc-${gccver}.tar.gz"
        wget $targcc
        tar -xf gcc-${gccver}.tar.gz
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
}

gdb() {
    # Get GDB
    echo
    read -p "Enter GDB version: " gdbver
    # Check if tarball exists
    if [ ! -d gdb-${gdbver} ]; then
        targdb="https://ftp.gnu.org/gnu/gdb/gdb-${gdbver}.tar.gz"
        wget $targdb
        tar -xf gdb-${gdbver}.tar.gz
    fi
    # Make GCC
    mkdir build-gcc
    cd build-gcc
    ../gdb-${gdbver}/configure --target=$TARGET --prefix="$PREFIX"
    make -j$(nproc) all-gdb
    make -j$(nproc) install-gdb
    cd ..
}

read -p "Update binutils? (y/n) " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    binutils
fi
echo
read -p "Update GCC? (y/n) " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    gcc
fi
echo
read -p "Update GDB? (y/n) " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    gdb
fi
# Cleanup
rm -rf build-*
