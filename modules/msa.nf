process MSA {
    label 'cpu_high'
    containerOptions """--bind \$PWD:/root/af_input \
        --bind ${params.model_param_dir}:/root/models \
        --bind ${params.database_root}:/root/public_databases \
    """

    input:
    tuple val(run_id), path(json_file)

    output:
    tuple val(run_id), path("*TBD")

    script:
    """
    # print the current directory
    pwd
    # print the contents of the current directory
    ls -l
    cd ~
    python alphafold3/run_alphafold.py \
        --json_path=/root/af_input/${json_file} \
        --model_dir=/root/models \
        --db_dir=/root/public_databases \
        --output_dir=/root/af_input \
        --no_run_inference
    """
}