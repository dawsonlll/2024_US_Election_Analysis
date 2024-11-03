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

data <- read_csv("data/01-raw_data/president_polls.csv") |>
  clean_names()

# Filter data for Donald Trump with high-quality polls
just_trump_high_quality <- data %>%
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
  filter(end_date >= as.Date("2024-07-15")) %>%
  # Calculate num_trump without dropping NA values
  mutate(
    num_trump = round((pct / 100) * sample_size, 0)
  )

# Filter data for Kamala Harris with high-quality polls
just_harris_high_quality <- data %>%
  filter(
    candidate_name == "Kamala Harris",
    numeric_grade >= 2.7
  ) %>%
  # Handle missing states and convert end_date to Date format
  mutate(
    state = if_else(is.na(state), "National", state),
    end_date = mdy(end_date)
  ) %>%
  # Filter out rows with end_date before 2024-07-15
  filter(end_date >= as.Date("2024-07-15")) %>%
  # Calculate num_harris without dropping NA values
  mutate(
    num_harris = round((pct / 100) * sample_size, 0)
  )


#### Save data ####
write_parquet(x = just_trump_high_quality,
              sink = "data/02-analysis_data/analysis_trump_data.parquet")
write_parquet(x = just_harris_high_quality,
              sink = "data/02-analysis_data/analysis_harris_data.parquet")

write_csv(just_trump_high_quality, "data/02-analysis_data/analysis_trump_data.csv")
write_csv(just_harris_high_quality, "data/02-analysis_data/analysis_harris_data.csv")
