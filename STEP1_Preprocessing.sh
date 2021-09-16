### STEP 1 :- PREPROCESSING
### A) Dataset
wget https://zenodo.org/record/3862793/files/ENCFF933NTR.bed.gz
wget https://zenodo.org/record/3862793/files/SRR891268_chr22_enriched_R1.fastq.gz
wget https://zenodo.org/record/3862793/files/SRR891268_chr22_enriched_R2.fastq.gz

### B) Obtain Annotation for hg38 genes
### Go to [http://genome.ucsc.edu/cgi-bin/hgTables](http://genome.ucsc.edu/cgi-bin/hgTables) and set the parameters as-
### clade:Mammal
### genome:Human
### assembly:Dec. 2013(GRCh38/hg38)
### group:Genes and Gene Prediction
### track:All GENCODE V37
### table:Basic
### region:position chr22
### output format:all fields from selected table
### output filename:chr22
### file type returned:gzipped compressed
### Converting chr22 file into a bed file:
unzip chr22.gz 
awk -F "\t" 'OFS="\t" {print $3, $5, $6, $13, $12, $4 > ("chr22.bed")}' chr22 

### C) Quality Control
sudo apt install default-jre
sudo apt install default-jdk
### Make the “fastqc” an executable file
chmod 755 fastqc
### Run the fastqc on all sequenced reads
fastqc SRR891268_chr22_enriched_R1.fastq SRR891268_chr22_enriched_R2.fastq 
### Trimming Read
### Adapter Trimming
$ sudo apt install cutadapt
cutadapt -a CTGTCTCTTATACACATCTCCGAGCCCACGAGAC -A CTGTCTCTTATACACATCTGACGCTGCCGACGA --minimum-length 20 -q 20 -o trimmed_1.fastq -p trimmed_2.fastq SRR891268_chr22_enriched_R1.fastq SRR891268_chr22_enriched_R2.fastq
