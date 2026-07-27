#!/usr/bin/env nextflow
nextflow.enable.dsl = 2



include {FASTQC} from './modules/fastqc_scripts.nf'
include {REF_INDEXING} from './modules/ref_indexing.nf'
include {FAINDEX} from './modules/faindex.nf'
include {FASTP} from './modules/fastp_quality.nf'
include { ALIGNMENT } from './modules/alignment.nf'
include {SORTING} from './modules/sorting.nf'
include {MARKDUPLICATE} from './modules/markduplicate.nf'
include {BAMINDEX} from './modules/bam_indexing.nf'
include {CNVREFPOOL} from './modules/proband_ref.nf'
include {PROBANDANALYSE} from './modules/analyse.nf'
include {CNVCALL} from './modules/cnv_call.nf'
include {EXPORTCNV} from './modules/export.nf'



workflow {

    // Reference indexing
    ch_ref = Channel.fromPath(params.ref)
    ref_indexing = REF_INDEXING(ch_ref)

    // FASTA index
    faindex = FAINDEX(ch_ref)
    ref_bundle = ref_indexing.combine(faindex).first()

    // QC
    ch_data = Channel.fromPath(params.data)
    FASTQC(ch_data)

    // Read pairs
    ch_reads = Channel.fromFilePairs(
        params.data,
        checkIfExists: true
    )

    // Alignment pipeline
    fastp        = FASTP(ch_reads)
    alignment    = ALIGNMENT(fastp, ref_bundle)
    sorting      = SORTING(alignment)
    dup_marked   = MARKDUPLICATE(sorting)
    bam_indexing = BAMINDEX(dup_marked)

    // Split trio
    parents = bam_indexing.filter { sample, bam, bai ->
        sample != "proband"
    }

    proband = bam_indexing.filter { sample, bam, bai ->
        sample == "proband"
    }

    // Collect normal BAMs
    parent_bams = parents
        .map { sample, bam, bai -> bam }
        .collect()

    // Build CNV reference
    cnvRefPool = CNVREFPOOL(
        parent_bams,
        proband,
        ref_bundle
    )

    analyse = PROBANDANALYSE(
    cnvRefPool,
    proband
)

    cnvcall = CNVCALL(
        analyse.cns
    )


    export = EXPORTCNV(cnvcall)

}