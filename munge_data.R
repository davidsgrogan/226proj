# Grabs https://cran.r-project.org/web/packages/Lahman/index.html
# install.packages("Lahman")

library(Lahman)

# cut managers and others who never played
#Master %>% filter(!is.na(debut))

# The data is updated through 2016
Master %>% filter(!is.na(debut)) %>% select(playerID, debut, bbrefID) %>% arrange(debut) %>%
  tail

# 18910 players
Master %>% filter(!is.na(debut)) %>% select(playerID, debut, bbrefID) %>% nrow

# https://cran.r-project.org/web/packages/baseballDBR/ can add more advanced
# metrics to these tables
# https://cran.r-project.org/web/packages/Lahman/Lahman.pdf also has bunch of examples

# inner_join on (playerID, yearID) with postseason to get 2 player-year tables,
# one for pitching, one for batting, then drop players with < 10 AB and < 3 IP,
# see how many rows we have, then cut 20%?

# We want to operate on 1 table with 80% of our data. But it should include
# every raw covariate we have so that we have maximum flexibility later when
# we're really modelling. i.e we shouldn't just have pitcher, year, era_regular,
# era_postseason. But I'm not sure what all we want. maybe:
#
# pitcher, year, age, height, weight, bat hand, throw hand, all counting stats
# from regular, all counting from post
#
# And then same for batters? But I don't know how to determine a cutoff for
# throwing out players who only have a few AB or IP that would just be noisy if
# we're comparing rate stats

# Alternatively, instead of player-years, we can operate on a player's whole
# career compared to his whole postseason career. We'd have fewer rows to start
# but we'd retain a higher % of them and they'd be more meaningful.
# If we group players' entire career together we only start with 1704
PitchingPost %>% group_by(playerID) %>% summarise(number_years = n()) %>% nrow

# Batters is 4247
BattingPost %>% group_by(playerID) %>% summarise(number_years = n()) %>%nrow

aug_pitch = inner_join(PitchingPost, Pitching, by=c("playerID", "yearID"))
