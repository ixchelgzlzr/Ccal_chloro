# make a function

get_rid_branches <- function(string){

  # remove parenthesis
  a <- gsub( "[{}]", "", string )

  # split at :
  a <- str_split(a, ':')

  # delete branches in a loop
  for (i in 1:length(a[[1]])){
    a[[1]][i] <- gsub(",.*", "", a[[1]][i])
  }

  # Make it back on the original structure
  a <- paste0("{", str_flatten(a[[1]], collapse = ":"), "}")

  return(a)

}
