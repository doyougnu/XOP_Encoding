library(ggplot2)
library(scales)
library(dplyr)
library(gridExtra)
# for mosaic plots
library(ggmosaic)

## setwd("/home/doyougnu/Research/XOP/XOP_Encoding/R/")
############################### Data Munging ###################################
# read in each data table
dfppt <- read.table(file="../../data/BellackTransTypology/encodings_ppt_04082017.txt"
                  , sep="/"
                  , header = TRUE
                  , row.names = NULL)

# Convert Explanations to something usable, the ($) operator selects a column in a dataframe
dfppt$Explanation <- as.character(dfppt$Explanation)

# Add type of file to each datasets
dfppt <- dfppt %>% mutate(fileType = "ppt")

# Get Algorithm key out, the (%>%) operating is function composition from dplyr package
dfAlg <- dfppt %>%
  mutate(Algorithm = substring(Explanation, 0, 2))

# add Location that is in relation to the size of each document
dfPositions <- dfAlg %>%
  group_by(Explanation) %>%
  summarise(upperBound = range(Position)[2]
          , lowerBound = floor(upperBound / 3)
          , midBound = lowerBound * 2)

# now merge
dff <- merge(dfAlg, dfPositions, all=TRUE)

# add indicators of relative position for each observation
dfInd <- dff %>%
  mutate(Location =
           ifelse(Position >= 0 & Position < lowerBound, "Beg"
                , ifelse(Position >= lowerBound & Position < midBound, "Mid"
                       , "End")))

# add index for each observaton relative to begging of each document
dfInd$ind = seq.int(nrow(dfInd))
df <- dfInd %>%
  group_by(Explanation) %>%
  mutate(index = ind - range(ind)[1]) %>%
  select(-ind) %>%
  select(-(upperBound:midBound))
################################################################################

################################### Plotting ###################################
# pull out vector of move types
types <- df$Type

# this is not idiomatic R, and explicit looping doesn't take advantage of R's
# vectorization, this is and should be, discouraged
findCycles <- function(xs, result, acc){
  # base case
  if (length(xs) == 0){
    res <- append(result, acc)
    return(res)
  }

  # Pull out the head:tail
  x <- as.character(xs[1])
  xss <- xs[-1]

  # Inductive cases
  if (x == "STR"){
    # if we find a new STR move then add accumulator to result and recurse
    result[[length(result) + 1]] <- acc
    accumulator <- append(list(), x)
    findCycles(xss, result, accumulator)
  } else {
    # if not a STR then add to accumulator and keep recursing
    acc[[length(acc) + 1]] <- x
    findCycles(xss, result, acc)
  }
}

cycles <- findCycles(types, list(), list())
