#!/usr/bin/env nextflow
nextflow.enable.dsl = 2


process FASTQC {
    container "biocontainers/fastqc:v0.11.9_cv8"
    publishDir "results/fastqc", mode: 'copy'



    input:
    path fq


    output:
    path "*.html"
    path "*.zip"

    script:
    """
    fastqc -o . ${fq}
    """
}