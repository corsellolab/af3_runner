process CACHE_RESOURCES {
    label 'io_limited'

    input:
    path original_singularity_image
    path original_database_root
    path original_code_root

    script:
    """
    mkdir -p "${params.scratch_dir}"
    # use rsync to copy if not already exists
    rsync -av --ignore-existing "${original_singularity_image}" "${params.cached_singularity_image}"
    rsync -av --ignore-existing "${original_database_root}" "${params.cached_database_root}"
    rsync -av --ignore-existing "${original_code_root}" "${params.cached_code_root}"
    """
}