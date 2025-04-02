FROM rocker/r-ver:4.3.0

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libhdf5-dev \
    libpng-dev \
    libtiff5-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libfontconfig1-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    libudunits2-dev \
    libgdal-dev \
    libgeos-dev \
    libproj-dev \
    && rm -rf /var/lib/apt/lists/*

# Install R packages with specific versions
RUN R -e "install.packages('devtools', repos='https://cloud.r-project.org/')"
RUN R -e "install.packages('BiocManager', repos='https://cloud.r-project.org/')"
RUN R -e "BiocManager::install(version = '3.18')"
RUN R -e "BiocManager::install(c('SingleCellExperiment', 'scater', 'scran', 'scRNAseq', 'SingleR'))"
RUN R -e "install.packages(c('Matrix', 'Matrix.utils'), repos='https://cloud.r-project.org/')"
RUN R -e "install.packages(c('tidyverse', 'ggplot2', 'dplyr', 'tidyr', 'hdf5r', 'SeuratObject', 'Seurat'), repos='https://cloud.r-project.org/')"

# Set working directory
WORKDIR /workspace


# Set environment variables
ENV R_LIBS=/usr/local/lib/R/site-library
ENV PATH=/usr/local/bin:$PATH
