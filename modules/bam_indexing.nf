#!/usr/bin/env nextflow

process BAMINDEX {

    container "biocontainers/samtools:v1.9-4-deb_cv1"
    publishDir "results/bam_index", mode: "copy"

    input:
    tuple val(sample), path(bam), path(metrics)

    output:
    tuple val(sample),
          path(bam),
          path("${bam.getName()}.bai")

    script:
    """
    samtools index ${bam}
    """
}