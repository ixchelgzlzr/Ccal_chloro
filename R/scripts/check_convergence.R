# installing packages, don't run everytime
#install.packages("devtools")
library(devtools)
#install_github("danlwarren/RWTY")
library(rwty)
#install.packages('MCMCtreeR')
library(MCMCtreeR)
#devtools::install_github("cmt2/revgadgets")
library(RevGadgets)
library(coda)
#install.packages("mcgibbsit")
library(mcgibbsit)
install_github("lfabreti/convenience")
library(convenience)
library(ggplot2)



#Read the output from RevBayes
my_chains <- load.multi("phylo_analysis/output",
                        format= "revbayes") #so cool revbayes is an option!


#Analize the chains
liver.rwty <- analyze.rwty( my_chains, fill.color = 'Likelihood', burnin =500)

# some plots
liver.rwty$topology.trace.plot
liver.rwty$treespace.heatmap
liver.rwty$treespace.points.plot
liver.rwty$turnover.trace


#Get an approximate of the topological ESS
topo.ess <- topological.approx.ess(my_chains, burnin = 500)



#Convergence
path_output <-  "phylo_analysis/output"

conv <- checkConvergence(path = path_output, format = "revbayes",
                              makeControl(tracer= F, burnin = 10))


conv$converged
