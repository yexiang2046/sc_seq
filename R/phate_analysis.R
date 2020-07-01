#!/usr/bin/env Rscript
library(Seurat)
library(phateR)
library(reticulate)

use_python("/Users/xiangye/.pyenv/shims/python3")


args = commandArgs(trailingOnly=TRUE)



# test if there is at least two argument: if not, return an error
if (length(args) < 2) {
  stop("At least two arguments must be supplied (input file).n", call.=FALSE)
} 


infile = args[1]
outfile = args[2]


SLE_tcell <- readRDS(infile)

phate_sle <- phate(data = SLE_tcell@assays$integrated@data)


save(phate_sle, args[2])


