import pandas as pd
from sklearn.linear_model import LogisticRegression
from sklearn.model_selection import train_test_split
from sklearn.metrics import roc_auc_score

df = pd.read_csv("outputs/synthetic_compliance_data.csv")

X = df[["adverse_event_reports", "inspection_findings", "previous_violations", "compliance_training"]]
y = df["compliance_issue"]

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3, random_state=42)

model = LogisticRegression()
model.fit(X_train, y_train)

y_pred = model.predict_proba(X_test)[:, 1]
auc = roc_auc_score(y_test, y_pred)

X_test["predicted"] = y_pred
X_test["actual"] = y_test.values
X_test.to_csv("outputs/predictions.csv", index=False)

params = pd.DataFrame({
    "feature": X.columns,
    "coefficient": model.coef_[0]
})
params.to_csv("outputs/model_coefficients.csv", index=False)

with open("outputs/model_metrics.csv", "w") as f:
    f.write(f"ROC_AUC,{auc:.4f}")
