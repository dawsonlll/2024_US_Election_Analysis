#### Preamble ####
# Purpose: Cleans the raw plane data recorded by two observers..... [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 6 April 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]

#### Workspace setup ####
library(tidyverse)
install.packages("arrow")
library(arrow)
library(janitor)
library(dplyr)
library(lubridate)

#### Clean data ####
data <- read_csv("data/01-raw_data/president_primary_polls.csv") |>
  clean_names()

just_trump_high_quality <- data %>%
  # Select relevant columns first
  select(
    pollster, sponsors, display_name, numeric_grade, pollscore,
    methodology, transparency_score, state, start_date, end_date,
    office_type, stage, party, candidate_name, pct, sample_size
  ) %>%
  # Filter for Donald Trump and high-quality polls
  filter(
    candidate_name == "Donald Trump",
    numeric_grade >= 2.7
  ) %>%
  # Handle missing states and convert end_date to Date format
  mutate(
    state = if_else(is.na(state), "National", state),
    end_date = mdy(end_date)
  ) %>%
  # Filter out rows with end_date before 2022-11-15
  filter(end_date >= as.Date("2022-11-15")) %>%
  # Calculate num_trump without dropping NA values
  mutate(
    num_trump = round((pct / 100) * sample_size, 0)
  )


#### Save data ####
write_parquet(x = just_trump_high_quality,
              sink = "data/02-analysis_data/analysis_data.parquet")

write_csv(just_trump_high_quality, "data/02-analysis_data/analysis_data.csv")
