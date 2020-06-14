#!/usr/bin/env Rscript
library(Seurat)
library(plyr)



args = commandArgs(trailingOnly=TRUE)



# test if there two arguments: if not, return an error
if (length(args) != 2) {
  stop("Input and output files must be supplied (input file).n", call.=FALSE)
} 

infile = args[1]
outfile = args[2]


sample <- readRDS(infile)
#sample <- NormalizeData(sample, verbose = TRUE)
sample <- ScaleData(sample, verbose = FALSE)


sample <- RunPCA(sample, npcs = 50, seed.use = 42)
sample <- JackStraw(sample, num.replicate = 100)
sample <- ScoreJackStraw(sample, dims = 1:20)
sample <- RunUMAP(sample, n.neighbors = 30L, dims = 1:30)

treatment <- colnames(sample)
sam_id <- sapply(treatment, function(x){strsplit(x, "-")}[[1]][2])

sample$treatment <- plyr::mapvalues(sam_id, 1:6, c("con_unsti", "con_sti_dmso", "con_sti_CB839", "SLE_unsti", "SLE_sit_dmso", "SLE_sit_CB839"))
sample$treatment <- factor(sample$treatment, levels = c("con_unsti", "con_sti_dmso", "con_sti_CB839", "SLE_unsti", "SLE_sit_dmso", "SLE_sit_CB839"))

sample <- FindNeighbors(sample, dims = 1:30)
sample <- FindClusters(sample, resolution = 0.8)

saveRDS(sample, outfile)














