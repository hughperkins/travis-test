#!/bin/bash

cd ~/.cache/bazel
touch bazel.tar.bz2
rm bazel.tar.bz2
tar -cjf bazel.tar.bz2 *
ls -lh
~/Library/Python/2.7/bin/aws s3 cp bazel.tar.bz2 s3://hughperkinstravis/cache/travis-test/${TRAVIS_BRANCH}/bazel.tar.bz2
