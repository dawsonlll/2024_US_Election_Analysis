#### Preamble ####
# Purpose: Simulates a dataset of US election primary polls, including the 
  #pollsters, methodologies, candidates and numerical grades of each pollsters.
# Author: Dingshuo Li
# Date: 31 October 2024
# Contact: dawson.li@mail.utoronto.ca
# License: MIT
# Pre-requisites: The `tidyverse` package must be installed
# Any other information needed? Make sure you are in the `starter_folder` rproj


#### Workspace setup ####
library(tidyverse)
library(dplyr)
set.seed(304304)

num_rows <- 1000


pollsters <- c("YouGov", "Gallup", "Ipsos", "Pew Research", "SurveyMonkey")
methodologies <- c("Online Panel", "Telephone", "In-person", "Mixed-mode")
candidates <- c("Kamala Harris", "Gavin Newsom", "Pete Buttigieg", "Elizabeth Warren", "Bernie Sanders", "Donald Trump")

#### Simulate data ####
simulated_data <- data.frame(
  pollster = sample(pollsters, num_rows, replace = TRUE),
  numeric_grade = round(runif(num_rows, min = 1, max = 3), 1),
  pollscore = round(runif(num_rows, min = -2, max = 5), 1),
  methodology = sample(methodologies, num_rows, replace = TRUE),
  transparency_score = sample(0:9, num_rows, replace = TRUE),
  start_date = format(seq(as.Date("2024-01-01"), by = "7 days", length.out = num_rows), "%m/%d/%Y"),
  end_date = format(seq(as.Date("2024-11-04"), by = "7 days", length.out = num_rows), "%m/%d/%Y"),
  candidate_name = sample(candidates, num_rows, replace = TRUE),
  pct = round(runif(num_rows, min = 0, max = 100), 1)
)


#### Save data ####
write_csv(simulated_data, "data/00-simulated_data/simulated_data.csv")

