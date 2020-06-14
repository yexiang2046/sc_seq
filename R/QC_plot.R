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


sample <- readRDS(infile)
sample <- FindVariableFeatures(sample)


p1 <- JackStrawPlot(sample, dims = 1:20)
p2 <- ElbowPlot(sample)

p3 <- VariableFeaturePlot(sample)
p3 <- LabelPoints(plot = p3, points = head(VariableFeatures(sample), 10))
p4 <- VlnPlot(sample, features = c("nFeature_RNA", "nCount_RNA", "percent.mt"), group.by = "treatment")

dir.create(outdir)
tiff(paste0(outdir, "/JackStrawPlot.tiff"))
p1
dev.off()


tiff(paste0(outdir, "/Elbow_plot.tiff"))
p2
dev.off()

tiff(paste0(outdir, "/top_variables.tiff"))
p3
dev.off()


tiff(paste0(outdir, "/feature_qc.tiff"))
p4
dev.off()










