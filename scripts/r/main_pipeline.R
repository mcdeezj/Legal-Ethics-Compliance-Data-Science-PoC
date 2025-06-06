scripts <- c("scripts/data_generation.R",
             "scripts/model_training.R",
             "scripts/output_analysis.R")

for (script in scripts) {
  cat("Running", script, "...\n")
  tryCatch(
    { source(script) },
    error = function(e) {
      cat("Error in", script, ":\n", e$message, "\n")
      stop("Aborting pipeline.")
    }
  )
}
cat("Pipeline completed successfully.\n")
