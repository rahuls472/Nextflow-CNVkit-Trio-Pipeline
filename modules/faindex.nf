#!/usr/bin/env nextflow
nextflow.enable.dsl = 2

process FAINDEX {
    container "biocontainers/samtools:v1.9-4-deb_cv1"
    publishDir "results/faindex", mode: 'copy'


    input:
    path ref

    output:
    path "${ref.name}.fai"

    script:
    """
    samtools faidx ${ref}
    """
}