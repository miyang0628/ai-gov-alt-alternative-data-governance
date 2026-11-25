# Proxy Leakage in Alternative-Data Credit Scoring

Replication code for the manuscript *"Proxy Discrimination in Alternative-Data
Credit Scoring: the Fairness–Utility–Legality Trade-off and a Governed
Mitigation Path"* (under anonymous review).

This repository is released for **double-blind peer review**. All
author- and institution-identifying information has been removed. Please do not
attempt to de-anonymize the authors.

## What this code does

The experiments study **proxy discrimination** in credit and related
decision models: the protected attribute's influence can reach the decision
through correlated, ostensibly non-sensitive features even after the attribute
itself is removed. The analysis reports two distinct axes that are often
conflated:

1. **Outcome parity** — the Disparate Impact Ratio (directional four-fifths),
   plus equalized-odds gaps.
2. **Proxy leakage** — how well the protected attribute can be reconstructed
   from the remaining features (reconstruction ROC-AUC).

A model can pass a parity audit while still carrying the protected attribute's
signal through proxies. The code quantifies both axes across five real datasets
in three domains, measures the cost of removing proxies, evaluates a group-wise
calibration mitigation, and documents the legal-admissibility constraint on
using a protected attribute at decision time.

## Repository layout

```
data/            input datasets (public benchmarks; see Data sources)
notebooks/       one self-contained notebook per experiment
results/
  figures/       grayscale figures, 600 dpi, PNG + PDF
  tables/        result tables (CSV)
```

## Notebooks

| Notebook | Experiment |
| --- | --- |
| `01_synthetic_proxy_mechanism.ipynb` | Controlled synthetic illustration of the proxy mechanism (non-circular generator) |
| `02_credit_core.ipynb` | Proxy discrimination and mitigation on three real credit datasets |
| `03_latency_overhead.ipynb` | Per-request latency of the governed decision path |
| `04_sensitivity_analysis.ipynb` | Robustness to proxy-correlation strength and base-rate gap |
| `05_multimetric_monitoring.ipynb` | Multi-metric monitoring and the fairness-impossibility trade-off |
| `06_transfer_noncredit.ipynb` | Transfer to non-credit domains (income, insurance fraud, recidivism) |
| `07_economic_impact.ipynb` | Approval-volume and stylized profit impact of parity restoration |
| `08_robustness_leakage.ipynb` | Strong-model (gradient-boosted) leakage and GBM base-scorer robustness |

Each notebook is a single self-contained cell: a header comment names the
notebook, all code and English comments follow, and running the cell top to
bottom reproduces that experiment's tables and figures. Figures are grayscale
(seaborn), 600 dpi, saved as both PNG and PDF, without captions. Output paths
are not printed.

## Reproducing

Requirements: Python 3.12+, with the packages in `requirements.txt`.

```
pip install -r requirements.txt
```

Then run the notebooks in order (or execute `run_all.sh`). All randomized
results are averaged over 30 seeds with 95% confidence intervals.

## Data sources

All datasets are public benchmarks, included here under `data/` for one-command
reproduction. No proprietary or personally identifiable data are used.

| File | Benchmark | Domain |
| --- | --- | --- |
| `german_credit.csv` | Statlog / South German Credit | Consumer credit |
| `taiwan_credit.parquet` | Default of Credit Card Clients (Taiwan) | Credit cards |
| `gmsc_credit.parquet` | Give Me Some Credit | Consumer lending |
| `adult_income.parquet` | Adult / Census Income | Income prediction |
| `insurance_fraud.csv` | Auto insurance claims | Insurance underwriting |
| `compas_two_years.csv` | ProPublica COMPAS (two-year) | Criminal justice |

A note on German Credit: the widely circulated Statlog coding does not allow sex
to be recovered reliably (male-single and female-single are not separable), so
this study uses **age** as the protected attribute for that dataset. See the
corrected South German Credit documentation for details.

## License

Released under the MIT License (see `LICENSE`). Copyright is held by the
anonymous author(s) for the duration of double-blind review; author and
institution details will be added on publication.
