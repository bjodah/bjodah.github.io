#!/bin/bash
OUTPUTDIR=$1
WORKDIR=`pwd`
TMPDIR=`mkdtemp -d`
GITHUB_USER=bjodah
GITHUB_REPO=bjodah.github.io
cd $TMPDIR
git config --global user.name "drone"
git config --global user.email "drone@hera.physchem.kth.se"
git clone --quiet git@github.com:/${GITHUB_USER}/${GITHUB_REPO} > /dev/null
cd ${GITHUB_REPO}
git branch -D master
git checkout --orphan master
git rm -rf . > /dev/null
cp -R ${WORKDIR}/skeleton/* .
cp ${WORKDIR}/skeleton/.* .
cp -r ${OUTPUTDIR} .
git add -f . > /dev/null
git commit -m "Lastest docs from successful drone build (hash: ${DRONE_COMMIT})"
git push -f origin master
