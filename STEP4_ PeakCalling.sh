### convert bam file to bed file using bamtools:
bedtools bamtobed -i marked_dup.bam > marked_dup.bed

### Install macs2:
conda install -c bioconda macs2

### Peak Calling:
macs2 callpeak -t marked_dup.bed -n macs_output -g 50818468 --nomodel --shift -100 --extsize 200 --keep-dup all --call-summits --bdg

###  5 output files-
### -Macs_output_control_lambda.bdg -macs_output_peaks.narrowPeak -Macs_output_peaks.xls 
### -Macs_output_summits.bed -macs_output_treat_pileup.bdg
