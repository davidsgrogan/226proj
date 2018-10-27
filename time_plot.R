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

# About the issue of high correlation, perhaps we could rate stats, like BA,
# OBP etc. This should decrease the correlation at least some, even though the
# rate stats will also be correlated, but hopefully less so. But then we have
# the issue of a guy who played two games and hit .750. This shouldn't be that
# common, because he probably wouldn't get many postseason playing time.  But
# if we wanted to take care of it, we could add the bounds of a confidence
# interval instead of the real rate stat. A guy who played 150 games and hit
# .300 would have like .293 and .305 but a guy who played 5 games and hit .300
# would have .050 and .400, e.g. Confidence intervals aside, I don't know if
# adding f(X1, X2, X5) is "kosher" or would have some bad side effect. In any
# case, I think we could drop G completely, it adds little above PA, though it
# would identify guys who mostly PH. Maybe we add PA/G.
