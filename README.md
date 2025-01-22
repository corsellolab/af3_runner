# AF3 Runner

Run AF3 inference on Sherlock (somewhat efficiently).

Nick Phillips (nphill22@stanford.edu)

## Usage

Basic usage:
```bash
./run_AF3.sh --sample-sheet samples.tsv \
             --output-dir results \
             --model-dir /path/to/models
```

All available options:
```bash
Required arguments:
    --sample-sheet PATH     Path to sample sheet (tab-separated file)
    --output-dir PATH      Output directory for results
    --model-dir PATH       Directory containing AF3 model parameters

Optional arguments:
    --cpu-queue STR       CPU queue(s) to use (default: "normal")
    --gpu-queue STR       GPU queue(s) to use (default: "gpu")
    --scratch-dir PATH    Directory for cached resources (default: "/scratch/users/$USER/af3_resources")
```

## Input Files

### Sample Sheet
The sample sheet is a tab-separated file formatted as follows:
```
run_id  json_path
<run1>  <run1>.json
<run2>  <run2>.json
... ...
```

### Model Parameters
The model parameters directory should be a directory containing the AF3 *.bin.zst file. 

## Notes
- AF3 performance is validated on GPUs with 80GB of memory. This script runs AF3 configured to use unified memory on 40GB+ GPUs, increasing the available resources. This should work without error for input length up to 4352 tokens.
- You can specify multiple queues for CPU or GPU jobs by separating them with commas (e.g., `--cpu-queue normal,owners`)
- The scratch directory is used to cache resources locally for faster access. By default, it's set to `/scratch/users/$USER/af3_resources`