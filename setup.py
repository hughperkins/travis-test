from __future__ import print_function
import os
import os.path
import sys
import platform
from setuptools import setup
from setuptools import Extension

compile_options = []
osfamily = platform.uname()[0]

# compile_options.append('-mmacosx-version-min=10.7')
# compile_options.append('-stdlib=libc++')

if osfamily in ['Linux', 'Darwin']:
    compile_options.append('-g')
    compile_options.append('-Wno-unused-function')
    compile_options.append('-Wno-unneeded-internal-declaration')
    compile_options.append('-Wno-strict-prototypes')

include_dirs = []

runtime_library_dirs = []
libraries = []

library_dirs = []

if osfamily == 'Linux':
    runtime_library_dirs = ['.']

if osfamily == 'Windows':
    libraries.append('winmm')

sources = ["test.cpp"]
ext_modules = [
    Extension("travistest",
              sources=sources,
              include_dirs=include_dirs,
              library_dirs=library_dirs,
              libraries=libraries,
              extra_compile_args=compile_options,
              runtime_library_dirs=runtime_library_dirs,
              language="c++")]


version = '0.1'

setup(
    name='travistest',
    version=version,
    author="Hugh Perkins",
    author_email="hughperkins@gmail.com",
    description=(
        'test travis build'),
    license='BSD2',
    url='https://github.com/hughperkins/travis-test',
    long_description='travis test',
    classifiers=[
    ],
    install_requires=[],
    scripts=[],
    ext_modules=ext_modules,
)

