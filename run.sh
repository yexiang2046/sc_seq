#!/bin/bash


./R/intergrarte_samples.R Count/4738-KV-1/filtered_feature_bc_matrix Count/4738-KV-2/filtered_feature_bc_matrix Count/4738-KV-3/filtered_feature_bc_matrix Count/4738-KV-4/filtered_feature_bc_matrix Count/4738-KV-5/filtered_feature_bc_matrix Count/4738-KV-6/filtered_feature_bc_matrix

./R/umap.R integrated_seurat.rds int_umap.rds


./R/QC_plot.R int_umap.rds QC_plot

./R/basic_plot.R int_umap.rds umap_plot Rorc Tbx21 Sell Il2ra Il17a Il17f Foxp3 Gata3
