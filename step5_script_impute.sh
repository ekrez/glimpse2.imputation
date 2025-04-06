#!/bin/bash


CHR=$1
SAMPLE=$2
cov=$3

cd ${SAMPLE}
mkdir GLIMPSE_impute.${cov}


REF=/media/scglab/T7/Work/imputation/${SAMPLE}/split/1000GP.chr${CHR}.no${SAMPLE}
BAM=/media/scglab/T7/Work/imputation/${SAMPLE}/${cov}/${SAMPLE}.bam
OUT=/media/scglab/T7/Work/imputation/${SAMPLE}/GLIMPSE_impute.${cov}/${SAMPLE}_imputed

while IFS="" read -r LINE || [ -n "$LINE" ]; 
do   
	printf -v ID "%02d" $(echo $LINE | cut -d" " -f1)
	IRG=$(echo $LINE | cut -d" " -f3)
	ORG=$(echo $LINE | cut -d" " -f4)
	CHR=$(echo ${LINE} | cut -d" " -f2)
	REGS=$(echo ${IRG} | cut -d":" -f 2 | cut -d"-" -f1)
	REGE=$(echo ${IRG} | cut -d":" -f 2 | cut -d"-" -f2)

	/home/scglab/prog/glimpse/phase/bin/GLIMPSE2_phase --bam-file ${BAM} --reference ${REF}_${CHR}_${REGS}_${REGE}.bin --output ${OUT}_${CHR}_${REGS}_${REGE}.bcf
done < /media/scglab/T7/Work/imputation/${SAMPLE}/chunks.chr${CHR}.txt
