#!/bin/bash

set -x
set -e

${CLANG_HOME}/bin/clang++ -std=c++11 -x cuda \
    --cuda-gpu-arch=sm_30 --cuda-device-only -emit-llvm -O0 -S \
    -D__STDC_CONSTANT_MACROS  -D__STDC_LIMIT_MACROS \
    -I${CLANG_HOME}/include \
    ../testvaluemap.cpp -o testvaluemap-device.ll
cat testvaluemap-device.ll

${CLANG_HOME}/bin/clang++ -std=c++11 -x cuda --cuda-host-only -emit-llvm -O0 -S \
    -D__STDC_CONSTANT_MACROS  -D__STDC_LIMIT_MACROS \
    -I${CLANG_HOME}/include \
    ../testvaluemap.cpp -o testvaluemap-hostraw.ll
head testvaluemap-hostraw.ll
