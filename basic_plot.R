#!/usr/bin/env Rscript
library(Seurat)



args = commandArgs(trailingOnly=TRUE)



# test if there is at least one argument: if not, return an error
if (length(args) != 2) {
  stop("Input and output files must be supplied (input file).n", call.=FALSE)
} 

infile = args[1]
outdir = args[2]


sample <- readRDS(infile)


p1 <- DimPlot(sample, reduction = "umap", group.by = "treatment")
p2 <- DimPlot(sample, reduction = "umap", group.by = "treatment", split.by = "treatment")


tiff("umap_plot/treatment_umap.tiff")
p1
dev.off()


tiff(paste0(outdir, "/treatment_umap_split.tiff"))
p2
dev.off()










