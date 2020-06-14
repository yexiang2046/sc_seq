#!/usr/bin/env Rscript
library(Seurat)




args = commandArgs(trailingOnly=TRUE)



# test if there is at least two argument: if not, return an error
if (length(args) < 2) {
  stop("At least two arguments must be supplied (input file).n", call.=FALSE)
} 


outfile = args[1]
dir.create(outfile)

samples = list(length(args) - 1)
samples_s = list(length(args) - 1)
for (i in 2:length(args)){
	samples[[i]] <- Read10X(data.dir = args[i], gene.column = 2, unique.features = TRUE)
	colnames(samples[[i]]) <- paste0(colnames(samples[[i]]), "-", i)
	samples_s[[i]] <- CreateSeuratObject(samples[[i]], project = "Lupus_CD4", min.cells = 0, min.features = 0)
	samples_s[[i]][["percent.mt"]] <- PercentageFeatureSet(samples_s[[i]], pattern = "mt-")
	samples_s[[i]] <- NormalizeData(samples_s[[i]], verbose = TRUE)
	tiff(filename = paste0(outfile, '/S', i, "mt.tiff"))
		VlnPlot(samples_s[[i]], features = "percent.mt")
	dev.off()
}




