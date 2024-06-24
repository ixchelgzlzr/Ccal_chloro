#-----------------------------------------------------------------------
# FIGURE WITH PARSIMONY STRUCTURAL, BAYESIAN STRUCTURAL, AND GENE TREES
#-----------------------------------------------------------------------

library(phytools)
library(ggpubr)
library(ggpubr)
library(ggtree)
library(viridis)
library(RevGadgets)
library(castor)

# PARSIMONY TREE

# parsimony structural
parsi <- read.tree("output/parsimony_tree_no_sphag.tree")

# adding edges so I can use reroot function
parsi$edge.length <- rep(1, 74)

# rerooting:
parsi <- reroot(parsi, 47)
plot(parsi)

# getting rid of edges
parsi$edge.length <- NULL
parsi$node.label <- round(parsi$node.label, 2)

# get rid of underscores
parsi$tip.label <- sub("_", " ", parsi$tip.label)


plot_parsi <- ggplot(ladderize(parsi), right = T) + geom_tree() +
  theme_tree() +
  hexpand(.35) +
  geom_tiplab( size = 3, fontface = 3) +
  geom_highlight(node = 43, fill= alpha('#1E9B8AFF', 0.5)) +  # Complex thalloids
  geom_highlight(node = 46, fill= alpha("grey20", 0.5))   +   # Aytoniaceae
  geom_highlight(node = 61, fill= alpha('#6DCD59FF', 0.5)) +   # leafy
  geom_nodelab( nudge_x = -0.01, size = 2.5, nudge_y = -0.15)

plot_parsi

# BAYESIAN INFERENCE WITH ONLY STRUCTURAL

# bayes structural
bayes_st <- RevGadgets::readTrees("phylo_analysis/output_for_paper/just_structural_assym_no_sphag/MCC_tree_1.tre")[[1]]

# get rid of underscores
bayes_st[[1]]@phylo$tip.label <- sub("_", " ", bayes_st[[1]]@phylo$tip.label)


# plot
plot_bayes <- ggplot(bayes_st[[1]], right = T) + geom_tree() +
  theme_tree() +
  hexpand(.35) +
  geom_tiplab(align=TRUE, linesize=.5,size = 3, fontface = 3) +
  geom_highlight(node = 45, fill='#1E9B8AFF', extendto = 0.2) +    # Complex thalloids
  geom_highlight(node = 47, fill="grey20", extendto = 0.2) +       # Aytoniaceae
  geom_highlight(node = 61, fill= '#6DCD59FF')  +                  # leafy
  geom_nodelab(aes(label=round(posterior, 2)), nudge_x = -0.01, size = 2.5, nudge_y = -0.15)

plot_bayes


# LIKELIHOOD INFERENCE WITH ONLY GENES

genes_tree <- castor::read_tree(string ="(Sphagnum_palustre:0.169078,(((((((Calasterella_californica:0.014938,((((Reboulia_hemisphaerica:0.006068,(Plagiochasma_intermedium:0.011206,Plagiochasma_appendiculatum:0.007231)100:0.007279)93:0.003602,Asterella_mussuriensis:0.010416)59:0.001055,(Asterella_wallichiana:0.015699,(Asterella_leptophyla:0.004013,Asterella_cruciata:0.004163)100:0.006498)57:0.002794)57:0.001725,(Mannia_fragans:0.00692,Mannia_controversa:0.007768)100:0.007883)100:0.007738)74:0.002404,(Cryptomitrium_himalayense:0.019318,Asterellopsis_grollei:0.012758)97:0.004295)100:0.019093,Conocephalum_conicum:0.02623)92:0.007746,Riccia_cavernosa:0.028266)100:0.021407,Sphaerocarpos_texanus:0.042464)99:0.021824,Blasia_pusilla:0.056611)100:0.032432,((((((Trichocolea_tomentella:0.047718,Bazzania_praerupta:0.082153)97:0.011251,(Plagiochila_chinensis:2.0E-6,Hebertus_dicranus:2.0E-6)100:0.037835)95:0.012597,(Scapania_ciliata:0.073497,Calypogeia_fissa:0.10685)86:0.00759)100:0.03521,(Schistochilia_macrodonta:0.111777,((Radula_japonica:0.117406,(((Ptychanthus_striatus:0.022883,(Cololejeunea_lanciloba:2.0E-6,Cheilolejeunea_xanthocarpa:2.0E-6)100:0.02882)100:0.059106,Jubula_hutchinsiae:0.060183)98:0.020828,Frullania_nodulosa:0.062158)100:0.021658)97:0.018648,Ptilidium_ciliare:0.036941)65:0.004201)85:0.009722)97:0.014912,((Riccardia_latifrons:0.127308,(Aneura_pinguis:0.015527,Aneura_mirabilis:0.024991)100:0.124071)99:0.029803,Metzgeria_leptoneura:0.102834)100:0.05049)65:0.006283,(Pellia_endiviifolia:0.0854,(Makinoa_crispata:0.096948,Fossombronia_cristula:0.126735)92:0.021582)75:0.012587)99:0.034472)99:0.032092,(Treubia_lacunosa:0.109256,Haplomitrium_mnioides:0.20845)88:0.016199);")

genes_tree <- drop.tip(genes_tree, "Sphagnum_palustre")

genes_tree$tip.label <- sub("_", " ", genes_tree$tip.label)

plot_genes <- ggplot(ladderize(genes_tree), right = T) + geom_tree() +
  theme_tree() +
  hexpand(.35) +
  geom_tiplab(align=TRUE, linesize=.5, size = 3, fontface = 3) +
  geom_highlight(node = 63, fill='#1E9B8AFF', extendto = 0.302202) +       # Complex thalloids
  geom_highlight(node = 67, fill="grey20", extendto = 0.302202) +          # Aytoniaceae
  geom_highlight(node = 50, fill= '#6DCD59FF', extendto = 0.302202) +      # leafy
  geom_highlight(node = 41, fill= '#440154FF', extendto = 0.302202) +      # haplomitriales
  geom_highlight(node = 47, fill= '#FDE725FF', extendto = 0.302202) +      # Metzgeriales
  geom_highlight(node = 45, fill= '#38598CFF', extendto = 0.302202)  +      # Fossombroniales
  geom_nodelab(nudge_x = -0.01, size = 2.5, nudge_y = -0.15)



plot_genes


# ALL THE TREES TOGETHER

ggarrange(plot_parsi, plot_bayes, plot_genes, ncol = 3,
          labels = c("a) Structural-Parsimony", "b) Structural-Bayesian", "c) Sequence data"),
          font.label = list(size = 12))



