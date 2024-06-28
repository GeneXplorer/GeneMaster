import sys
import subprocess

def run_subprocess(command):
    process = subprocess.Popen(command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    out, err = process.communicate()
    if process.returncode != 0:
        print(f"Error running command: {command}")
        print(err.decode())
        sys.exit(1)
    return out.decode()