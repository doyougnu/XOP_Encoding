library(ggplot2)
library(scales)
library(dplyr)
library(gridExtra)
library(tidyr)
# for mosaic plots
library(ggmosaic)

## setwd("/home/doyougnu/Research/XOP/XOP_Encoding/R/")
# read in each data table
dfwrd <- read.table(file="../../data/LevelRoleNotationTypology/encodings_word_03162017.txt"
               , header = TRUE
               , row.names = NULL)

dfppt <- read.table(file="../../data/LevelRoleNotationTypology/encodings_ppt_03162017.txt"
               , header = TRUE
               , row.names = NULL)

# Convert Explanations to something usable, the ($) operator selects a column in a dataframe
dfwrd$Explanation <- as.character(dfwrd$Explanation)
dfppt$Explanation <- as.character(dfppt$Explanation)

# Add type of file to each datasets
dfwrd <- dfwrd %>% mutate(fileType = "word")
dfppt <- dfppt %>% mutate(fileType = "ppt")

# Get Algorithm key out, the (%>%) operating is function composition from dplyr package
dfwrd <- dfwrd %>%
  mutate(Algorithm = substring(Explanation, 0, 2))
dfppt <- dfppt %>%
  mutate(Algorithm = substring(Explanation, 0, 2))

# Compose actual data set from subsets, rbind stacked datasets that share the same header
dataStacked <- rbind(dfwrd, dfppt)

# Generate a data set that does not consider notations
dfRole <- dataStacked %>%
  select(-(Notation:isPartial:isEmphasized:hasMany)) %>%
  distinct()

# Generate a data frame that has the upper mid and lower bounds for each explanation
dfPositions <- dfRole %>%
  group_by(Explanation) %>%
  summarise(upperBound = range(Position)[2]
          , lowerBound = floor(upperBound / 3)
          , midBound = lowerBound * 2)

# now merge
dfRole <- merge(dataStacked, dfPositions, all=TRUE)

# add relevant columns
dfRole <- dfRole %>%
  mutate(Location =
           ifelse(Position >= 0 & Position < lowerBound, "Beg"
                , ifelse(Position >= lowerBound & Position < midBound, "Mid"
                       , "End")))

# add index for each observaton relative to begging of each document
dfRole$ind = seq.int(nrow(dfRole))
dfRole <- dfRole %>%
  group_by(Explanation, Coder) %>%
  mutate(index = ind - range(ind)[1]) %>%
  select(-ind) %>%
  select(-(upperBound:midBound))

# Extract out the subset of rows where there are two coders, I've hardcoded this for now
dfCoderComp <- dfRole %>%
  filter(Explanation == "UN007" | Explanation == "UN006")

# Remove readings made for comparison
dfRole <- dfRole %>%
  filter(!(Explanation == "UN007" && Coder == "B"), !(Explanation == "UN007" && Coder == "B"))

# Spread out the data to get Goal comparison
dfGoalComp <- dfCoderComp %>%
  select(Explanation, Coder, Goal, index) %>%
  spread(Coder, Goal) %>%
  group_by(Explanation, index) %>%
  summarise(count = ifelse(A == B, 1, 0))

# Turn an NAs into 0's, NAs occur when one coder coder less, or more than another for a particular document
dfGoalComp[is.na(dfGoalComp)] <- 0

# Find agreement percentage for each document, between coders
agGoalRate <- sum(dfGoalComp$count) / nrow(dfGoalComp)

# mosaic plot df
mdf <- data %>% group_by(Explanation, Goal, Role, Notation, Position) %>% summarise(count = n())

# Basic bar plot showing the percentages of roles per algorithm
plt <- ggplot(data, aes(x=Role, fill=Role)) +
  geom_bar(colour="black", aes(y = (..count..)/sum(..count..))) +
  facet_grid(Algorithm ~ .) +
  scale_y_continuous(labels = percent) +
  ylab("Percentage of Total Observations") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5)) +
  guides(fill=FALSE)

plt
## ggsave(file = "Plots/RolePercentages.png", width = 7, height = 5)

# same plot just comparing each coder
plt2 <- ggplot(dfCoderComp, aes(x=Role, fill=Role)) +
  geom_bar(colour="black", aes(y = (..count..)/sum(..count..))) +
  facet_grid(. ~ Coder) +
  scale_y_continuous(labels = percent) +
  ylab("Percentage of Total Observations") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5)) +
  guides(fill=FALSE)

plt2
## ggsave(file = "Plots/RolePercentagesCoderComp.png", width = 7, height = 5)

#
test <- data %>% group_by(Algorithm, Goal, Role, Notation) %>% summarise(count = n()) %>% arrange(desc(count))

plt3 <- ggplot(test, aes(x=Role, y=count)) +
  geom_bar(stat="identity") +
  geom_bar(aes(x=Role, y=count, fill = Notation), stat="identity", position="dodge") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5)) +
  facet_grid(.~ Algorithm)

## ggsave(file = "Plots/RoleNotationComposite.png", width = 7, height = 5)

plt4 <- ggplot(dfRole, aes(x=Position, fill=Goal)) +
  geom_bar(colour="black", aes(y = (..count..)/sum(..count..))) +
  scale_y_continuous(labels = percent)
plt4
## ggsave(file = "Plots/GoalsbyPosition.png", width = 7, height = 5)

## Birds eye view, really need a mosaic plot
plt5 <- ggplot(dfRole, aes(x=Position, fill=Role)) +
  geom_bar(colour="black", aes(y = (..count..)/sum(..count..))) +
  scale_y_continuous(labels = percent) +
  facet_grid (Algorithm ~ Goal)
plt5
## ggsave(file = "Plots/BirdsEyeView.png", width = 7, height = 5)

## sample spine and mosaic plots
## plt6 <- plot(data$Role, data$Goal, xlab = "Roles", ylab = "Goals")
## jpeg("Plots/RoleGoalMosaic.jpg")
## plot(data$Role, data$Goal, xlab = "Roles", ylab = "Goals")
## dev.off()


## generate a contingecy table
cNGtable <- table(data$Notation, data$Goal)
cRGtable <- table(data$Role, data$Goal)

# looking for teaching cycles, using only Goals
dfGoal <- dfRole %>%
  select(-Role) %>%
  group_by(Position, Algorithm, Goal, fileType, Location) %>%
  distinct() %>%
  summarise(count = n()) %>%
  arrange(desc(count))

# generate a dot plot sized by count
plt7 <- ggplot(dfGoal, aes(x = Position, y = reorder(Goal, -count), colour = Goal, size = count)) +
  geom_jitter() +
  ylab("Goal") +
  facet_grid(fileType ~ Algorithm)
plt7

## ggsave(file = "Plots/GoalsTeachingCycles.png", width = 7, height = 5)

dfRole2 <- dfRole %>%
  select(-(Goal)) %>%
  filter(!((Explanation == "UN007" | Explanation == "UN006") & Coder == "B")) %>%
  group_by(Position, Algorithm, Role, fileType, Location) %>%
  summarise(count = n()) %>%
  arrange(desc(count))

# generate a boxplot in the same form
plt8 <- ggplot(dfRole2, aes(x = factor(Location, levels=c("Beg", "Mid", "End"))
                          , y = reorder(Role, -count)
                         , colour = Role, shape = Location, size = count)) +
  geom_jitter() +
  xlab("Location") +
  ylab("Role") +
  facet_grid(fileType ~ Algorithm)
plt8


# count balloon plot compensating for Location
test <- ggplot(dfRole, aes(x = Role, y = index, colour = Role, fill = Role)) +
  geom_boxplot(colour = "black", alpha = 0.5) +
  geom_jitter() +
  ## xlab("Index") +
  ## ylab("Role") +
  coord_flip() +
  facet_grid(fileType ~ Algorithm, scales = "free")
test



## ggsave(file = "Plots/RolesTeachingCycles.png", width = 7, height = 5)
