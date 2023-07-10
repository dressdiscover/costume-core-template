#!/bin/bash

set -e

cd `dirname "$(readlink -f "$0")"`

THIS_DIR_PATH=$PWD
CACHE_DIR_PATH=$THIS_DIR_PATH/.paradicms/cache
DATA_DIR_PATH=$THIS_DIR_PATH/.paradicms/data
PROJECTS_DIR_PATH=$PWD/../..

cd $PROJECTS_DIR_PATH/paradicms/lib/py/ssg

poetry run $PROJECTS_DIR_PATH/airtable-etl-action/action.py \
  --cache-directory-path $PROJECTS_DIR_PATH/paradicms/data \
  --loaded-data-directory-path $DATA_DIR_PATH \
  --pipeline-id costume_core_template \
  "$@"

poetry run $PROJECTS_DIR_PATH/ssg-action/action.py \
  --cache-directory-path $CACHE_DIR_PATH \
  --data-path $DATA_DIR_PATH \
  --dev \
  --pipeline-id costume_core_template
