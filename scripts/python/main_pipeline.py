import subprocess

scripts = [
    "scripts/python/data_generation.py",
    "scripts/python/model_training.py",
    "scripts/python/output_analysis.py"
]

for script in scripts:
    try:
        print(f"Running {script}")
        subprocess.run(["python3", script], check=True)
    except subprocess.CalledProcessError as e:
        print(f"Error while running {script}: {e}")
        exit(1)
print("Pipeline complete.")
