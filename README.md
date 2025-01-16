# AF3 Runner

Run AF3 inference on Sherlock (somewhat efficiently).

## Usage
```
ml nextflow
nextflow run main.nf \
    --sample_sheet <path_to_sample_sheet> \
    --output_dir <path_to_output_dir> \
    --model_param_dir <model_parameter_dir>
```

The sample sheet is a tab separated file formatted as follows:
```
run_id  json_path
<run1>  <run1>.json
<run2>  <run2>.json
... ...
```

The model parameters directory should be a directory containing the AF3 *.bin.zst file. 

## Notes
- AF3 performance is validated on GPUs with 80GB of memory. This script runs AF3 configured to use unifed memory on 40GB+ GPUs, increasing the available resources. This should work without error for input length up to 4352 tokens.