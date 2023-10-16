#!/bin/bash

set -e

cd `dirname "$(readlink -f "$0")"`

THIS_DIR_PATH=$PWD
CACHE_DIR_PATH=$THIS_DIR_PATH/.paradicms/cache
DATA_DIR_PATH=$THIS_DIR_PATH/.paradicms/data
PROJECTS_DIR_PATH=$PWD/..

cd $PROJECTS_DIR_PATH/paradicms/lib/py/ssg

poetry run $PROJECTS_DIR_PATH/paradicms-airtable-etl-action/action.py \
  --airtable-base-id appgU92SdGTwPIVNg \
  --cache-directory-path $CACHE_DIR_PATH \
  --loaded-data-directory-path $DATA_DIR_PATH \
  --pipeline-id costume_core_template \
  "$@"

poetry run $PROJECTS_DIR_PATH/paradicms-ssg-action/action.py \
  --cache-directory-path $CACHE_DIR_PATH \
  --data-path $DATA_DIR_PATH \
  --next-commands dev \
  --pipeline-id costume_core_template
