#!/bin/bash

#SBATCH --account=bgmp                      ### SLURM account which will be charged for the job
#SBATCH --job-name=lofreqVP_seq             ### Job Name
#SBATCH --output=lofreq_BAM_%j.out          ### File in which to store job output
#SBATCH --error=lofreq_BAM-%j.err           ### File in which to store job error messages
#SBATCH --time=0-24:00:00                   ### Wall clock time limit in Days-HH:MM:SS
#SBATCH --nodes=1                           ### Node count required for the job
#SBATCH --cpus-per-task=4                   ### Number of cpus (cores) per task
#SBATCH --partition=bgmp                    ### partition to run things

conda activate /projects/bgmp/shared/groups/2022/79K/salish/envs/lofreq


# /usr/bin/time -v lofreq call -f hg38_formatted_nochr_.fasta -l chris_hg38.bed -o vcf.gz /projects/bgmp/shared/groups/2022/79K/salish/kespinoz/proj_salish_cfdna/Quality_Filter/Trimmed_Q25/BWA_25/original/test_Q25.sorted.bam

#JOB ID: lofreq_BAM-22915450

/usr/bin/time -v lofreq call --no-default-filter -A -B -a 1 -b 1 -f ../inputs/hg38_formatted_nochr_.fasta -l ../inputs/chris_hg38_reformatted.bed -o vcf.gz /projects/bgmp/shared/groups/2022/79K/salish/kespinoz/proj_salish_cfdna/Quality_Filter/Trimmed_Q25/BWA_25/original/test_Q25.sorted.bam