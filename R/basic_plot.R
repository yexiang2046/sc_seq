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
p5 <- DimPlot(sample, reduction = "umap", group.by = "seurat_clusters", split.by = "treatment", ncol = 3) + geom_density_2d(aes(sample@reductions$umap@cell.embeddings[,1], sample@reductions$umap@cell.embeddings[,2]), stat = "density2d")
p6 <- DimPlot(sample, reduction = "umap", group.by = "seurat_clusters", label = TRUE) + geom_density_2d(aes(sample@reductions$umap@cell.embeddings[,1], sample@reductions$umap@cell.embeddings[,2]), stat = "density2d")
p7 <- DimPlot(sample, reduction = "umap", group.by = "seurat_clusters", split.by = "seurat_clusters", ncol = 3) + geom_density_2d(aes(sample@reductions$umap@cell.embeddings[,1], sample@reductions$umap@cell.embeddings[,2]), stat = "density2d")
p8 <- DimPlot(sample, reduction = "umap", group.by = "seurat_clusters", split.by = "seurat_clusters", ncol = 3) 


p3 <- FeaturePlot(sample, reduction = "umap", features = genes)
p4 <- VlnPlot(sample, genes, group.by = "treatment")
p9 <- VlnPlot(sample, genes, group.by = "seurat_clusters")

tiff("umap_plot/treatment_umap.tiff", width = 1200, height = 1200)
p1
dev.off()


tiff(paste0(outdir, "/treatment_umap_split.tiff"), width = 1200, height = 1200)
p2
dev.off()

tiff(paste0(outdir, "/marker_genes.tiff"), width = 1200, height = 1200)
p3
dev.off()


tiff(paste0(outdir, "/vln_marker_genes.tiff"), width = 1200, height = 1200)
p4
dev.off()
tiff(paste0(outdir, "/split_umap_cluster.tiff"), width = 1200, height = 1200)
p5
dev.off()
tiff(paste0(outdir, "/umap_cluster.tiff"), width = 1200, height = 1200)
p6
dev.off()
tiff(paste0(outdir, "/umap_cluster_split_coutour.tiff"), width = 1200, height = 2000)
p7
dev.off()
tiff(paste0(outdir, "/umap_cluster_split.tiff"), width = 1200, height = 2000)
p8
dev.off()
tiff(paste0(outdir, "/vln_marker_genes_split_cluster.tiff"), width = 4800, height = 2000)
p9
dev.off()











