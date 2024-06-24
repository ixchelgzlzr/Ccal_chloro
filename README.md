# Data and scripts for the paper "The chloroplast genome of _Calasterella californica_ in relation to structural genomic evolution in liverworts" 
Submitted to **Molecular Phylogenetics and Evolution**

### Abstract

DNA sequences evolve not only through changes in individual nucleotides,
but also through the gain, loss, movement, or transformation of genes or
sets of genes. In the chloroplast genome, many of these structural changes
are diagnostic of large clades; and thus, there have been studies that have
used structural changes as characters for phylogenetic analysis of land plants.
Thanks to a recent increase in the availability of chloroplast genomes, it is
now possible to study the evolution of these structural changes in historically
understudied groups like liverworts. In this paper, we report the de novo assembly of the chloroplast genome of _Calasterella californica_, and compare
it to the plastome of 38 other species of liverworts. Furthermore, we use a
combination of phylogenetic inference and stochastic mapping tools to assess 
the use of chloroplast structural changes in phylogenetic inference, and
to better understand the evolutionary patterns of these traits. Overall, the
gene content and gene arrangement is very conserved in the chloroplast of
liverworts. The phylogenetic inferences based on structural-changes-only are
able to retrieve some of the larger clades of liverworts (like Aytoniaceae, or
the complex thalloids lineage) but disagree with our current understanding
of liverwort phylogenetic relationships, which is based on inferences from
nucleotide evolution models. These disagreements appear to be driven by
the convergent loss of sets of genes potentially associated with the evolution 
of epiphytic and parasitic life styles (like in the case of _Aneura mirabilis_
and _Treubia lacunosa_). We found that, congruent with our expectations,
structural changes (_i.e._, gene gain/loss) evolve slower than nucleotides. Nevertheless 
our ancestral state reconstructions suggest that structural evolution
can be complex, especially for genes that can be “multistate’—_e.g._, in the
case of pseudogenization and tRNAs—for whom evolutionary rates are comparable 
to nucleotide substitution rates. While inferences from structural
evolution alone partially conflict with inferences from nucleotide evolution,
inferences with structural and nucleotide data together produce hypotheses
with higher support. In this sense, the use of structural data might still be
relevant for inferring the relationship of some groups. Finally, we argue that
a better understanding of the processes that drive structural evolution will
help to build evolutionary models more adequate for this type of data.


---

### This repository contains three main folders

#### 1) R - It contains all the scripts of the analyses and figures done in R

|- **data**  
|---- Corrected_C_californica_chloroplast_genome.gb - **Reference genome of _C. californica_**.  
|---- Coverage.csv - data to generate the coverage plot.  
|---- length_data_short.csv - data to generate chloroplasts comparison plot.  
|---- structure_data.xlsx - this is the main dataset of structural information. It contains matrices of presence/abscence of genes and introns.  
  
|-**scripts**  [with self explanatory names and plenty of comments]  
|---- check_convergence.R - Check topological convergence of MCMCs from RevBayes.  
|---- concatenating_genes.R - To concatenate rbcl and rps2 alignments for the nucleotide based inferences.  
|---- coverage_plot.R - script to produce figure C.5 of the manuscript.  
|---- Introns_figure.R - called by structure_all.R.  
|---- Parsimony_analysis.R  
|---- post_processing_stoch_maps.R - takes the output of stoch maps from RevBayes and produces figs in App E and F.  
|---- presence-abscence_figure.R - called by structure_all.R.  
|---- rates_distributions_figure.R - produces Fig.4 of the manuscript.  
|---- Size_comparison_plot_3.R - produces Fig. D.6 of the manuscript.  
|---- structure_all.R - produces Fig. 2 of the manuscript.  
|---- three_phylogenies.R - produces Fig. 23 of the manuscript.  


#### 2) seq_phylo_analyses 

This folder contains the sequence data necessary to run iqtree on rps4 and rbcL for liverworts. To replicate our analyses, you can run the line below:

`iqtree -s sequence_data/concatenated_rbcL_rps4/concatenated_rbcL_rps4.phy -spp sequence_data/concatenated_rbcL_rps4/partitions.nex -m GTR+I+G -bb 1000`

#### 3) structural_phylo_analysis

This folder contains the scripts necessary to perform the phylogenetic analyses based on structural data. These analyses were set up in RevBayes v1.2.4.  

Notice that the stochastic map script runs on a fixed topology inferred from sequence data, stored in data/sequence_data/concatenated_rbcL_rps4/partitions.nex.treefile.  
  
|-**data**
|--- coding_regions_no_Sphagnum.nexus  
|--- introns_no_Sphagnum.nexus  
|--- sequence_data - folder that contains the genes alignments for the combined analysis.  

|-**scripts**  [with self explanatory names and plenty of comments]  
|--- combined_mole_structure.Rev - phylogenetic inference using structural + sequence data.  
|--- mk_G_inferenceper_datatype_assymetric.Rev - phylogenetic inference using only structural data.  
|--- stoch_map_mk_G_datatype_assymetric.Rev - stochastic maps of gene evolution.


---


