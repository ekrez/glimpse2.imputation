#!/bin/bash 

CHR=$1
SAMPLE=$2

#get gnomed from https://gnomad.broadinstitute.org/downloads
full_gnomad=/home/scglab/Downloads/gnomad.genomes.v4.1.sites.chr20.vcf.bgz
validation_sample=/media/scglab/T7/Work/imputation/${SAMPLE}/${SAMPLE}.chr${CHR}.validation.bcf

sites=/media/scglab/T7/Work/imputation/${SAMPLE}/gnomad.genomes.r3.0.sites.chr${CHR}.bcf
val_sites=/media/scglab/T7/Work/imputation/${SAMPLE}/gnomad.genomes.r3.0.sites.chr${CHR}.isec.bcf


bcftools annotate -i 'TYPE="snp" && INFO/AF_nfe!="." && INFO/AF_afr!="."' -x^INFO/AF_nfe,^INFO/AF_afr -Ob -o ${sites} ${full_gnomad}
echo "Done annotate"
bcftools index ${sites}
bcftools isec -n=2 -w1 -Ob -o ${val_sites} ${sites} ${validation_sample}


