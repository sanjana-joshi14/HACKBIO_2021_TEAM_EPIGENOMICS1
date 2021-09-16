### Pulling the sequence for chromosome 22 for indexing and mapping
wget --timestamping ;ftp://hgdownload.cse.ucsc.edu/goldenPath/hg38/chromosomes/chr22.fa.gz; -O chr22.fa.gz

### For mapping to chr22
### Create index for Chromosome 22
bowtie2-build chr22.fa.gz indexed_chr22

### Start mapping for the parameters specified by Galaxy
bowtie2 --very-sensitive --maxins 1000 --dovetail -x indexed_chr22 -1 trimmed_1.fastq -2 trimmed_2.fastq -S Aligned_output.sam
