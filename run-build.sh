#!/bin/bash

plat=hifive
clean=true
compiler_prefix=1
binary_format="64"

usage () {
    echo "Usage for $0:"
    echo "  -p : Platform"
    echo "  -b : binary to build? [default: 64]"
    echo "       [32] 32 bit"
    echo "       [64] 64 bit"
    echo "  -c : clean?"
    echo "  -C : compiler prefix [defualt:1]"
    echo "       [1] riscvNN-unknown-linux-gnu-"
    echo "       [2] "
    echo "       [3] "
}

while getopts "p:cC:hb:" arg; do
    case $arg in
        p) plat=$OPTARG;;
        c) clean=true;;
        C) compiler_prefix=$OPTARG;;
        b) binary_format=$OPTARG;;
        h) usage
           exit 0;;
    esac
done

case $compiler_prefix in
    1) COMPILER_PREFIX="riscv${binary_format}-unknown-linux-gnu-";;
    2) COMPILER_PREFIX="unknown";;
    3) COMPILER_PREFIX="unknown";;
esac

if ! [ -v plat ]; then
    echo "Error: Provide a platform with -p "
    echo "plat: $plat"
    exit 1
fi

BUILD_DIR=./riscv-build-$plat-$binary_format
if [[ -v clean ]] && [[ -d $BUILD_DIR ]]; then
    echo "Cleaning Previous Build ..."
    rm -rf $BUILD_DIR
elif [[ -d $BUILD_DIR ]]; then
    echo "Build directory exists but is not being cleaned ...."
fi

if ! [[ -d $BUILD_DIR ]]; then
    echo "Making Build Directory ..."
    mkdir -p $BUILD_DIR
fi

cd $BUILD_DIR
build_args="-DPLATFORM=$plat "
build_args+="-DSIMULATION=FALSE "
build_args+="-DCROSS_COMPILER_PREFIX=$COMPILER_PREFIX "
build_args+="-DElfloaderImage=elf "
build_args+="-DLibSel4PlatSupportUseDebugPutChar=OFF "
build_args+="-DSel4testAllowSettingsOverride=True "
build_args+="-DCMAKE_BUILD_TYPE=Debug "
build_args+="-DRELEASE=False "
if [ "$binary_format" = "32" ]; then
    build_args+="-DRISCV32=TRUE "
else
    build_args+="-DRISCV64=TRUE "
fi

../init-build.sh $build_args || echo "failed initializing build environment"
echo "======================================================================"
echo "INIT BUILD ARGS: $build_args"
echo "======================================================================"
ninja || echo "failed ninja"
