#!/bin/bash
#
# Careful - this script rebases and pushes forcefully!
#

UPLOAD_DIR=$1
OVERWRITE_UPLOAD_BRANCH=master
WORKDIR=`pwd`
TMPDIR=`mkdtemp -d`
GITHUB_USER=bjodah
GITHUB_REPO=bjodah.github.io
cd $TMPDIR
git config --global user.name "drone"
git config --global user.email "drone@hera.physchem.kth.se"
git clone --quiet git@github.com:/${GITHUB_USER}/${GITHUB_REPO} > /dev/null
cd ${GITHUB_REPO}
git branch -D $OVERWRITE_UPLOAD_BRANCH
git checkout --orphan $OVERWRITE_UPLOAD_BRANCH
git rm -rf . > /dev/null
cp -r ${UPLOAD_DIR}/* .
git add -f . > /dev/null
git commit -m "Lastest docs from successful drone build (hash: ${DRONE_COMMIT})"
git push -f origin $OVERWRITE_UPLOAD_BRANCH
