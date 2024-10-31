#### Preamble ####
# Purpose: Tests the cleaned dataset of US election primary polls
# Author: Dingshuo Li
# Date: 31 October 2024
# Contact: dawson.li@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
  # - The `tidyverse` package must be installed and loaded
  # - The `testthat` package must be installed and loaded
  # - 02-clean_data.R must have been run
# Any other information needed? N/A

setwd("/Users/dingshuo/Desktop/paper2 draft/2024_US_Election_Analysis/")


#### Workspace setup ####
library(tidyverse)
library(testthat)

data <- read_csv("data/02-analysis_data/analysis_data.csv")


#### Test data ####
# Test that the dataset has 151 rows - there are 151 divisions in Australia
test_that("dataset has expected rows", {
  expect_equal(nrow(data), 393)  
})


test_that("dataset has expected column", {
  expect_equal(ncol(data), 52)  
})


test_that("'pollster' is character", {
  expect_type(data$pollster, "character")
})


# Test that the 'state' column is character type
test_that("'state' is character", {
  expect_type(data$state, "character")
})


# Test that 'candidate_name' contains only "Donald Trump"
test_that("'candidate_name' contains only 'Donald Trump'", {
  expect_true(all(data$candidate_name == "Donald Trump"))
})

# Test that 'numeric_grade' is numeric and all values are 3 or higher
test_that("'numeric_grade' is numeric and >= 2.7", {
  expect_type(data$numeric_grade, "double")
  expect_true(all(data$numeric_grade >= 2.7))
})

# Test that 'end_date' is properly formatted as a Date object
test_that("'end_date' is Date type", {
  expect_s3_class(data$end_date, "Date")
})

