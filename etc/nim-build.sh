#!/bin/bash
if [ ! -x nim-$BRANCH/bin/nim ]; then
  git clone -b $BRANCH --depth 1 git://github.com/nim-lang/nim nim-$BRANCH/
  cd nim-$BRANCH
  git clone -b $BRANCH --depth 1 git://github.com/nim-lang/csources csources/
  cd csources
  sh build.sh
  cd ..
  rm -rf csources
  bin/nim c koch
  ./koch boot -d:release
else
  cd nim-$BRANCH
  git fetch origin
  if ! git merge FETCH_HEAD | grep "Already up-to-date"; then
    bin/nim c koch
    ./koch boot -d:release
  fi
fi
cd ..
