#!/usr/bin/env Rscript
library(SingleR)



args = commandArgs(trailingOnly=TRUE)

# test if there two arguments: if not, return an error
if (length(args) != 2) {
  stop("Input and output files must be supplied (input file).n", call.=FALSE)
} 

infile = args[1]
outfile = args[2]


sample <- readRDS(infile)


mm.immu <- ImmGenData()

log_counts <- sample@assays$integrated@data


pred.mm.immu <- SingleR(test = log_counts, ref = mm.immu, labels = mm.immu$label.fine)

saveRDS(pred.mm.immu, outfile)

