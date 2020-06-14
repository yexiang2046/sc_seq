#!/usr/bin/env Rscript
library(Seurat)
library(ggplot2)



args = commandArgs(trailingOnly=TRUE)



# test if there is at least one argument: if not, return an error
if (length(args) < 2) {
  stop("Input and output files must be supplied (input file).n", call.=FALSE)
} 

infile = args[1]
outdir = args[2]
genes = args[3:length(args)]


sample <- readRDS(infile)


p1 <- DimPlot(sample, reduction = "umap", group.by = "treatment") + geom_density_2d(aes(sample@reductions$umap@cell.embeddings[,1], sample@reductions$umap@cell.embeddings[,2]), stat = "density2d")
p2 <- DimPlot(sample, reduction = "umap", group.by = "treatment", split.by = "treatment", ncol = 3) + geom_density_2d(aes(sample@reductions$umap@cell.embeddings[,1], sample@reductions$umap@cell.embeddings[,2]), stat = "density2d")


p3 <- FeaturePlot(sample, reduction = "umap", features = genes)

tiff("umap_plot/treatment_umap.tiff")
p1
dev.off()


tiff(paste0(outdir, "/treatment_umap_split.tiff"))
p2
dev.off()

tiff(paste0(outdir, "/marker_genes.tiff"))
p3
dev.off()









