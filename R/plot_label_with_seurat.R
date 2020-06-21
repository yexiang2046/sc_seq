library(Seurat)
library(SingleR)
library(tidyverse)


sample <- readRDS("int_umap.rds")

label <- readRDS("singler_label.fine.rds") %>% data.frame() %>% rownames_to_column()


meta <- sample@meta.data %>% rownames_to_column()

meta <- left_join(meta, label[,c(1, 258)], by = "rowname")

meta <- meta %>% column_to_rownames()

celltype_other <- table(meta$labels) %>% data.frame() %>% arrange(Freq) %>% filter(row_number() < 92)
celltype_label <- celltype_other$Var1
meta$labels <- plyr::mapvalues(meta$labels, 
                               from = celltype_label,
                               to = rep("others", 91))

sample@meta.data <- meta

DimPlot(sample, reduction = "umap", group.by = "labels")
DimPlot(sample, reduction = "umap", group.by = "labels", split.by = "labels", ncol = 9)
