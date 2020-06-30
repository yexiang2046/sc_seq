library(Seurat)


args = commandArgs(trailingOnly=TRUE)



# test if there two arguments: if not, return an error
if (length(args) != 4) {
  stop("Input and output files must be supplied (input file).n", call.=FALSE)
} 

infile = args[1]
outfile = args[2]
cluster1 = args[3]
cluster2 = args[4]

sample <- readRDS(infile)
markers <- FindMarkers(sample, ident.1 = cluster1, ident.2 = cluster2)


saveRDS(markers, outfile)



