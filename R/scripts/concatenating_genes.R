install.packages("devtools")
devtools::install_github("tardipede/concatipede")


library(concatipede)

setwd("phylo_analysis/data/sequence_data/")


find_fasta()
files <- c("phylo_analysis/data/sequence_data//aligned_rbcL_chloro.fasta",
           "phylo_analysis/data/sequence_data//aligned_rps4_chloro.fasta")


concatipede_prepare(files, out = "seqnames")


concatipede(filename = "seqnames.xlsx",
            out = "concatenated_rbcL_rps4")
