#!/usr/bin/env nextflow
nextflow.enable.dsl = 2

process ALIGNMENT {

    container "quay.io/biocontainers/bwa:0.7.19--h577a1d6_1"
    publishDir "results/alignment", mode: "copy"

    input:
    tuple val(sample), path(r1), path(r2)
    tuple(
        path(ref),
        path(amb),
        path(ann),
        path(bwt),
        path(pac),
        path(sa),
        path(fai)
    )

    output:
    tuple val(sample), path("${sample}.sam")

    script:
    """
    bwa mem \
        -t 4 \
        -R "@RG\\tID:${sample}\\tSM:${sample}\\tPL:ILLUMINA" \
        ${ref} \
        ${r1} \
        ${r2} \
        > ${sample}.sam
    """
}