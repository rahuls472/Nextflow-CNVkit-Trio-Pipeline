#!/usr/bin/env nextflow

process SORTING {
    container "biocontainers/samtools:v1.9-4-deb_cv1"
    publishDir "results/sorted_files", mode: "copy"

    input:
    tuple val(sample), path(sam)
    

    output:
    tuple val(sample), path("${sample}.sorted.bam")

    script:
    """
    samtools sort -o ${sample}.sorted.bam ${sam}
    """


}