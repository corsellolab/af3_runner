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

workflow {
    RUN_PIPELINE()
}
