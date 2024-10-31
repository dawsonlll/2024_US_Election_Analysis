#### Preamble ####
# Purpose: Tests the structure and validity of the simulated US election 
  # primary polls dataset.
# Author: Dingshuo Li
# Date: 31 October 2024
# Contact: dawson.li@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
  # - The `tidyverse` package must be installed and loaded
  # - 00-simulate_data.R must have been run
# Any other information needed? Make sure you are in the `starter_folder` rproj


#### Workspace setup ####
library(tidyverse)


simulated_data <- read_csv("data/00-simulated_data/simulated_data.csv")

# Test if the data was successfully loaded
if (exists("simulated_data")) {
  message("Test Passed: The dataset was successfully loaded.")
} else {
  stop("Test Failed: The dataset could not be loaded.")
}


#### Test data ####

# Check if the dataset has 1000 rows
if (nrow(simulated_data) == 1000) {
  message("Test Passed: The dataset has 1000 rows.")
} else {
  stop("Test Failed: The dataset does not have 1000 rows.")
}

# Check if the dataset has 9 columns
if (ncol(simulated_data) == 9) {
  message("Test Passed: The dataset has 9 columns.")
} else {
  stop("Test Failed: The dataset does not have 9 columns.")
}

if (n_distinct(simulated_data$pollster) == length(unique(simulated_data$pollster))) {
  message("Test Passed: All values in 'pollster' are unique.")
} else {
  stop("Test Failed: The 'pollster' column contains duplicate values.")
}

valid_methodologies <- c("Online Panel", "Telephone", "In-person", "Mixed-mode")

if (all(simulated_data$methodology %in% valid_methodologies)) {
  message("Test Passed: The 'methodology' column contains only valid methodology names.")
} else {
  stop("Test Failed: The 'methodology' column contains invalid methodology names.")
}

valid_candidates <- c("Kamala Harris", "Gavin Newsom", "Pete Buttigieg", 
                      "Elizabeth Warren", "Bernie Sanders", "Donald Trump")

if (all(simulated_data$candidate_name %in% valid_candidates)) {
  message("Test Passed: The 'candidate_name' column contains only valid candidate names.")
} else {
  stop("Test Failed: The 'candidate_name' column contains invalid candidate names.")
}

if (all(!is.na(simulated_data))) {
  message("Test Passed: The dataset contains no missing values.")
} else {
  stop("Test Failed: The dataset contains missing values.")
}

if (all(simulated_data$pollster != "" & simulated_data$methodology != "" & simulated_data$candidate_name != "")) {
  message("Test Passed: There are no empty strings in 'pollster', 'methodology', or 'candidate_name'.")
} else {
  stop("Test Failed: There are empty strings in one or more columns.")
}

if (all(simulated_data$pollscore >= -2 & simulated_data$pollscore <= 5)) {
  message("Test Passed: All 'pollscore' values are between -2 and 5.")
} else {
  stop("Test Failed: Some 'pollscore' values are outside the range -2 to 5.")
}

if (all(simulated_data$pct >= 0 & simulated_data$pct <= 100)) {
  message("Test Passed: All 'pct' values are between 0 and 100.")
} else {
  stop("Test Failed: Some 'pct' values are outside the range 0 to 100.")
}

if (all(simulated_data$numeric_grade >= 1 & simulated_data$numeric_grade <= 3)) {
  message("Test Passed: All 'numeric_grade' values are between 1 and 3.")
} else {
  stop("Test Failed: Some 'numeric_grade' values are outside the range 1 to 3.")
}

