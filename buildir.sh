#!/bin/bash

set -x
set -e

LLVM_LINK_FLAGS=`${CLANG_HOME}/bin/llvm-config --ldflags --system-libs --libs all`
LLVM_COMPILE_FLAGS=`${CLANG_HOME}/bin/llvm-config --cppflags --cxxflags | sed -e 's/ -fno-exceptions/ -fexceptions/g' -e 's/ -DNDEBUG//g' -e 's/ -std=c++0x/ -std=c++11/g' -e 's% -isysroot [^ ]*%%g'`
echo LLVM_LINK_FLAGS ${LLVM_LINK_FLAGS}

export ADDFLAGS=
export NATIVE_COMPILER=g++
case `uname` in
    Darwin)
        ADDFLAGS="-stdlib=libc++"
        NATIVE_COMPILER=clang++
        ;;
    *)
        ;;
esac

${CLANG_HOME}/bin/clang++ -std=c++11 -x cuda --cuda-host-only -emit-llvm -O0 -S \
    -D__STDC_CONSTANT_MACROS  -D__STDC_LIMIT_MACROS \
    ${ADDFLAGS} \
    -I${CLANG_HOME}/include \
    ../testvaluemap.cpp -o testvaluemap-hostraw.ll
# head testvaluemap-hostraw.ll

${CLANG_HOME}/bin/clang++ -std=c++11 -x cuda \
    --cuda-gpu-arch=sm_30 --cuda-device-only -emit-llvm -O0 -S \
    -D__STDC_CONSTANT_MACROS  -D__STDC_LIMIT_MACROS \
    ${ADDFLAGS} \
    -I${CLANG_HOME}/include \
    ../testvaluemap.cpp -o testvaluemap-device.ll
# cat testvaluemap-device.ll

${CLANG_HOME}/bin/clang++ -c -fPIC ${LLVM_COMPILE_FLAGS} -o testvaluemap.o testvaluemap-hostraw.ll

${NATIVE_COMPILER} -pie -o testvaluemap testvaluemap.o ${LLVM_LINK_FLAGS}

ls -l
./testvaluemap

nm testvaluemap.o | grep main
