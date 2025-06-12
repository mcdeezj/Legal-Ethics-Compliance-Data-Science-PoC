# Compliance Signal Simulation – Proof of Concept

_IMPORTANT - This is a proof of concept only. The R repository is fully functional and should run if you clone the repo to a compatible local environment. The python sub directory requires additional curation for functionality._

## Purpose
A demonstration of how the author might use predictive modeling as a precursor to simulation in order to flag compliance risks in pharmaceutical operations, using synthetic data and interpretable modeling techniques.

This code is derived from several ChatGPT prompt--respond--refine cycles. Then Human-in-the-loop refinement by the author to ensure functionality end-to-end.

The **overall objective** is to produce a model of compliance risk, validate that it is adequate, and then use parameter inference to find areas that might be worth more in-depth analysis. Simulation is one methodology that could be used to experiment with a sub-process if it can be shown that the parameter impacted is contributing to higher risk based on the below model.

## Structure
- **Python and R versions** of the same pipeline
- **Three-phase structure**:
  1. Synthetic data generation
  2. Logistic regression modeling and predictions
  3. Output analysis with charts and coefficients

## Assumptions
- Compliance outcomes are influenced by reportable events, inspection findings, violations, and training
- Text notes and reports, while generated as free-text, are not modeled in this PoC

## Execution Flow
```bash
make run             # Executes the Python version
make clean           # Removes output files
make -f Makefile.diagram diagram  # Shows diagram flow
```

