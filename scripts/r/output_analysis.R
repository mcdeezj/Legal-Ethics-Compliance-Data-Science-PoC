rm(list = ls())

pred <- read.csv("outputs/predictions.csv")

# ROC Curve + AUC Plot
roc_obj <- pROC::roc(pred$compliance_issue, pred$predicted)
auc_value <- pROC::auc(roc_obj)

pdf("outputs/roc_curve_compliance.pdf", width = 7, height = 5)
plot(roc_obj, 
     main = "ROC Curve – Compliance Issue Prediction", 
     col = "blue", 
     lwd = 2)
text(x = 0.6, y = 0.2, 
    labels = paste0("AUC = ", round(auc_value, 4)), 
    col = "black", 
    cex = 1.2)
dev.off()

# Odds Ratios Plot
model <- glm(compliance_issue ~ adverse_event_reports + inspection_findings +
               previous_violations + compliance_training,
             data = pred, family = binomial)
odds <- exp(coef(model))[-1]
odds_df <- data.frame(Predictor = names(odds), OddsRatio = odds)

pdf("outputs/odds_ratios.pdf", width = 7, height = 5)
ggplot(odds_df, aes(x = reorder(Predictor, OddsRatio), y = OddsRatio)) +
  geom_bar(stat = "identity", fill = "darkgreen") +
  coord_flip() +
  theme_minimal() +
  labs(title = "Predictor Impact on Compliance",
       x = '', y = "Odds Ratio (Impact on Compliance)")
dev.off()

print("Pipeline completed successfully")