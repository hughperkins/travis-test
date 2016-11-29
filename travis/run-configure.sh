#!/bin/bash

set -x

cd ${BASEDIR}/tensorflow

export TF_NEED_GCP=0
export TF_NEED_HDFS=0
export TF_NEED_CUDA=0
export PYTHON_BIN_PATH=/usr/local/bin/python
echo /Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/site-packages | util/python/python_config.sh --setup /Library/Frameworks/Python.framework/Versions/2.7/bin/python
GEN_GIT_SOURCE=tensorflow/tools/git/gen_git_source.py
chmod a+x ${GEN_GIT_SOURCE}
SOURCE_BASE_DIR=${BASEDIR}/tensorflow
echo SOURCE_BASE_DIR ${SOURCE_BASE_DIR}
${PYTHON_BIN_PATH} ${GEN_GIT_SOURCE} --configure ${SOURCE_BASE_DIR}
ls tools
# bazel --batch fetch //tensorflow/...
# bash ${BASEDIR}/travis/upload.sh bazelinstall /private/var/tmp/_bazel_travis
# } fi
