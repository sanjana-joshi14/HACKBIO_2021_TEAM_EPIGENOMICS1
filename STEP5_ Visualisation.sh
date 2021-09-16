### A) Prepare the Datasets

### Filter only data for chr22:
grep -w "chr22" ENCFF933NTR.bed >> file_A.bed

### Extract filtered chrr22 (as c1)
grep c1 ENCFF933NTR_filt.bed > ENCFF933NTR_chr22.bed

### Replace c1 with chr22
sed 's/c1/chr22/' ENCFF933NTR_chr22.bed > ENCFF933NTR_CHR22genes.bed

### B)Convert bedgraph from MACS2 to bigwig
awk 'NR!=1' macs_output_treat_pileup.bdg > macs.deheader.bedGraph
sort -k1,1 -k2,2n macs.deheader.bedGraph > macs.sorted.bedGraph 
touch chrom22.sizes
nano hg19.chrom.sizes
### write only one line (tab delimited) in this file chr22 51304566
awk '{print $1,$2,$3,$4}' macs.sorted.bedGraph > macs.sorted.4.bedGraph
bedGraphToBigWig macs.sorted.4.bedGraph hg19.chrom.sizes macs.bw 

### C) Create heatmap of coverage at TSS with deepTool
### Remove the first header line from chr22.bed file
computeMatrix reference-point --referencePoint TSS -R chr22.bed -S macs.bw --missingDataAsZero -o output_from_computeMatrix.gz
### plotHeatmap
plotHeatmap -m output_from_computeMatrix.gz -out plotHeatMap.png
### Plotting CTCF peaks
computeMatrix reference-point --referencePoint center -R intergenic_ctcf_peaks_chr22 -S macs.bw --missingDataAsZero -o peak_output_from_computeMatrix.gz
plotHeatmap -m peak_output_from_computeMatrix.gz -out intragenic_plotHeatMap.png

### pyGenomeTracks
### Sort ENCFF933NTR.bed file-
sort -k 1,1 -k2,2n ENCFF933NTR.bed > ENCFF933NTR_sorted.bed
### Install pyGenomeTracks
conda -install -c bioconda pyGenomeTracks
### Visualize 
pyGenomeTracks --tracks config.ini --region chr22:37,193,000-37,252,000 -o Genome_track_plot.png

