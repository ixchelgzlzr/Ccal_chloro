###################################
# Make a quick Parsimony inference
###################################


library(ape)
library(phangorn)
library(ttutils)

# read the data
path  <- "phylo_analysis/data/coding_regions_no_Sphagnum.nexus"
path2 <- "phylo_analysis/data/introns_no_Sphagnum.nexus"
data  <- read.nexus.data(path)
data2 <- read.nexus.data(path2)

d <- merge(data, data2)

# convert into phyDat format
d    <- phyDat(data, type = "USER", levels = c("0", "1", "2", "3", "4", "5", "6", "7", "-"))

# parsimony inference
parsi_tree <- pratchet(data = d, minit = 1000)


# do the actran to assign branch lengths in number of changes
parsi_tree <- acctran(parsi_tree, d)

# parsimony score is 175


# plot
plotBS(root(parsi_tree, 34 ) )

#write.tree(parsi_tree, "output/parsimony_tree.tree")
#writeNexus(parsi_tree, "output/parsimony_tree_nexus.tree")

write.tree(parsi_tree, "output/parsimony_tree_no_sphag.tree")
writeNexus(parsi_tree, "output/parsimony_tree_nexus_no_sphag.tree")
