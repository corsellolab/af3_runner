#!/usr/bin/env nextflow
/*
-------------------------------------------------------------------------------
AF3_Runner
-------------------------------------------------------------------------------
    Nick Phillips (nphill22@stanford.edu) - Nextflowification
-------------------------------------------------------------------------------
*/

nextflow.enable.dsl = 2

include { RUN_PIPELINE } from './workflows/run_pipeline.nf'

// Define parameters
params.sample_sheet = null
params.output_dir = null
params.model_param_dir = null

workflow {
    // Parameter validation
    if (!params.sample_sheet) {
        error "Please provide a sample sheet with --sample_sheet"
    }
    if (!params.output_dir) {
        error "Please provide an output directory with --output_dir"
    }
    if (!params.model_param_dir) {
        error "Please provide a model parameter directory with --model_param_dir"
    }

    RUN_PIPELINE()
}
