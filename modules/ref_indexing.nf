#!/usr/bin/env nextflow
nextflow.enable.dsl = 2

process REF_INDEXING {
    container "quay.io/biocontainers/bwa:0.7.19--h577a1d6_1"
    publishDir "results/ref_indexing", mode: 'copy'

    input:
    path ref

    output:
    tuple(
        path("${ref.name}"),
        path("${ref.name}.amb"),
        path("${ref.name}.ann"),
        path("${ref.name}.bwt"),
        path("${ref.name}.pac"),
        path("${ref.name}.sa"),
    )

    script:
    """
    bwa index ${ref}
    """
}