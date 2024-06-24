#################################################
# Trying to map traits in molecular phylogeny
# using most parsimonious reconstruction
#################################################

library(readxl)
library(viridis)
library(ape)
library(dplyr)
library(tidyr)
library(tidyverse)

# read the molecular tree
tree <- read.tree("phylo_analysis/data/sequence_data/concatenated_rbcL_rps4/partitions.nex.treefile")

tree$node.label <- NULL
tree <- root(tree, "Sphagnum_palustre")


# Read the characters
markers <- read_excel("data/structure_data.xlsx", sheet = "markers_numeric")

# get rid of the first two rows that dont have marker data
markers <- markers [3:nrow(markers), 1:(ncol(markers)-1)]

# get the number of states per markers
lengths <- vector()

for (i in 1:ncol(markers)){
  lengths[i] <- nrow(unique(as.data.frame(markers[ , i])))
}

names(lengths) <- colnames(markers)

# get the markers that are variable
multistate <- subset(lengths, lengths>1)
multistate <- multistate [-1]

multistate_names <- names(multistate)

variable_markers <- markers %>% select(multistate_names)

####################################
# Now using Phangorn               #
# which actually works much better #
####################################

library(phangorn)

# # markers for figure:
# selected_markers_figure <- c( "ycf45",
#                           "cysA", "trnG-GCC",
#                           "cemA", "ndhJ",
#                          "trnP-GGG"
#                          )
#

# Select the variable markers
mark_test <- as.data.frame( markers %>% select(all_of(multistate_names)) )

# Put the selection in the format that phyDat wants
row.names(mark_test) <- markers$Species
mark_test <- as.data.frame( t(mark_test) )

# convert to a phyDat object, specifying the levels
markers_phyDat <-  phyDat(mark_test, type = "USER", levels= c("0","1", "2", "3", "4", "5", "6", "7", "9"))

# Make the most parsimonious anc map
anc.mpr <- ancestral.pars(tree, markers_phyDat, "MPR")
# anc.acctran <- ancestral.pars(tree, markers_phyDat, "ACCTRAN")

# ladderize the tree
tree <- ladderize(tree)

# specify colors from the Viridis palette
colors <-  c("#27AD81FF",  "#FDE725FF", "#440154FF", "#AADC32FF", "#5DC863FF", "#21908CFF", "#2C728EFF","#472D7BFF", "#3B528BFF")


# get the index of the markers that share a pattern
# remember that phyDat format saves patterns and not all characters, so with the index
# I can relate origincal characters to the patterns stored in phyDat

attr <- attributes(markers_phyDat)
ind <- attr$index
names(ind) <- rownames(mark_test)

# organize plots
par(mfrow=c(2,4), mai = c(0.2, 0.2, 0.8, 0.2))

# plot all the trees
for ( i in 1:length(markers_phyDat[[1]])){
  plotAnc(tree, anc.mpr, cex.pie = 0.7, i, col = colors, pos = NULL )
  labs <- names( ind[ind==i] )
  title(labs, font.main= 1)

}





###############################
# Now plots for the introns
#############################

# OK, introns is working!


# Read the characters
introns <- read_excel("data/structure_data.xlsx", sheet = "introns",  col_types = "text")
#introns <- introns %>% select(-total_introns)

# make a copy of introns
introns.df <- introns


# Put the introns in the format that phyDat wants
row.names(introns.df) <- introns.df$Species
introns.df <- as.data.frame( t(introns.df) )
introns.df <- introns.df[-1 , ]


# convert to a phyDat object, specifying the levels
introns_phyDat <-  phyDat(introns.df, type = "USER", levels = c("0", "1", "NA") )


# Make the most parsimonious anc map
introns.mpr <- ancestral.pars(tree, introns_phyDat, "MPR")




# for ( i in 1:nrow(introns.df)){
#   print( unlist(unique(as.vector(introns.df[i,]))) )
# }


# specify colors from the Viridis palette
colors_int <-  c("#27AD81FF",  "#FDE725FF", "#440154FF")



# get the index of the markers that share a pattern
# remember that phyDat format saves patterns and not all characters, so with the index
# I can relate origincal characters to the patterns stored in phyDat

attr_int <- attributes(introns_phyDat)
ind_int <- attr_int$index
names(ind_int) <- rownames(introns.df)




# organize plots
par(mfrow=c(2,4), mai = c(0.2, 0.2, 0.8, 0.2))



# plot all the trees
for ( i in 1:length(introns_phyDat[[1]])){
  plotAnc(tree, introns.mpr, cex.pie = 0.7, i, col = colors_int, pos = NULL )
  labs <- names( ind_int[ind_int==i] )
  title(labs, font.main= 1)

}





plotAnc(tree, introns.mpr, cex.pie = 0.7, 1, col = colors_int, pos = NULL )





##################
# extra, using Ape
# the function for ancestral reconstruction is really weird
# don't trust it
##################

selected_markers <- c( "ndhB", "ndhF", "trnL-CAA", "ycf66", "trnS-CGA", "ycf45","trnS-GCU",
                       "psbl", "trnK-UUU", "psbK", "orf50" , "psbD-frag", "cysA", "psbD", "trnG-UCC_2", "trnG-GCC" ,
                       "ndhJ","ndhK","ndhC" ,"trnk-UUU_3",  "cemA",
                       "trnS-AGA" ,  "trnE-UUC_2" ,"trnN-GUU"  , "ndhF_2", "ndhB_2", "cysT","trnP-GGG",
                       "ndhD" ,"ndhE" ,"ndhG","ndhI" ,"ndhA", "ndhH", "rps15", "chlL" )

selected_markers_2 <- c( "ndhF", "trnS-CGA", "ycf45",
                         "trnK-UUU", "orf50" , "psbD-frag", "cysA", "trnG-UCC_2",
                         "trnk-UUU_3",  "cemA",
                         "ndhB_2", "cysT","trnP-GGG",
                         "rps15")



# empty list
rec <- vector(mode = "list")
m_names <- vector()
index <- 1

#Generate the character vectors in a loop
for (i in 2:ncol(markers)){

  # get the name of the column
  cname <- colnames(markers[i])

  # if the column is multistate
  if (cname %in% selected_markers_2){

    m_names <- c(m_names, cname)

    # get a vector of the states
    v <- as.vector(unlist(markers[ , i]) )

    # name it with the species
    names(v) <- markers$Species
    #print(v)

    # do the Most parsimonious reconstruction for that character
    r <- MPR(v, tree, outgroup = "Sphagnum_palustre")
    #print(r)
    # # save it in the list
    rec[[index]] <- MPR(v, tree, outgroup = "Sphagnum_palustre")
    index <- index + 1

  }
}




length(rec) == length(m_names)


source("scripts/functions/plot_anc_states.R")

par(mfrow=c(1,1))

for (i in 1:length(rec)){
  plot_anc_state(tree, rec[[i]])
  title( m_names[[i]])

}

