#!/bin/bash

# Default values
CPU_QUEUE="normal"
GPU_QUEUE="gpu"
SCRATCH_DIR="/scratch/users/${USER}/af3_resources"

# Function to print usage
print_usage() {
    cat << EOF
Usage: $0 [options]

Required arguments:
    --sample-sheet PATH     Path to sample sheet (tab-separated file)
    --output-dir PATH      Output directory for results
    --model-dir PATH       Directory containing AF3 model parameters

Optional arguments:
    --cpu-queue STR       CPU queue(s) to use (default: "${CPU_QUEUE}")
    --gpu-queue STR       GPU queue(s) to use (default: "${GPU_QUEUE}")
    --scratch-dir PATH    Directory for cached resources (default: "${SCRATCH_DIR}")
    --help               Print this help message

Example:
    $0 --sample-sheet samples.tsv \\
       --output-dir results \\
       --model-dir /path/to/models \\
       --cpu-queue normal,owners \\
       --gpu-queue gpu
EOF
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --sample-sheet)
            SAMPLE_SHEET="$2"
            shift 2
            ;;
        --output-dir)
            OUTPUT_DIR="$2"
            shift 2
            ;;
        --model-dir)
            MODEL_PARAM_DIR="$2"
            shift 2
            ;;
        --cpu-queue)
            CPU_QUEUE="$2"
            shift 2
            ;;
        --gpu-queue)
            GPU_QUEUE="$2"
            shift 2
            ;;
        --scratch-dir)
            SCRATCH_DIR="$2"
            shift 2
            ;;
        --help)
            print_usage
            exit 0
            ;;
        *)
            echo "Error: Unknown argument $1"
            print_usage
            exit 1
            ;;
    esac
done

# Validate required arguments
if [ -z "$SAMPLE_SHEET" ] || [ -z "$OUTPUT_DIR" ] || [ -z "$MODEL_PARAM_DIR" ]; then
    echo "Error: Missing required arguments"
    print_usage
    exit 1
fi

# Validate inputs
if [ ! -f "$SAMPLE_SHEET" ]; then
    echo "Error: Sample sheet $SAMPLE_SHEET does not exist"
    exit 1
fi

if [ ! -d "$MODEL_PARAM_DIR" ]; then
    echo "Error: Model parameter directory $MODEL_PARAM_DIR does not exist"
    exit 1
fi

# Create output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Load required modules
ml reset
ml java/18.0.2
ml biology
ml nextflow/23.04.3

# Set the work dir to a subdirectory of the output_dir
mkdir -p "$OUTPUT_DIR/work"

# Run the nextflow pipeline
nextflow run main.nf \
    --sample_sheet "$SAMPLE_SHEET" \
    --output_dir "$OUTPUT_DIR" \
    --model_param_dir "$MODEL_PARAM_DIR" \
    --cpu_queue "$CPU_QUEUE" \
    --gpu_queue "$GPU_QUEUE" \
    --scratch_dir "$SCRATCH_DIR" \
    -work-dir "$OUTPUT_DIR/work" \
    -resume
