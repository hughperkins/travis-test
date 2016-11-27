#!/bin/bash

set -x

CACHE_NAME=$1
CACHED_PATH=$2

PATH=~/Library/Python/2.7/bin:$PATH
S3_CACHE_DIR=s3://${TRAVIS_BUCKET}/cache/travis-test/${TRAVIS_BRANCH}

time aws s3 cp ${S3_CACHE_DIR}/${CACHE_NAME}.tar.bz2 /tmp/${CACHE_NAME}.tar.bz2 || exit 0
mkdir -p ${CACHED_PATH}
cd ${CACHED_PATH}
time tar -xf /tmp/${CACHE_NAME}.tar.bz2
ls
# } fi
