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
  # Given a list of xs, a result list, and an accumulator list, function groups
  # input list in terms of sublists that begin with STR continue until the next
  # STR instance. Ex: input: STR EXP STR STR STR SOL EXP
  #                  output: [[STR, EXP], [STR], [STR], [STR SOL EXP]]

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

listCycles <- findCycles(types, list(), list())
# lapply is R's map function for lists, function(x) is just making a lambda func
cycles <- lapply(listCycles, function(x) paste(x, collapse = ' ')) %>% unique()

cycleColorization <- function(xs, result, counter){
  # base case
  if (length(xs) == 0){
    return(result)
  }

  # get head:tail
  x <- as.character(xs[1])
  xss <- xs[-1]

  # Check if STR, if STR increment, if not don't'
  if (x == "STR"){
    counter = counter + 1
  }
  res <- append(result, counter)
  cycleColorization(xss, res, counter)
}

# add new column
df$typeColorTemp = cycleColorization(df$Type, list(), 0) %>% unlist() 
# relate column to each explanation
df <- df %>%
  group_by(Explanation) %>%
  mutate(typeColor = typeColorTemp - range(typeColorTemp)[1]) %>%
  select(-typeColorTemp)

df$typeColor = factor(df$typeColor)

# Observe teaching cycles for one document
# AVL tree example
dfAvlSingleton <- df %>% filter(Explanation == "AVT001")

singleAvlCycle <- ggplot(dfAvlSingleton, aes(y = Type, x = index
                                          , shape=Type, size = 3
                                          , colour = Type)) +
  geom_point() +
  theme(legend.position = "none")

ggsave(file = "Plots/singleAvlCycle.png", width = 7, height = 5)

#Dijkstra's example
dfDjkSingleton <- df %>% filter(Explanation == "DJK002")

singleDjkCycle <- ggplot(dfDjkSingleton, aes(y = Type, x = index
                                          , shape=Type, size = 3
                                          , colour=Type)) +
  geom_point() +
  theme(legend.position = "none")


ggsave(file = "Plots/singleDjkCycle.png", width = 7, height = 5)

# dot plot for counts
teachCyclesPlt <- ggplot(df, aes(y = Type
                               , x = index
                               , colour = typeColor
                               , group = typeColor)) +
  geom_point(aes(size = 2)) +
  geom_line(aes(colour = typeColor, size = 1.5)) +
  facet_grid(Explanation ~., switch = "y", scales = "free_y") +
  scale_shape_manual(values = 1:nlevels(df$typeColor)) +
  theme_bw() +
  theme(legend.position = "none") +
  ggtitle("Teaching Cycles per Explanation")

ggsave(file = "Plots/teachCyclesPlt.png")
