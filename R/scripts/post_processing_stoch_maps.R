##################################
# POST-PROCESSING STOCHASTIC MAPS
##################################


# source another script to get gene names per partition
source( "scripts/get_nexus.R")


n_partitions <- 6

# get partitions directories
dirs <- paste0("phylo_analysis/output_stochastic_mapping/partition", 1:n_partitions)


# get files names per partition in a list
  # empty list
files_per_partition <- vector(mode = 'list', length = length(n_partitions))

  # loop to get files names
for (i in 1:length(dirs) ){
  files_per_partition[[i]] <- list.files(dirs[i], full.names = T)
}


### READ ALL THE FILES
# create empty list of the size of number of partitions
stoch_map <- vector(mode = "list", length = n_partitions)


# for each partition
for (i in 1:n_partitions){

  # for each character on the partition
  for (j in 1:length(files_per_partition[[i]])){

    # read the corresponding file
    stoch_map[[i]][[j]] <- read.delim(files_per_partition[[i]][j], header = F, skip = 1, skipNul = T)

  }
}



# load functions
source("scripts/functions/deleteNAs.R")
source("scripts/functions/rename_cols.R")
source("scripts/functions/get_rid_branches.R")


# loop clean NAs and name columns over all the outputs

# for each partition
for (i in 1:length(stoch_map)){

  # for each character in the partition
  for (j in 1:length(stoch_map[[i]])){
    stoch_map[[i]][[j]] <- delete_NAs( stoch_map[[i]][[j]] )
    stoch_map[[i]][[j]] <- rename_cols( stoch_map[[i]][[j]] )

  }
}



# get rid of the branch lengths

# for each partition
for (p in 1:length(stoch_map)){

  # for each character in the partition
  for (i in 1:length(stoch_map[[p]])){

    # for each row
    for (r in 1:nrow(stoch_map[[p]][[i]])){

      # for each column (except the first one)

      for (c in 2:ncol(stoch_map[[p]][[i]])){

        stoch_map[[p]][[i]][r,c] <- get_rid_branches(stoch_map[[p]][[i]][r,c] )

      }
    }
  }
}






# Now we need to find unique rows and count how many times they appear
source("scripts/functions/get_stoch_maps_freq.R")

# make an empty list

freq_histories <- vector(mode = "list", length = length(stoch_map))

# for each partition
for (i in 1:length(stoch_map)){

  # for each character in that partition
  for (j in 1:length(stoch_map[[i]])){

    # get the summary table of frequencies of histories
    freq_histories[[i]][[j]] <- get_history_states_freq(stoch_map[[i]][[j]])
  }
}




MAP_history <- vector(mode = "list", length = length(stoch_map))

# for each partition
for (i in 1:length(stoch_map)){

  # for each character in that partition
  for (j in 1:length(stoch_map[[i]])){

    # get the summary table of frequencies of histories
    MAP_history[[i]][[j]] <- get_MAP_history(stoch_map[[i]][[j]])
  }
}


df <- data.frame(matrix(unlist(MAP_history[[1]]), nrow=length(MAP_history[[1]]), byrow=TRUE))



