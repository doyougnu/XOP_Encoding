library(ggplot2)
library(scales)
library(dplyr)
library(gridExtra)
# for mosaic plots
library(ggmosaic)

# Change this to the appropriate directory if you're going to run this script
setwd("/home/doyougnu/Research/XOP/XOP_Encoding/R/BellackTransTypology")

############################### Data Munging ###################################
# read in each data table
dfppt <- read.table(file="../../data/BellackTransTypology/encodings_ppt_04182017.txt"
                  , sep="/"
                  , header = TRUE
                  , row.names = NULL)

dfwrd <- read.table(file="../../data/BellackTransTypology/encodings_word_04182017.txt"
                  , sep="/"
                  , header = TRUE
                  , row.names = NULL)

# Add type of file to each datasets
dfppt <- dfppt %>% mutate(fileType = "ppt")
dfwrd <- dfwrd %>% mutate(fileType = "word")

# Compose actual data set from subsets, rbind stacked datasets that share the
# same header
dfStacked <- rbind(dfwrd, dfppt)

# Convert Explanations to something usable, the ($) operator selects a column in a dataframe
dfStacked$Explanation <- as.character(dfStacked$Explanation)

# filter out non Codable moves
dfStacked <- dfStacked %>% filter(Type != "NOC")

# Get Algorithm key out, the (%>%) operating is function composition from dplyr package
dfAlg <- dfStacked %>%
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
# this is not idiomatic R, and explicit looping doesn't take advantage of R's
# vectorization, this is and should be, discouraged
findCycles <- function(xs, result, acc){
  # Given a list of xs, a result list, and an accumulator list, function groups
  # input list in terms of sublists that begin with STR continue until the next
  # STR instance. Ex: input: STR EXP STR STR STR SOL EXP
  #                  output: [[STR, EXP], [STR], [STR], [STR SOL EXP]]

  # base case
  if (length(xs) == 0){
    print(length(xs))
    what <- append(list(), acc)
    res <- append(result, what)
    return(res)
  }

  # Pull out the head:tail
  x <- as.character(xs[1])
  xss <- xs[-1]

  # Inductive cases
  if (x == "STR" || x == "SOL"){
    # if we find a new STR or SOL move then add accumulator to result and recurse
    result[[length(result) + 1]] <- acc
    accumulator <- append(list(), x)
    findCycles(xss, result, accumulator)
  } else {

    # if not a STR then add to accumulator and keep recursing
    acc[[length(acc) + 1]] <- x
    findCycles(xss, result, acc)
  }
}

# Get all teaching cycles as a list of lists
dfTypeWrd <- df %>% filter(fileType == "word")
dfTypePpt <- df %>% filter(fileType == "ppt")

listCycles <- findCycles(df$Type, list(), list())
listCyclesWrd <- findCycles(dfTypeWrd$Type, list(), list())
listCyclesPpt <- findCycles(dfTypePpt$Type, list(), list())

# lapply is R's map function for lists, function(x) is just making a lambda func
# There is a bug that doesn't count the last teach cycle, this is manually changed for correctness
# If you're skeptical than good on you! Inspect the end of output of the write 
# function call after you remove unique(), like this:
# lapply(cycles, write, "Plots/teachingCyclesTable.txt", append = TRUE)
cycles <- lapply(listCycles, function(x) paste(x, collapse = ' '))
cyclesWrd <- lapply(listCyclesWrd, function(x) paste(x, collapse = ' '))
cyclesPpt <- lapply(listCyclesPpt, function(x) paste(x, collapse = ' '))

# Write all found teaching cycles to a table
lapply(cycles %>% unique(), write, "Plots/teachingCyclesTable.txt")

# Write frequency table to file
freqTable <- table(unlist(cycles))
freqTableWrd <- table(unlist(cyclesWrd))
freqTablePpt <- table(unlist(cyclesPpt))
write.table(freqTable, "Plots/teachCyclesFreqTable.txt") 
write.table(freqTableWrd, "Plots/teachCyclesFreqTableWrd.txt") 
write.table(freqTablePpt, "Plots/teachCyclesFreqTablePpt.txt") 


cycleColorization <- function(xs, result, counter){
  # base case
  if (length(xs) == 0){
    return(result)
  }

  # get head:tail
  x <- as.character(xs[1])
  xss <- xs[-1]

  # Check if STR, if STR increment, if not don't'
  if (x == "STR" || x == "SOL"){
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

# dot plot for counts
lastN <- function(string, n){
  # Given a string, get last n characters from string, this is vectorized.
  substr(string, nchar(string) - n+1, nchar(string))
}

df <- df %>% mutate(docNum = lastN(Explanation, 2))

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

# Cycles plot with ppt and wrd combined
teachCyclesPltCombined <- ggplot(df, aes(y = Type
                               , x = index
                               , colour = typeColor
                               , group = typeColor)) +
  geom_point(aes(size = 2)) +
  geom_line(aes(colour = typeColor, size = 1.5)) +
  facet_grid(docNum ~ Algorithm
           , switch = "y"
           , scales = "free_x"
           , drop = TRUE) +
  scale_shape_manual(values = 1:nlevels(df$typeColor)) +
  theme_bw() +
  theme(legend.position = "none"
      , axis.title.y=element_blank()
      , axis.title.x = element_blank()
        , text = element_text(size = 13.5))

#save plot
ggsave(file = "Plots/teachCyclesPltCombined.pdf", device = "pdf", dpi = 100)

# Cycles plot with only ppt data, docNums <= 5 are bound only to ppts in the data
teachCyclesPltppt <- ggplot(df %>% filter(as.numeric(docNum) <= 5), aes(y = Type
                               , x = index
                               , colour = typeColor
                               , group = typeColor)) +
  geom_point(aes(size = 2)) +
  geom_line(aes(colour = typeColor, size = 1.5)) +
  facet_grid(docNum ~ Algorithm
           , switch = "y"
           , scales = "free_x"
           , drop = TRUE) +
  scale_shape_manual(values = 1:nlevels(df$typeColor)) +
  theme_bw() +
  theme(legend.position = "none"
      , axis.title.y=element_blank()
      , axis.title.x = element_blank()
        , text = element_text(size = 13.5))

#save plot
ggsave(file = "Plots/teachCyclesPltppt.pdf", device = "pdf", dpi = 100)

# Cycles plot with only wrd data, docNums > 5 are bound only to wrds in the data
teachCyclesPltwrd <- ggplot(df %>% filter(as.numeric(docNum) > 5), aes(y = Type
                               , x = index
                               , colour = typeColor
                               , group = typeColor)) +
  geom_point(aes(size = 2)) +
  geom_line(aes(colour = typeColor, size = 1.5)) +
  facet_grid(docNum ~ Algorithm
           , switch = "y"
           , scales = "free_x"
           , drop = TRUE) +
  scale_shape_manual(values = 1:nlevels(df$typeColor)) +
  theme_bw() +
  theme(legend.position = "none"
      , axis.title.y=element_blank()
      , axis.title.x = element_blank()
        , text = element_text(size = 13.5))

#save plot
ggsave(file = "Plots/teachCyclesPltwrd.pdf", device = "pdf", dpi = 100)
