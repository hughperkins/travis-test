#!/bin/bash

~/Library/Python/2.7/bin/aws s3 ls s3://hughperkinstravis
CACHE_COUNT=$(~/Library/Python/2.7/bin/aws s3 ls s3://hughperkinstravis/cache/travis-test/${TRAVIS_BRANCH}/bazel.tar.bz2 | wc -l)
echo CACHE_COUNT ${CACHE_COUNT}
if [[ ${CACHE_COUNT} != 0 ]]; then {
    mkdir -p ~/.cache/bazel
    cd ~/.cache/bazel
    ~/Library/Python/2.7/bin/aws s3 cp s3://hughperkinstravis/cache/travis-test/${TRAVIS_BRANCH}/bazel.tar.bz2 bazel.tar.bz2
    tar -xf bazel.tar.bz2
    ls
} fi
