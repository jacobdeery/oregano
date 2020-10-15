#!/usr/bin/env bash

WORKSPACE_DIR=$(git rev-parse --show-toplevel)
cd "$WORKSPACE_DIR"

FILEPATH=$1
BRANCH1=$(git rev-parse --abbrev-ref HEAD)
BRANCH2=$2
ANCESTOR=$(git merge-base $BRANCH1 $BRANCH2)

git read-tree $ANCESTOR
git checkout-index --prefix=.ancestor- $FILEPATH

git read-tree $BRANCH2
git checkout-index --prefix=.other- $FILEPATH

git read-tree $BRANCH1

git merge-file $FILEPATH .ancestor-$FILEPATH .other-$FILEPATH

rm .ancestor-$FILEPATH .other-$FILEPATH
