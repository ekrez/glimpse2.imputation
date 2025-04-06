#!/bin/bash

CHR=$1
SAMPLE=$2
cd ${SAMPLE}
mkdir split



MAP=/home/scglab/prog/glimpse/maps/genetic_maps.b38/chr${CHR}.b38.gmap.gz
REF=/media/scglab/T7/Work/imputation/${SAMPLE}/1000GP.chr${CHR}.no${SAMPLE}.bcf



while IFS="" read -r LINE || [ -n "$LINE" ]; 
do   
	printf -v ID "%02d" $(echo $LINE | cut -d" " -f1)
	IRG=$(echo $LINE | cut -d" " -f3)
	ORG=$(echo $LINE | cut -d" " -f4)


	/home/scglab/prog/glimpse/split_reference/bin/GLIMPSE2_split_reference --reference ${REF} --map ${MAP} --input-region ${IRG} --output-region ${ORG} --output ./split/1000GP.chr${CHR}.no${SAMPLE}
done < chunks.chr${CHR}.txt
