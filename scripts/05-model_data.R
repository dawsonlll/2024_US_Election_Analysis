#### Preamble ####
# Purpose: Create Models for analysis dataset.
# Author: Dingshuo Li
# Date: 31 October 2024
# Contact: dawson.li@mail.utoronto.ca
# License: MIT
# Pre-requisites:
  # - The `tidyverse` package must be installed and loaded
  # - 02-clean_data.R must have been run
  # - 04-exploratory_data_analysis.R must be conducted before
# Any other information needed? N/A


#### Workspace setup ####
library(tidyverse)
library(janitor)
library(lubridate)
library(broom)
library(splines)
library(rstanarm)
library(splines)
library(ggplot2)
library(dplyr)


#### Read data ####
just_trump_high_quality <- read_parquet("data/02-analysis_data/analysis_trump_data.parquet")
just_harris_high_quality <- read_parquet("data/02-analysis_data/analysis_harris_data.parquet")


#### Starter Trump models ####
# Linear Model: pct as a function of end_date and pollster
model_trump_date_pollster <- lm(pct ~ end_date + pollster, data = just_trump_high_quality)


# Bayesian Model for Trump
just_trump_high_quality <- just_trump_high_quality |>
  mutate(
    end_date_num = as.numeric(end_date - min(end_date))
  )

# Fit Bayesian model with spline and pollster as fixed effect

spline_trump_model <- stan_glm(
  pct ~ ns(end_date_num, df = 5) + state + pollscore + pollster, # Change df for the number of "bits" - higher numbers - more "wiggly" - but then need to worry about overfitting.
  data = just_trump_high_quality,
  family = gaussian(),
  prior = normal(0, 5),
  prior_intercept = normal(50, 10),
  seed = 1234,
  iter = 2000,
  chains = 4,
  refresh = 0
)



#### Starter Harris models ####
# Linear Model: pct as a function of end_date and pollster
model_harris_date_pollster <- lm(pct ~ end_date + pollster, data = just_harris_high_quality)


# Bayesian Model for Harris
just_harris_high_quality <- just_harris_high_quality |>
  mutate(
    end_date_num = as.numeric(end_date - min(end_date))
  )

# Fit Bayesian model with spline and pollster as fixed effect
spline_harris_model <- stan_glm(
  pct ~ ns(end_date_num, df = 5) + state + pollscore + pollster, # Change df for the number of "bits" - higher numbers - more "wiggly" - but then need to worry about overfitting.
  data = just_harris_high_quality,
  family = gaussian(),
  prior = normal(0, 5),
  prior_intercept = normal(50, 10),
  seed = 1234,
  iter = 2000,
  chains = 4,
  refresh = 0
)


#### Save model ####
saveRDS(spline_harris_model, file = "models/model_harris_bayesian.rds")
saveRDS(model_harris_date_pollster, file = "models/model_date_pollster_harris.rds")
saveRDS(spline_trump_model, file = "models/model_trump_bayesian.rds")
saveRDS(model_trump_date_pollster, file = "models/model_date_trump_pollster.rds")




