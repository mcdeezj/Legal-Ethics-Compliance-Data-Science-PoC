import pandas as pd
import matplotlib.pyplot as plt
from sklearn.metrics import roc_curve, roc_auc_score

df = pd.read_csv("outputs/predictions.csv")

fpr, tpr, _ = roc_curve(df["actual"], df["predicted"])
auc = roc_auc_score(df["actual"], df["predicted"])

plt.figure()
plt.plot(fpr, tpr, label=f"AUC = {auc:.2f}")
plt.plot([0,1], [0,1], "k--")
plt.title("ROC Curve – Compliance Risk")
plt.xlabel("False Positive Rate")
plt.ylabel("True Positive Rate")
plt.legend()
plt.savefig("outputs/roc_curve.pdf")

coef = pd.read_csv("outputs/model_coefficients.csv")
plt.figure()
coef.plot.bar(x="feature", y="coefficient", legend=False, color="skyblue")
plt.title("Feature Coefficients – Logistic Regression")
plt.ylabel("Effect Size")
plt.tight_layout()
plt.savefig("outputs/odds_ratios.pdf")
