library(ggplot2)
library(dplyr)

df <- read.table(file="test_data.txt", header = TRUE)
df$Explanation <- as.character(df$Explanation)
dff <- df %>%
  mutate(Algorithm = substring(Explanation, 0, 2))

data <- dff %>%
  group_by(Algorithm, Role) %>%
  summarise(RoleCount = n()
          , GoalCount = n())

plt <- ggplot(dff, aes(x=Role, fill=Role)) +
  geom_bar(colour="black", stat="count") +
  facet_wrap(~Algorithm, 1) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5)) +
  guides(fill=FALSE)

plt
ggsave(file = "/home/doyougnu/Research/XOP/test.png", width = 7, height = 5)
