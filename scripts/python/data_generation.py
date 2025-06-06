import pandas as pd
import numpy as np
import os

np.random.seed(42)
n = 1000

df = pd.DataFrame({
    "product_name": ["Trulicity"] * n,
    "region": np.random.choice(["North America", "Europe", "Asia"], size=n),
    "regulatory_body": np.random.choice(["FDA", "EMA", "PMDA"], size=n),
    "clinical_trial_phase": np.random.choice(["I", "II", "III", "IV"], size=n),
    "adverse_event_reports": np.random.poisson(5, size=n),
    "manufacturing_site": np.random.choice(["SiteA", "SiteB", "SiteC"], size=n),
    "inspection_findings": np.random.poisson(2, size=n),
    "compliance_training": np.random.binomial(1, 0.7, size=n),
    "previous_violations": np.random.binomial(3, 0.1, size=n),
    "inspection_report_text": np.random.choice([
        "No critical issues noted.", "Documentation errors noted.",
        "Data integrity concerns.", "Untrained personnel.",
        "No findings.", "Deviation found."
    ], size=n),
    "compliance_notes_text": np.random.choice([
        "All procedures followed.", "Deviation due to site.",
        "Docs not up to date.", "Training records missing.",
        "QA pending review."
    ], size=n)
})

logit = (
    -1 + 0.3 * df["adverse_event_reports"] +
    0.5 * df["inspection_findings"] +
    0.8 * df["previous_violations"] -
    0.6 * df["compliance_training"]
)
prob = 1 / (1 + np.exp(-logit))
df["compliance_issue"] = np.random.binomial(1, prob)

os.makedirs("outputs", exist_ok=True)
df.to_csv("outputs/synthetic_compliance_data.csv", index=False)
