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

# We are trying to pick needles from haystacks if we are trying to determine
# difference between regular season OPS and postseason OPS.  If that's what we
# do, we need more data. We could just drop the column IBB, or for the missing
# part of our dataset, impute it from other covars that are highly correlated
# with it, if that's what is technically recommended in the chapter he posted
# about imputation.

# Or we can just plain old try to predict posteason OPS without comparing it to
# regular season OPS, which is maybe preferable. But even then I'm interested
# in getting more data by dropping or imputing columns that are NA close to
# 1955.
