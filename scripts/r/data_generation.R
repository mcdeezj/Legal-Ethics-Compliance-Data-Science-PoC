#### In a non-notional scenario, this script would be replaced by executing SQL against company databases of record, RAG-enabled gathering, or manual methods ####
#
# Typically I handle data ingest and cleaning in separate scripts but this would be subject to company preferred practice and code efficiency.

set.seed(42)
n <- 1000

product_name <- rep("Trulicity", n)
region <- sample(c("North America", "Europe", "Asia"), n, replace = TRUE)
regulatory_body <- sample(c("FDA", "EMA", "PMDA"), n, replace = TRUE)
clinical_trial_phase <- sample(c("I", "II", "III", "IV"), n, replace = TRUE)
adverse_event_reports <- rpois(n, 5)
manufacturing_site <- sample(c("SiteA", "SiteB", "SiteC"), n, replace = TRUE)
inspection_findings <- rpois(n, 2)
compliance_training <- rbinom(n, 1, 0.7)
previous_violations <- rbinom(n, 3, 0.1)

inspection_texts <- c(
  "No critical issues noted.",
  "Documentation errors noted.",
  "Data integrity concerns.",
  "Untrained personnel.",
  "No findings.",
  "Deviation found."
)

compliance_notes <- c(
  "All procedures followed.",
  "Deviation due to site.",
  "Docs not up to date.",
  "Training records missing.",
  "QA pending review."
)

inspection_report_text <- sample(inspection_texts, n, replace = TRUE)
compliance_notes_text <- sample(compliance_notes, n, replace = TRUE)

logit <- -1 + 0.3 * adverse_event_reports + 0.5 * inspection_findings +
  0.8 * previous_violations - 0.6 * compliance_training
prob <- 1 / (1 + exp(-logit))
compliance_issue <- rbinom(n, 1, prob)

df <- data.frame(
  product_name, region, regulatory_body, clinical_trial_phase,
  adverse_event_reports, manufacturing_site, inspection_findings,
  compliance_training, previous_violations,
  inspection_report_text, compliance_notes_text,
  compliance_issue
)

write.csv(df, "data/synthetic_compliance_data.csv", row.names = FALSE)

