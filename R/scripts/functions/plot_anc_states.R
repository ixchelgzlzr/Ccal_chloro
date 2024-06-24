
# make a function to plot the ancestral state

plot_anc_state <- function(tree, reconstruction){

  # plot the tree
  plot(ladderize(tree), label.offset = 0.003, )

  # get some colors
  colors        <- viridis(length(unique(reconstruction[,2])))
  names(colors) <- unique(reconstruction[,2])

  # add the states
  #nodelabels(paste0("[", reconstruction[, 1], ",", reconstruction[, 2], "]"), frame = "none", cex= 0.7, adj = c(1, 2))

  # node states
  nodelabels(pch = 19, col = colors[reconstruction[, 2]])

  # terminal states
  tiplabels(pch = 19, col = colors[reconstruction[, 2]])


}


