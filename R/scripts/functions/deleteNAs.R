# function to delete NA cols in stoch map outputs

delete_NAs <- function(data){
  # get a couple rows
  row_x <- which(is.na(data[1,]))
  row_y <- which(is.na(data[100, ]))

  # if the two rows have same NAs columns
  if (identical(row_x, row_y) == T ){
    # delete those columns
    new_data <- data[ , -row_x]
    return(new_data)
  } else {
    print("something is wrong")
  }
}
