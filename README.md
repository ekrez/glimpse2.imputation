./create.bam.1x.sh 20 HG00269 

./step3_script_chunk.sh 20 HG00269

./step4_script_split_reference.sh 20 HG00269

./step5_script_impute.sh 20 HG00269 1x

./step6_script_ligate.sh 20 HG00269 1x

./step7_script_concordance.sh 20 HG00269 1x
