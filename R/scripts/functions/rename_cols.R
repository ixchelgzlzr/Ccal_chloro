
# function to rename columns of the output

rename_cols <- function(data){
  n_col          <- ncol(data)
  names_vector   <- c("iteration", 1:(n_col-1))
  colnames(data) <- names_vector
  return(data)
}
