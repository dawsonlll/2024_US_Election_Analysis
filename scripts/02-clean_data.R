#### Preamble ####
# Purpose: Cleans the raw dataset of US president primary polls
# Author: Dingshuo Li
# Date: 31 October 2024
# Contact: dawson.li@mail.utoronto.ca
# License: MIT
# Pre-requisites: The raw dataset is in 01-raw_data file
# Any other information needed? N/A

#### Workspace setup ####
library(tidyverse)
library(arrow)
library(janitor)
library(dplyr)
library(lubridate)

#### Clean data ####
data <- read_csv("data/01-raw_data/president_primary_polls.csv") |>
  clean_names()

just_trump_high_quality <- data %>%
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

