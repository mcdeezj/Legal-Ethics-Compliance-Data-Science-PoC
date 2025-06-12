rm(list = ls())

df <- read.csv("data/synthetic_compliance_data.csv")

# Select relevant variables
X <- df[, c("adverse_event_reports", "inspection_findings", "previous_violations", "compliance_training")]
y <- df$compliance_issue

# Train-test split
set.seed(42)
split <- createDataPartition(y, p = 0.7, list = FALSE)
train <- df[split, ]
test <- df[-split, ]

model <- glm(compliance_issue ~ adverse_event_reports + inspection_findings +
               previous_violations + compliance_training,
             data = train, family = binomial)

test$predicted <- predict(model, newdata = test, type = "response")
test$prediction_class <- ifelse(test$predicted > 0.5, 1, 0)

write.csv(test, "outputs/predictions.csv", row.names = FALSE)

# Write metrics
auc_val <- roc(test$compliance_issue, test$predicted)$auc
metrics <- paste("ROC_AUC,", round(auc_val, 4))
write(metrics, "outputs/model_metrics.csv")
