#!/bin/bash

BASEL_CACHE=/private/var/tmp/_bazel_travis
PATH=~/Library/Python/2.7/bin:$PATH
S3_CACHE_DIR=s3://hughperkinstravis/cache/travis-test/${TRAVIS_BRANCH}

aws s3 ls s3://hughperkinstravis
CACHE_COUNT=$(aws s3 ls ${S3_CACHE_DIR}/bazel.tar.bz2 | wc -l)
echo CACHE_COUNT ${CACHE_COUNT}
if [[ ${CACHE_COUNT} != 0 ]]; then {
    mkdir -p ${BASEL_CACHE}
    cd ${BASEL_CACHE}
    aws s3 cp ${S3_CACHE_DIR}/bazel.tar.bz2 bazel.tar.bz2
    tar -xf bazel.tar.bz2
    ls
} fi
