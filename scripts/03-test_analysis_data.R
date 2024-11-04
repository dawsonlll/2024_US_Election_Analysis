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

setwd(here::here())


#### Workspace setup ####
library(tidyverse)
library(testthat)

trump_data <- read_csv("data/02-analysis_data/analysis_trump_data.csv")


#### Test trump_data ####
# Test that the dataset has correct rows and column
test_that("dataset has expected rows", {
  expect_equal(nrow(trump_data), 782)  
})

test_that("dataset has expected column", {
  expect_equal(ncol(trump_data), 53)  
})

# Test for missing values in critical columns
test_that("critical columns in trump_data have no missing values", {
  critical_columns <- c("pollster", "state", "candidate_name", "numeric_grade", "end_date")
  for (col in critical_columns) {
    expect_false(any(is.na(trump_data[[col]])), info = paste("Missing values found in", col, "for trump_data"))
  }
})

# Test for non-empty pollster names
test_that("pollster column in trump_data has non-null entries", {
  expect_false(any(is.na(trump_data$pollster)), "Null pollster names found in trump_data")
})

# Convert end_date to Date and check for valid range
test_that("end_date in trump_data is within a reasonable range", {
  trump_data$end_date <- as.Date(trump_data$end_date, format="%Y-%m-%d")
  expect_true(all(trump_data$end_date >= as.Date("2022-01-01") & trump_data$end_date <= as.Date("2024-12-31")), 
              "Out-of-range dates in trump_data")
})

test_that("'pollster' is character", {
  expect_type(trump_data$pollster, "character")
})


# Test that the 'state' column is character type
test_that("'state' is character", {
  expect_type(trump_data$state, "character")
})


# Test that 'candidate_name' contains only "Donald Trump"
test_that("'candidate_name' contains only 'Donald Trump'", {
  expect_true(all(trump_data$candidate_name == "Donald Trump"))
})

# Test that 'numeric_grade' is numeric and all values are 3 or higher
test_that("'numeric_grade' is numeric and >= 2.7", {
  expect_type(trump_data$numeric_grade, "double")
  expect_true(all(trump_data$numeric_grade >= 2.7))
})

# Test that 'end_date' is properly formatted as a Date object
test_that("'end_date' is Date type", {
  expect_s3_class(trump_data$end_date, "Date")
})




harris_data <- read_csv("data/02-analysis_data/analysis_harris_data.csv")


#### Test harris_data ####
# Test that the dataset has correct row and column,
test_that("dataset has expected rows", {
  expect_equal(nrow(harris_data), 733)  
})


test_that("dataset has expected column", {
  expect_equal(ncol(harris_data), 53)  
})

# Test for missing values in critical columns
test_that("critical columns in harris_data have no missing values", {
  critical_columns <- c("pollster", "state", "candidate_name", "numeric_grade", "end_date")
  for (col in critical_columns) {
    expect_false(any(is.na(harris_data[[col]])), info = paste("Missing values found in", col, "for harris_data"))
  }
})

# Test for non-empty pollster names
test_that("pollster column in harris_data has non-null entries", {
  expect_false(any(is.na(harris_data$pollster)), "Null pollster names found in harris_data")
})

test_that("end_date in harris_data is within a reasonable range", {
  harris_data$end_date <- as.Date(harris_data$end_date, format="%Y-%m-%d")
  expect_true(all(harris_data$end_date >= as.Date("2024-07-15") & harris_data$end_date <= as.Date("2024-12-31")), 
              "Out-of-range dates in harris_data")
})


test_that("'pollster' is character", {
  expect_type(harris_data$pollster, "character")
})


# Test that the 'state' column is character type
test_that("'state' is character", {
  expect_type(harris_data$state, "character")
})


# Test that 'candidate_name' contains only "Kamala Harris"
test_that("'candidate_name' contains only 'Kamala Harris", {
  expect_true(all(harris_data$candidate_name == "Kamala Harris"))
})

# Test that 'numeric_grade' is numeric and all values are 3 or higher
test_that("'numeric_grade' is numeric and >= 2.7", {
  expect_type(harris_data$numeric_grade, "double")
  expect_true(all(harris_data$numeric_grade >= 2.7))
})

# Test that 'end_date' is properly formatted as a Date object
test_that("'end_date' is Date type", {
  expect_s3_class(harris_data$end_date, "Date")
})





