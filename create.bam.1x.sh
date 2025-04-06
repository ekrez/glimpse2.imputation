#!/bin/bash 

#run ./create.bam.sh CHR SAMPLE_NAME
#for grch38


CHR=$1
sample=$2


mkdir ${sample}
REFGEN=/media/scglab/T7/Work/data/grch38.fasta/chr${CHR}.fa

inputcram=/media/scglab/T7/Work/data/for.imputation/${sample}.final.cram

out_dir=/media/scglab/T7/Work/imputation/${sample}
BAM=${out_dir}/${sample}.chr${CHR}.bam
OUT=${out_dir}/${sample}.chr${CHR}.validation.bcf


VCF=/media/scglab/T7/Work/data/1000GP.grch38/${CHR}/CCDG_14151_B01_GRM_WGS_2020-08-05_chr${CHR}.filtered.shapeit2-duohmm-phased.vcf.gz
TSV=${out_dir}/1000GP.chr${CHR}.no${sample}.sites.tsv.gz



#make ideal file
samtools view -T ${REFGEN} -bo ${BAM} ${inputcram} chr${CHR}
samtools index ${BAM}

echo "done"
#exclude indels and sample
bcftools norm -m -any ${VCF} -Ou --threads 4 | bcftools view -m 2 -M 2 -v snps -s ^${sample} --threads 4 -Ob -o ${out_dir}/1000GP.chr${CHR}.no${sample}.bcf
bcftools index -f ${out_dir}/1000GP.chr${CHR}.no${sample}.bcf --threads 4

echo "done"
#list of sites
bcftools view -G -m 2 -M 2 -v snps ${out_dir}/1000GP.chr${CHR}.no${sample}.bcf -Oz -o ${out_dir}/1000GP.chr${CHR}.no${sample}.sites.vcf.gz 
bcftools index -f ${out_dir}/1000GP.chr${CHR}.no${sample}.sites.vcf.gz 

echo "done"
bcftools query -f'%CHROM\t%POS\t%REF,%ALT\n' ${out_dir}/1000GP.chr${CHR}.no${sample}.sites.vcf.gz| bgzip -c > ${TSV} 
tabix -s1 -b2 -e2 ${TSV}

echo "done"
bcftools mpileup -f ${REFGEN} -I -E -a 'FORMAT/DP' -T ${VCF} -r chr${CHR} ${BAM} -Ou | bcftools call -Aim -C alleles -T ${TSV} -Ob -o ${OUT}
bcftools index -f ${OUT}


cd ${sample}
mkdir 1x
#echo "done"
#downsample genome
 samtools view -T ${REFGEN} -s 1.03045 -bo ${out_dir}/1x/${sample}.bam ${BAM} chr${CHR}
 samtools index  ${out_dir}/1x/${sample}.bam

