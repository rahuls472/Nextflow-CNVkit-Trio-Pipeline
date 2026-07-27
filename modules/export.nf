#!/usr/bin/env nextflow

process EXPORTCNV {

    container "biocontainers/cnvkit:v0.9.5-3-deb_cv1"

    publishDir "results/export", mode: "copy"

    input:
    path(call_cns)

    output:
    path "*.bed"
    path "*.vcf"

    script:
    """
    sample=\$(basename ${call_cns} .call.cns)

    cnvkit export bed \
        ${call_cns} \
        -o \${sample}.bed

    cnvkit export vcf \
        ${call_cns} \
        -o \${sample}.vcf
    """
}