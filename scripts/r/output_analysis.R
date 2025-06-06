library(pROC)
library(ggplot2)
library(dplyr)

pred <- read.csv("outputs/predictions.csv")

# ROC Curve
roc_obj <- roc(pred$compliance_issue, pred$predicted)

pdf("outputs/roc_curve.pdf")
plot(roc_obj, main = "ROC Curve – Compliance Issue Prediction", col = "blue", lwd = 2)
abline(a = 0, b = 1, lty = 2, col = "gray")
dev.off()

# Odds Ratios
model <- glm(compliance_issue ~ adverse_event_reports + inspection_findings +
               previous_violations + compliance_training,
             data = pred, family = binomial)

odds <- exp(coef(model))[-1]
odds_df <- data.frame(Predictor = names(odds), OddsRatio = odds)

pdf("outputs/odds_ratios.pdf")
ggplot(odds_df, aes(x = reorder(Predictor, OddsRatio), y = OddsRatio)) +
  geom_bar(stat = "identity", fill = "darkgreen") +
  coord_flip() +
  theme_minimal() +
  labs(title = "Odds Ratios – Predictor Impact",
       x = "Predictor", y = "Odds Ratio")
dev.off()
