
library(dplyr)


# get the stochastic maps ordered by most common history

get_history_states_freq <- function(df){

  # make a copy of the dataframe
  df_temp <- df

  # make a column with the history as string
  for (i in 1: nrow(df)){
    df_temp$single_string[i] <- paste0(df_temp[i , 2:ncol(df)], collapse = " ")
  }

  # group and count
  histories <- df_temp %>% group_by(single_string) %>% count()

  # order
  histories <- histories[order(histories$n, decreasing = T), ]

  return(histories)

}





### Get only the most common history
get_MAP_history <- function(df){

  # make a copy of the dataframe
  df_temp <- df

  # make a column with the history as string
  for (i in 1: nrow(df)){
    df_temp$single_string[i] <- paste0(df_temp[i , 2:ncol(df)], collapse = " ")
  }

  # group and count
  histories <- df_temp %>% group_by(single_string) %>% count()

  # order
  histories <- histories[order(histories$n, decreasing = T), ]

  return(histories[1 , ])

}
