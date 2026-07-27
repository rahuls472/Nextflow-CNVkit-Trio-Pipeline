#!/usr/bin/env nextflow

process CNVCALL {

    container "biocontainers/cnvkit:v0.9.5-3-deb_cv1"

    publishDir "results/cnv_call", mode: "copy"

    input:
    path(cns)

    output:
    path "*.call.cns"

    script:
    """
    sample=\$(basename ${cns} .cns)

    cnvkit call \
        ${cns} \
        -o \${sample}.call.cns
    """
}