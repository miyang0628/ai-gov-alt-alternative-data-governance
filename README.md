# AI-Gov-Alt: A Real-Time Governance Framework for Alternative-Data Credit Scoring and Insurance Underwriting

> **Anonymized repository for double-blind peer review.**
> All author, affiliation, and institution-identifying information has been removed.
> Please do not attempt to de-anonymize the authors.

This repository accompanies a Design Science Research (DSR) study proposing **AI-Gov-Alt**, a
real-time governance framework that lets financial and insurance institutions use
alternative data for credit scoring and underwriting while satisfying regulatory
requirements on privacy, fairness, explainability, and traceability.

The empirical materials here demonstrate the framework's **fairness engine** on fully
synthetic data, so that no real personal information is processed — consistent with the
framework's own compliance principles.

---

## Central Claim Demonstrated

Removing a protected attribute (e.g., nationality) **alone does not remove
discrimination**, because correlated proxy variables (e.g., residential region,
spending pattern) retain the group signal. The governance fairness engine restores
fairness **without sacrificing predictive utility**.

| Condition | AUC | DIR | Interpretation |
|---|---|---|---|
| `with_protected` | 0.992 | 0.299 | Overt disparate impact |
| `drop_protected_only` | 0.992 | 0.303 | **Proxy discrimination persists** |
| `drop_proxies_too` | 0.716 | 1.000 | Fair, but predictive utility collapses |
| `gov_engine` | 0.992 | 1.000 | **Utility preserved + fairness restored** |

*DIR = Disparate Impact Ratio (1.0 = parity; the dashed line at 0.8 marks the common "four-fifths" threshold).*

> **Note on the impossibility of simultaneous fairness.** The governance engine equalizes
> DIR (a demographic-parity–type metric) but does **not** simultaneously close the
> equalized-odds gaps. This is an empirical illustration of well-known fairness
> impossibility results and motivates **multi-metric monitoring** rather than
> single-metric optimization.

---

## Repository Structure

```
.
├── data/
│   └── synthetic_credit.csv                 # Generated synthetic dataset (reproducible)
├── notebooks/
│   └── 01_synthetic_proxy_discrimination.ipynb
├── results/
│   ├── figures/
│   │   ├── exp1_auc_dir.png / .pdf           # AUC vs DIR across conditions
│   │   └── exp1_dir_by_condition.png / .pdf  # DIR by condition
│   └── tables/
│       └── exp1_metrics.csv                  # AUC, DIR, dTPR, dFPR per condition
└── README.md
```

---

## Experiment 1 — Synthetic Proxy-Discrimination Demonstration

**Design**

- **Protected attribute:** nationality group (binary).
- **Proxy variables:** `residential_region`, `spending_pattern` (strongly group-correlated).
- **Legitimate risk features:** `income`, `debt_ratio`, `pay_history`.
- **Label bias:** the historical default label encodes proxy-driven bias, mimicking
  biased past decisions.

**Feature-set conditions**

1. `with_protected` — all features including the protected attribute
2. `drop_protected_only` — protected attribute removed, proxies retained
3. `drop_proxies_too` — protected attribute and proxies removed
4. `gov_engine` — proxies retained + group-wise threshold calibration (fairness engine)

**Metrics**

- **AUC** — predictive utility
- **DIR** — Disparate Impact Ratio
- **dTPR / dFPR** — equalized-odds gaps (difference in TPR / FPR across groups)

---

## Reproduction

**Requirements**

- Python 3.10+
- `numpy`, `pandas`, `scikit-learn`, `matplotlib`, `seaborn`
- `jupyter` (or `nbconvert`) to run the notebook

```bash
pip install numpy pandas scikit-learn matplotlib seaborn jupyter
```

**Run**

```bash
cd notebooks
jupyter nbconvert --to notebook --execute --inplace 01_synthetic_proxy_discrimination.ipynb
```

Running the notebook regenerates `data/synthetic_credit.csv`, all figures in
`results/figures/`, and the metrics table in `results/tables/`. The random seed is fixed
(`RANDOM_SEED = 42`) for reproducibility.

**Figure specification.** Figures use a grayscale seaborn theme, contain no captions
(captions belong in the manuscript), and are saved as both PNG and PDF at **600 dpi**.

---

## Roadmap (Planned Experiments)

- **Experiment 2** — Replicate the pipeline on public benchmark datasets to strengthen
  external validity.
- **Experiment 3** — XAI module: attribute-level contribution analysis (e.g., SHAP) to
  expose how proxy variables drive decisions.
- **Experiment 1 (extended)** — Repeat across multiple random seeds with confidence
  intervals for statistical rigor.

---

## Ethics and Data

All experiments use **synthetic data only**; no real personal data is collected or
processed. This is a deliberate design choice: a governance framework that criticizes
non-compliant data collection should not itself perform it. Any future field study would
require appropriate IRB review and a compliance-based data-collection protocol.

---

## License

Released for peer-review purposes. A license will be specified upon publication.
