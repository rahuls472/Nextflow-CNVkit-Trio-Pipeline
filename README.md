# Nextflow-CNVkit-Trio-Pipeline

A modular **Nextflow DSL2** pipeline for **Copy Number Variation (CNV) analysis** from paired-end sequencing data using **CNVkit**. The pipeline performs quality control, read preprocessing, alignment, duplicate marking, CNV reference construction from parental samples, CNV calling for the proband, and exports results in **BED** and **VCF** formats.

---

## Features

- Modular Nextflow DSL2 workflow
- Quality control using FastQC
- Read trimming using Fastp
- Alignment using BWA-MEM2
- BAM sorting and indexing using Samtools
- Duplicate marking using GATK
- CNV reference creation using parental samples
- CNV analysis of the proband using CNVkit
- CNV calling
- Export CNVs to BED and VCF
- Docker compatible

---

## Workflow

![Pipeline DAG](Screenshots/pipeline_dag.png)

---

## Pipeline Architecture

```text
FASTQ
   │
   ▼
FASTQC
   │
   ▼
FASTP
   │
   ▼
ALIGNMENT
   │
   ▼
SORTING
   │
   ▼
MARKDUPLICATE
   │
   ▼
BAMINDEX
   │
   ├───────────────┐
   │               │
Parents         Proband
   │               │
   ▼               │
CNVREFPOOL         │
   │               │
   └───────┬───────┘
           ▼
   PROBANDANALYSE
           │
           ▼
       CNVCALL
           │
           ▼
      EXPORTCNV
      ├── BED
      └── VCF
```

---

## Modules

| Module | Description |
|----------|-------------|
| REF_INDEXING | Builds BWA reference index |
| FAINDEX | Creates FASTA index |
| FASTQC | Raw read quality assessment |
| FASTP | Adapter trimming and quality filtering |
| ALIGNMENT | Read alignment using BWA-MEM2 |
| SORTING | Coordinate sorting of BAM files |
| MARKDUPLICATE | Marks PCR duplicates using GATK |
| BAMINDEX | Generates BAM index (.bai) |
| CNVREFPOOL | Builds pooled CNV reference from parental BAMs |
| PROBANDANALYSE | Performs CNV analysis on the proband |
| CNVCALL | Calls CNVs from segmented data |
| EXPORTCNV | Exports CNVs to BED and VCF formats |

---

## Repository Structure

```text
Nextflow-CNVkit-Trio-Pipeline/
│
├── modules/
│   ├── alignment.nf
│   ├── fastp_quality.nf
│   ├── fastqc_scripts.nf
│   ├── sorting.nf
│   ├── markduplicate.nf
│   ├── bam_indexing.nf
│   ├── proband_ref.nf
│   ├── analyse.nf
│   ├── cnv_call.nf
│   └── export.nf
│
├── Screenshots/
│   ├── pipeline_dag.png
│   └── terminal_process.png
│
├── main.nf
├── nextflow.config
├── README.md
└── .gitignore
```

---

## Requirements

- Nextflow >= 24.x
- Docker
- Java 17+

---

## Running the Pipeline

```bash
nextflow run main.nf \
    -resume
```

To generate the workflow DAG:

```bash
nextflow run main.nf \
    -resume \
    -with-dag pipeline_dag.html
```

---

## Pipeline Execution

The pipeline successfully completed all stages.

![Pipeline Execution](Screenshots/terminal_process.png)

---

## Output

The pipeline produces:

```
results/
│
├── fastqc/
├── fastp/
├── alignment/
├── sorting/
├── markduplicate/
├── bamindex/
├── cnv_reference/
├── analyse/
├── cnv_call/
└── export/
    ├── *.bed
    └── *.vcf
```

---

## Technologies Used

- Nextflow DSL2
- Docker
- BWA-MEM2
- Samtools
- GATK
- FastQC
- Fastp
- CNVkit

---

## Future Improvements

- MultiQC integration
- AnnotSV-based CNV annotation
- Sample sheet support
- nf-core style parameter validation
- Automated HTML reports

---

## Author

**Rahul Kumar Singh**

M.Sc. Bioinformatics

GitHub: https://github.com/rahuls472

LinkedIn: *(Add your LinkedIn profile here)*

---
