#### Preamble ####
# Purpose: Tests... [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 26 September 2024 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]


#### Workspace setup ####
library(tidyverse)
library(testthat)

data <- read_csv("/Users/dingshuo/Desktop/starter_folder-main/data/02-analysis_data/analysis_data.csv")



#### Test data ####
# Test that the dataset has 151 rows - there are 151 divisions in Australia
test_that("dataset has expected rows", {
  expect_equal(nrow(data), 393)  
})


test_that("dataset has expected column", {
  expect_equal(ncol(data), 17)  
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

