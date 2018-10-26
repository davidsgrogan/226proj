library(Lahman)
library(tidyverse)
library(GGally)

set.seed(1)

# Ks are NA sometimes before 1913
recent <- subset(Batting, yearID > 1912)
recent_80 <- sample_frac(recent, 0.8)
Ks <-
  summarize(group_by(recent_80, yearID), KsPerAB = sum(SO) / sum(AB))

ggplot(Ks, mapping = aes(x = yearID, y = KsPerAB)) +
  geom_point() +
  labs(title = "Strikeouts per At Bat over time") + 
  xlab("Year") +
  ylab("Proportion of At Bats that end in a strikeout")
