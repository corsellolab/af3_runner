process FOLD {
    publishDir "${params.output_dir}"
    label 'gpu_high'
    container "${params.singularity_image}"
    containerOptions """--nv \
        --bind \$PWD:/root/af_input \
        --bind ${params.model_param_dir}:/root/models \
        --bind ${params.database_root}:/root/public_databases \
        --env XLA_PYTHON_CLIENT_PREALLOCATE=false \
        --env TF_FORCE_UNIFIED_MEMORY=true \
        --env XLA_CLIENT_MEM_FRACTION=3.2 \
    """

    input: 
    tuple val(run_id), path(json_file)

    output: 
    tuple val(run_id), path("${run_id}")

    script:
    """
    mkdir -p output
    python ${params.code_root}/run_alphafold.py \
        --json_path=/root/af_input/${json_file} \
        --model_dir=/root/models \
        --db_dir=/root/public_databases \
        --output_dir=/root/af_input \
        --norun_data_pipeline
    """
}