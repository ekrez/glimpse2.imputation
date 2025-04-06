#!/bin/bash


CHR=$1
SAMPLE=$2
cov=$3

cd ${SAMPLE}

echo "chr${CHR} /media/scglab/T7/Work/imputation/${SAMPLE}/gnomad.genomes.r3.0.sites.chr${CHR}.isec.bcf /media/scglab/T7/Work/imputation/${SAMPLE}/${SAMPLE}.chr${CHR}.validation.bcf /media/scglab/T7/Work/imputation/${SAMPLE}/GLIMPSE_ligate.${cov}/${SAMPLE}_chr${CHR}_ligated.bcf" > concordance.lst

/home/scglab/prog/glimpse/concordance/bin/GLIMPSE2_concordance --input /media/scglab/T7/Work/imputation/${SAMPLE}/concordance.lst --min-val-dp 8 --output /media/scglab/T7/Work/imputation/${SAMPLE}/output --min-val-gl 0.9999 --bins 0.00000 0.00100 0.00200 0.00500 0.01000 0.05000 0.10000 0.20000 0.50000 --af-tag AF_nfe --thread 4

#cd plot;
#./concordance_plot.py


