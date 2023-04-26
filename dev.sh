#!/bin/bash

set -e

cd `dirname "$(readlink -f "$0")"`

PROJECTS_DIR_PATH=$PWD/../..
DATA_DIR_PATH=$PROJECTS_DIR_PATH/paradicms/data/costume-core-template

cd $PROJECTS_DIR_PATH/paradicms/lib/py/ssg

poetry run $PROJECTS_DIR_PATH/airtable-etl-action/action.py \
  --cache-directory-path $DATA_DIR_PATH/cached \
  --loaded-data-directory-path $DATA_DIR_PATH/loaded \
  --pipeline-id costume-core-template \
  "$@"

poetry run $PROJECTS_DIR_PATH/ssg-action/action.py \
  --cache-directory-path $DATA_DIR_PATH/cached \
  --data-path $DATA_DIR_PATH/loaded \
  --dev \
  --pipeline-id costume-core-template
