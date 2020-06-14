#!/usr/bin/env Rscript
library(Seurat)




args = commandArgs(trailingOnly=TRUE)



# test if there is at least two argument: if not, return an error
if (length(args) < 2) {
  stop("At least two arguments must be supplied (input file).n", call.=FALSE)
} 


outfile = "integrated_seurat.rds"

samples = list(length(args))
samples_s = list(length(args))
for (i in seq_along(args)){
	samples[[i]] <- Read10X(data.dir = args[i], gene.column = 2, unique.features = TRUE)
	colnames(samples[[i]]) <- paste0(colnames(samples[[i]]), "-", i)
	samples_s[[i]] <- CreateSeuratObject(samples[[i]], project = "Lupus_CD4", min.cells = 3, min.features = 500)
	samples_s[[i]] <- NormalizeData(samples_s[[i]], verbose = TRUE)
	samples_s[[i]] <- FindVariableFeatures(samples_s[[i]], select.method = "vst", nfeatures = 2000, verbose = FALSE)
}




archors_cca <- FindIntegrationAnchors(samples_s, dims = 1:30)

samples_integrated <- IntegrateData(archors_cca)

saveRDS(samples_integrated, outfile)

