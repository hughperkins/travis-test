#!/bin/bash

# swig -python -module swiglib1 -c++ swiglib1.cpp
# swig -python -module swiglib1 -c++ swiglib1.i
# g++ -I/usr/include/python3.5 -c -fPIC -shared -o swiglib1_wrap.o swiglib1_wrap.cxx
# g++ -c -fPIC -shared -o swiglib1.o swiglib1.cpp
# g++ -shared -pie -o _swiglib1.so swiglib1.o swiglib1_wrap.o

set -e
set -x

rm -Rf build || true
mkdir build
cd build
cmake ..
make -j 4
# cd ..

python3 -c 'import swiglib1; swiglib1.foo()'
