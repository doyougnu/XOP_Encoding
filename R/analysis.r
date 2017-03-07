library(ggplot2)
library(scales)
library(dplyr)

df <- read.table(file="../data/encodings_raw_03042017.txt"
               , header = TRUE
               , row.names = NULL)
df$Explanation <- as.character(df$Explanation)
dff <- df %>%
  mutate(Algorithm = substring(Explanation, 0, 2))

data <- dff %>%
  filter(!(Explanation == "UN007" && Coder == "B") && !(Explanation == "UN007" && Coder == "B"))

plt <- ggplot(data, aes(x=Role, fill=Role)) +
  geom_bar(colour="black", aes(y = (..count..)/sum(..count..))) +
  facet_grid(Algorithm ~ .) +
  scale_y_continuous(labels = percent) +
  ylab("Percentage of Total Observations") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5)) +
  guides(fill=FALSE)

plt
ggsave(file = "/home/doyougnu/Research/XOP_Encoding/R/Plots/RolePercentages.png", width = 7, height = 5)

comparisonDf <- dff %>%
  filter(Explanation == "UN007" | Explanation == "UN006")

plt2 <- ggplot(comparisonDf, aes(x=Role, fill=Role)) +
  geom_bar(colour="black", aes(y = (..count..)/sum(..count..))) +
  facet_grid(. ~ Coder) +
  scale_y_continuous(labels = percent) +
  ylab("Percentage of Total Observations") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5)) +
  guides(fill=FALSE)

plt2
ggsave(file = "/home/doyougnu/Research/XOP_Encoding/R/Plots/RolePercentagesCoderComp.png", width = 7, height = 5)
