### A) Filter Uninformative Reads
### filter out uninformative reads 
samtools view -q 30 -f 0x2 -b -h Aligned_output.sam > Filtered_output.bam

### B) Filter duplicate reads
### Download picard.jar in your working folder from (https://github.com/broadinstitute/picard/releases/download/2.26.0/picard.jar)
java -jar picard.jar -h

### Sorting the output file
samtools sort -T temp -O bam -o filtered_output_sorted.bam Filtered_output.bam

java -jar picard.jar MarkDuplicates I=filtered_output_sorted.bam O=marked_dup.bam M=marked_dup.metrics.txt 

### C) Check Insert Sizes
sudo apt install r-base
java -jar picard.jar CollectInsertSizeMetrics I=marked_dup.bam O=chart.txt H=insertSizePlot.pdf M=0.5
