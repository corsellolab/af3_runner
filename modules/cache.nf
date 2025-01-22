process CACHE_RESOURCES {
    label 'local'

    input:
    path original_singularity_image
    path original_database_root
    path original_code_root

    output: 
    val "done", emit: completed

    script:
    """
    mkdir -p "${params.scratch_dir}"
    echo 
    # use rsync to copy if it doesn't exist
    rsync -avL --ignore-existing "${original_singularity_image}" "${params.singularity_image}"
    rsync -avL --ignore-existing "${original_database_root}/" "${params.database_root}"
    rsync -avL --ignore-existing "${original_code_root}/" "${params.code_root}"
    """
}