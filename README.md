# README: LoFreq Variant Calling for Minimal Residual Disease (MRD) Detection

## Overview

This project focuses on utilizing **LoFreq**, a low-frequency variant caller, to detect **circulating tumor DNA (ctDNA)** variants present in **cell-free DNA (cfDNA)**. LoFreq was integrated into a Python-based variant-calling pipeline developed for evaluating the sensitivity and specificity of **Salish Biosciences' Minimal Residual Disease (MRD) technology**. The goal of this project was to detect **rare ctDNA** mutations, even at low frequencies (e.g., 1/1000), which are typically masked by sequencing errors. 

In this project, LoFreq was used in combination with **Unique Molecular Identifier (UMI)**-tagged reads for deduplication and error correction. The primary goal was to improve the detection of ctDNA variants that would otherwise be difficult to detect due to their low variant allele frequency (VAF).

## Purpose of Using LoFreq

LoFreq is a variant caller optimized for the detection of low-frequency mutations, which is particularly important when analyzing ctDNA in cfDNA. In the context of this project, LoFreq was used to:

1. **Detect ctDNA Variants in cfDNA**: 
   - The key challenge was identifying ctDNA variants with a frequency of 1 in 1000 (0.1%) within cfDNA libraries that have been sequenced using Illumina MiSeq technology.

2. **Increase Sensitivity for Low-Frequency Variants**:
   - LoFreq is designed to be sensitive to rare variants, which makes it suitable for detecting variants with very low allele frequencies in sequencing data.

3. **Mitigate Sequencing Errors**:
   - By incorporating UMIs in the workflow, LoFreq was used to identify and remove sequencing errors and PCR duplicates, which are particularly problematic in low-frequency variant detection.

4. **Enhance the Accuracy of MRD Detection**:
   - The LoFreq results helped identify tumor variants present in extremely low quantities, allowing for the detection of **Minimal Residual Disease (MRD)** post-cancer treatment.

## Project Files and Workflow

The following input files were used for running LoFreq in the context of this project:

- **chris_hg38_reformatted.bed**: A BED file containing genomic regions of interest for variant calling.
- **sorted.deduped_Q25.bam**: A BAM file containing aligned and deduplicated sequencing data.
- **test_Q25.sorted.bam**: A BAM file for variant calling in LoFreq.

Two separate workflows were tested:
1. A workflow with **deduplicated** data.
2. A workflow where the data was **merged** before running LoFreq.

Additionally, various parameters were tested to optimize the results, including a more permissive configuration to allow for the detection of a wider range of variants. Below is an example of one of the LoFreq script configurations used for this project:

### LoFreq Script Example

```bash
#!/bin/bash

#SBATCH --account=bgmp                       # SLURM account which will be charged for the job
#SBATCH --job-name=lofreqVP_seq              # Job Name
#SBATCH --output=lofreq_BAM_%j.out           # File to store job output
#SBATCH --error=lofreq_BAM-%j.err            # File to store job error messages
#SBATCH --time=0-24:00:00                    # Wall clock time limit
#SBATCH --nodes=1                            # Node count
#SBATCH --cpus-per-task=4                    # Number of CPUs per task
#SBATCH --partition=bgmp                     # Partition for job

conda activate /path/to/your/conda/environment/lofreq

/usr/bin/time -v lofreq call --no-default-filter -A -B -a 1 -b 1 -f /path/to/reference/genome.fasta -l /path/to/bed/file.bed -o output.vcf.gz /path/to/input/bamfile.bam
```

## Parameters Explained

- **--no-default-filter**: Disables default filtering, allowing the user to apply custom filtering parameters.
- **-A** and **-B**: These options modify the filtering behavior of LoFreq to adjust for low-frequency variant detection.
- **-a 1** and **-b 1**: These parameters adjust the minimum read depth and coverage necessary for variant calling.
- **-f**: Specifies the reference genome file (hg38).
- **-l**: Points to the BED file with targeted regions for variant calling.
- **-o vcf.gz**: The output is in compressed VCF format.

## Results and Observations

LoFreq was able to detect variants in ctDNA at low allele frequencies, but further validation showed that its sensitivity was limited when compared to other variant callers like **UMI-VarCal**. Specifically, LoFreq did not perform as well for variants with very low allele frequencies (0.1% or less), which impacted its ability to detect all of the **112 synthetic double-mutation ctDNA sequences** spiked into the data.

## Conclusion
LoFreq is a powerful tool for low-frequency variant detection, and its use in this project helped identify key variants at low frequencies in ctDNA samples. The optimization of LoFreq’s parameters, combined with UMI-based deduplication and error correction, allowed for improved sensitivity in detecting minimal residual disease after cancer treatment. However, in this project, I realized that other variant callers, such as **UMI-VarCal**, performed significantly better and was more effective in detecting low-frequency variants.
