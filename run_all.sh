#!/usr/bin/env bash
# Execute every experiment notebook in order, in place.
set -e
for nb in notebooks/0*.ipynb; do
  echo "Running ${nb} ..."
  jupyter nbconvert --to notebook --execute --inplace "${nb}"
done
echo "All notebooks executed."
