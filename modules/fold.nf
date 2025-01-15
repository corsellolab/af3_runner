process RUN_FOLD {
    input: 
    tuple val(run_id), path(json_file)

    output: 
    tuple val(run_id), path("*TBD")

    container "${params.singularity_image}"
    containerOptions '''
        --nv
        --bind ${params.input_dir}:/root/af_input
        --bind ${params.output_dir}:/root/af_output
        --bind ${params.model_param_dir}:/root/models
        --bind ${params.database_root}:/root/public_databases
    '''

    script:
    """
    python alphafold3/run_alphafold.py \
        --json_path=/root/af_input/${json_file} \
        --model_dir=/root/models \
        --db_dir=/root/public_databases \
        --output_dir=/root/af_output \
        --norun_data_pipeline
    """
}