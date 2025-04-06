#!/bin/bash


CHR=$1
SAMPLE=$2
cov=$3

cd ${SAMPLE}
mkdir GLIMPSE_ligate.${cov}

LST=GLIMPSE_ligate.${cov}/list.chr${CHR}.txt
ls -1v GLIMPSE_impute.${cov}/${SAMPLE}_imputed_*.bcf > ${LST}

OUT=GLIMPSE_ligate.${cov}/${SAMPLE}_chr${CHR}_ligated.bcf

/home/scglab/prog/glimpse/ligate/bin/GLIMPSE2_ligate.${cov} --input ${LST} --output $OUT
