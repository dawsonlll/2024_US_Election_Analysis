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

trump_data <- read_csv("data/02-analysis_data/analysis_trump_data.csv")


#### Test trump_data ####
# Test that the dataset has 1663 rows",
test_that("dataset has expected rows", {
  expect_equal(nrow(trump_data), 1662)  
})


test_that("dataset has expected column", {
  expect_equal(ncol(trump_data), 53)  
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
# Test that the dataset has 733 rows",
test_that("dataset has expected rows", {
  expect_equal(nrow(harris_data), 733)  
})


test_that("dataset has expected column", {
  expect_equal(ncol(harris_data), 53)  
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






