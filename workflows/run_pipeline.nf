include { MSA } from "../modules/msa.nf"
include { FOLD } from "../modules/fold.nf"

workflow RUN_PIPELINE {
    // Read sample sheet into channel
    Channel
        .fromPath(params.sample_sheet)
        .splitCsv(header: true, sep: '\t')
        .map { row -> 
            def run_id = row.run_id
            def json_path = file(row.json_path)
            tuple(run_id, json_path)
        }
        .set { input_channel }

    // Run MSA
    MSA(input_channel)

    // Run FOLD using output from MSA
    FOLD(MSA.out)
}