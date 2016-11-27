#!/bin/bash

BASEL_CACHE=/private/var/tmp/_bazel_travis
PATH=~/Library/Python/2.7/bin:$PATH
S3_CACHE_DIR=s3://hughperkinstravis/cache/travis-test/${TRAVIS_BRANCH}

cd ${BASEL_CACHE}
touch bazel.tar.bz2
rm bazel.tar.bz2
tar -cjf bazel.tar.bz2 *
ls -lh
aws s3 cp bazel.tar.bz2 ${S3_CACHE_DIR}/bazel.tar.bz2
