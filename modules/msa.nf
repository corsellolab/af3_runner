process MSA {
    label 'cpu_high'
    container "${params.singularity_image}"
    containerOptions """--bind \$PWD:/root/af_input \
        --bind ${params.model_param_dir}:/root/models \
        --bind ${params.database_root}:/root/public_databases \
    """

    input:
    tuple val(run_id), path(json_file)

    output:
    tuple val(run_id), path("output/**/*.json")

    script:
    """
    # print the current directory
    mkdir -p output
    python ${params.code_root}/run_alphafold.py \
        --json_path=/root/af_input/${json_file} \
        --model_dir=/root/models \
        --db_dir=/root/public_databases \
        --output_dir=output \
        --norun_inference
    """
}