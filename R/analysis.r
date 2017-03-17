library(ggplot2)
library(scales)
library(dplyr)
library(gridExtra)
# for mosaic plots
library(ggmosaic)

setwd("/home/doyougnu/Research/XOP/XOP_Encoding/R/")
# read in each data table
dfwrd <- read.table(file="../data/encodings_word_03162017.txt"
               , header = TRUE
               , row.names = NULL)

dfppt <- read.table(file="../data/encodings_ppt_03162017.txt"
               , header = TRUE
               , row.names = NULL)

# Convert Explanations to something usable, the ($) operator selects a column in a dataframe
dfwrd$Explanation <- as.character(dfwrd$Explanation)
dfppt$Explanation <- as.character(dfppt$Explanation)

# Add type of file to each datasets
dfwrd %>% mutate(fileType = "word")
dfppt %>% mutate(fileType = "ppt")

# Get Algorithm key out, the (%>%) operating is function composition from dplyr package
dfwrd <- dfwrd %>%
  mutate(Algorithm = substring(Explanation, 0, 2))
dfppt <- dfppt %>%
  mutate(Algorithm = substring(Explanation, 0, 2))

# Compose actual data set from subsets, rbind stacked datasets that share the same header
dataStacked <- rbind(dfwrd, dfppt)

# Remove readings made for comparison
data <- dataStacked %>%
  filter(!(Explanation == "UN007" && Coder == "B"), !(Explanation == "UN007" && Coder == "B"))

# Extract out the subset of rows where there are two coders, I've hardcoded this for now
dfCoderComp <- dataStacked %>%
  filter(Explanation == "UN007" | Explanation == "UN006")

# Generate a data set that does not consider notations
dfRole <- dataStacked %>%
  select(-(Notation:isPartial:isEmphasized:hasMany)) %>%
  distinct()

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
ggsave(file = "Plots/RolePercentages.png", width = 7, height = 5)

# same plot just comparing each coder
plt2 <- ggplot(dfCoderComp, aes(x=Role, fill=Role)) +
  geom_bar(colour="black", aes(y = (..count..)/sum(..count..))) +
  facet_grid(. ~ Coder) +
  scale_y_continuous(labels = percent) +
  ylab("Percentage of Total Observations") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5)) +
  guides(fill=FALSE)

plt2
ggsave(file = "Plots/RolePercentagesCoderComp.png", width = 7, height = 5)

#
test <- data %>% group_by(Algorithm, Goal, Role, Notation) %>% summarise(count = n()) %>% arrange(desc(count))

plt3 <- ggplot(test, aes(x=Role, y=count)) +
  geom_bar(stat="identity") +
  geom_bar(aes(x=Role, y=count, fill = Notation), stat="identity", position="dodge") + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5)) +
  facet_grid(.~ Algorithm)

ggsave(file = "Plots/RoleNotationComposite.png", width = 7, height = 5)

plt4 <- ggplot(dfRole, aes(x=Position, fill=Goal)) +
  geom_bar(colour="black", aes(y = (..count..)/sum(..count..))) +
  scale_y_continuous(labels = percent)
plt4
ggsave(file = "Plots/GoalsbyPosition.png", width = 7, height = 5)

## Birds eye view, really need a mosaic plot
plt5 <- ggplot(dfRole, aes(x=Position, fill=Role)) +
  geom_bar(colour="black", aes(y = (..count..)/sum(..count..))) +
  scale_y_continuous(labels = percent) +
  facet_grid (Algorithm ~ Goal)
plt5
ggsave(file = "Plots/BirdsEyeView.png", width = 7, height = 5)

## sample spine and mosaic plots
plt6 <- plot(data$Role, data$Goal, xlab = "Roles", ylab = "Goals")
plt6
ggsave(file = "Plots/RoleGoalMosaic.png", width = 7, height = 5)


## generate a contingecy table
cNGtable <- table(data$Notation, data$Goal)
cRGtable <- table(data$Role, data$Goal)
