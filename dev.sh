#!/bin/bash

set -e

cd `dirname "$(readlink -f "$0")"`

PROJECTS_DIR_PATH=$PWD/../..
DATA_DIR_PATH=$PROJECTS_DIR_PATH/paradicms/data/costume_core_template

cd $PROJECTS_DIR_PATH/paradicms/lib/py/ssg

poetry run $PROJECTS_DIR_PATH/airtable-etl-action/action.py \
  --cache-directory-path $DATA_DIR_PATH/cache \
  --loaded-data-directory-path $DATA_DIR_PATH/loaded \
  --pipeline-id costume_core_template \
  "$@"

poetry run $PROJECTS_DIR_PATH/ssg-action/action.py \
  --cache-directory-path $DATA_DIR_PATH/cache \
  --data-path $DATA_DIR_PATH/loaded \
  --dev \
  --pipeline-id costume_core_template
