#!/usr/bin/env bash
# Execute all experiment notebooks in order and regenerate results/.
set -e
cd "$(dirname "$0")/notebooks"
for nb in 01_synthetic_proxy_discrimination \
          02_benchmark_german_credit \
          03_latency_overhead \
          04_sensitivity_analysis \
          05_multimetric_monitoring; do
  echo ">>> Executing ${nb}.ipynb"
  jupyter nbconvert --to notebook --execute --inplace "${nb}.ipynb" \
    --ExecutePreprocessor.timeout=600
done
echo "All experiments complete. See ../results/{figures,tables}."
