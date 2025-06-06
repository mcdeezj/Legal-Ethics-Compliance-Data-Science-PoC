# Compliance Signal Simulation – Proof of Concept

## Purpose
A demonstration of how simulation and predictive modeling can be used to flag compliance risks in pharmaceutical operations, using synthetic data and interpretable modeling techniques.

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
