#!/bin/bash

CACHE_NAME=$1
CACHED_PATH=$2

# BASEL_CACHE=/private/var/tmp/_bazel_travis
PATH=~/Library/Python/2.7/bin:$PATH
S3_CACHE_DIR=s3://hughperkinstravis/cache/travis-test/${TRAVIS_BRANCH}

cd ${CACHED_PATH}
touch ${CACHE_NAME}.tar.bz2
rm ${CACHE_NAME}.tar.bz2
time tar -cjf ${CACHE_NAME}.tar.bz2 *
ls -lh
time aws s3 cp ${CACHE_NAME}.tar.bz2 ${S3_CACHE_DIR}/${CACHE_NAME}.tar.bz2
