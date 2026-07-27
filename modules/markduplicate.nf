#!/usr/bin/env nextflow

process MARKDUPLICATE {

    container "broadinstitute/gatk:latest"
    publishDir "results/markduplicates", mode: "copy"

    input:
    tuple val(sample), path(bam)

    output:
    tuple val(sample),
          path("${sample}.markdup.bam"),
          path("${sample}.metrics.txt")

    script:
    """
    gatk MarkDuplicates \
        -I ${bam} \
        -O ${sample}.markdup.bam \
        -M ${sample}.metrics.txt
    """
}