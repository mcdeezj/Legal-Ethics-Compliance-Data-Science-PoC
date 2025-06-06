.PHONY: run clean

run:
	@echo "Running Compliance Simulation Pipeline"
	python3 scripts/python/main_pipeline.py

clean:
	rm -rf outputs/*.csv outputs/*.pdf
