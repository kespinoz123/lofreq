#!/bin/bash

#SBATCH --account=bgmp                  ### SLURM account which will be charged for the job
#SBATCH --job-name=lofreqDeduped_seq    ### Job Name
#SBATCH --time=30-0                     ### Wall clock time limit in Days-HH:MM:SS (for 30 days - 0 hours)
#SBATCH --cpus-per-task=4               ### Number of cpus (cores) per task
#SBATCH --partition=bgmp                ### partition to run things

conda activate /projects/bgmp/shared/groups/2022/79K/salish/envs/lofreq

#lofreq call -f ref.fa -o vars.vcf aln.bam

/usr/bin/time -v lofreq call -f ../inputs/hg38_formatted_nochr_.fasta -l ../inputs/chris_hg38_reformatted.bed -o vcf.gz /projects/bgmp/shared/groups/2022/79K/salish/kespinoz/proj_salish_cfdna/Deduping/sorted.deduped_Q25.bam

