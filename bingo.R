bingo <- function(set) {
  set <- sample(set)
  cat(set[1])
  set <- set[set != set[1]]
  return(set)
}
# set up
bing <- 1:100




# run each time to overwrite your bingo set and pull another value
bing <- bingo(bing)

