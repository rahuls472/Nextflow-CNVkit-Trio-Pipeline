#!/usr/bin/env nextflow
nextflow.enable.dsl = 2

process FASTP {

    container "biocontainers/fastp:v0.19.6dfsg-1-deb_cv1"
    publishDir "results/fastp", mode: 'copy'

    input:
    tuple val(sample), path(reads)

    output:
    tuple val(sample),
          path("${sample}_R1.trim.fq"),
          path("${sample}_R2.trim.fq")

    script:
    """
    fastp \
        -i ${reads[0]} \
        -I ${reads[1]} \
        -o ${sample}_R1.trim.fq \
        -O ${sample}_R2.trim.fq
    """
}