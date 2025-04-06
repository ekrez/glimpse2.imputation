#!/bin/bash
CHR=$1
MAP=/home/scglab/prog/glimpse/maps/genetic_maps.b38/chr${CHR}.b38.gmap.gz

SAMPLE=${2}
PANEL=/media/scglab/T7/Work/imputation/${SAMPLE}/1000GP.chr${CHR}.no${SAMPLE}.sites.vcf.gz
OUT=/media/scglab/T7/Work/imputation/${SAMPLE}/chunks.chr${CHR}.txt
/home/scglab/prog/glimpse/chunk/bin/GLIMPSE2_chunk --input ${PANEL} --region chr${CHR} --sequential --output ${OUT} --map ${MAP}
