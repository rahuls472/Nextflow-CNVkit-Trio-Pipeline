process PROBANDANALYSE {

    container "biocontainers/cnvkit:v0.9.5-3-deb_cv1"
    publishDir "results/proband_analysis", mode: "copy"

    input:
    path reference_cnn

    tuple val(sample), path(case_bam), path(case_bai)

    output:
    path "*.cnr", emit: cnr
    path "*.cns", emit: cns
    path "*-scatter.pdf", emit: scatter
    path "*-diagram.pdf", emit: diagram

    script:
    """
    cnvkit batch \
        ${case_bam} \
        --reference ${reference_cnn} \
        --method wgs \
        --output-dir . \
        --diagram \
        --scatter
    """
}