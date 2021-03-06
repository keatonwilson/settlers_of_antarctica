# Script to create seal collar data
# Keaton Wilson
# keatonwilson@me.com
# 2020-01-23 

# packages
library(tidyverse)

# The basic idea here is to create a dataframe on 100 collars, from two 
# different manufacturers, with two columns of data: battery life (how long it
# lasts) and signal distance (how far it reads before it won't respond). A 
# tradeoff here - one brand probably has longer battery life and one has a 
# longer signalling distance. Also a column for failure (i.e. a collar was 
# noted or collected by fishing teams on a leopard seal that posed a threat, 
# but didn't ping on their instruments).

collars = tibble(collar_id = seq(1:100),
                     maker = c(rep("Collarium Inc.", 47), 
                               rep("Budget Collars LLC", 53)), 
                     battery_life = c(rnorm(n = 47, mean = 120, sd =10), 
                                      rnorm(n = 53, mean = 86, sd = 10)), 
                     signal_distance = c(rnorm(n = 47, mean = 4200, sd = 35),
                                         rnorm(n = 53, mean = 4300, sd = 35)), 
                     fail = c(rbinom(n = 47, size = 1, prob = 0.07), 
                              rbinom(n = 53, size = 1, prob = 0.3)))

# Checking
collars %>% 
  group_by(maker) %>%
  summarize(mean_fail = mean(fail))

ggplot(collars, aes(x = signal_distance, y = battery_life, col = maker)) +
  geom_point()

#writing to csv
write_csv(collars, path = "./modules/module_3/data/collar_data.csv")
