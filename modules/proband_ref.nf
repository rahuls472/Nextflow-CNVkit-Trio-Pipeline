#!/usr/bin/env nextflow

process CNVREFPOOL {

    container "biocontainers/cnvkit:v0.9.5-3-deb_cv1"
    publishDir "results/cnv_ref_pool", mode: "copy"

    input:
    path normal_bams
    tuple val(sample), path(case_bam), path(case_bai)
    tuple path(ref), path(amb), path(ann), path(bwt), path(pac), path(sa), path(fai)

    output:
    path "reference.cnn"

    script:
    """
    cnvkit batch \
        ${case_bam} \
        --normal ${normal_bams.join(' ')} \
        --method wgs \
        --fasta ${ref} \
        --output-reference reference.cnn \
        --diagram \
        --scatter
    """
}