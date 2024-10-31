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


#### Read data ####
just_trump_high_quality <- read_parquet("data/02-analysis_data/analysis_data.parquet")


#### Starter models ####
# Model 1: pct as a function of end_date
model_date <- lm(pct ~ end_date, data = just_trump_high_quality)

# Model 2: pct as a function of end_date and pollster
model_date_pollster <- lm(pct ~ end_date + pollster, data = just_trump_high_quality)

# Augment data with model predictions
just_trump_high_quality <- just_trump_high_quality |>
  mutate(
    fitted_date = predict(model_date),
    fitted_date_pollster = predict(model_date_pollster)
  )

# Plot model predictions
# Model 1
ggplot(just_trump_high_quality, aes(x = end_date)) +
  geom_point(aes(y = pct), color = "black") +
  geom_line(aes(y = fitted_date), color = "blue", linetype = "dotted") +
  theme_classic() +
  labs(y = "Trump percent", x = "Date", title = "Linear Model: pPct ~ End_date")

# Model 2
ggplot(just_trump_high_quality, aes(x = end_date)) +
  geom_point(aes(y = pct), color = "black") +
  geom_line(aes(y = fitted_date_pollster), color = "blue", linetype = "dotted") +
  facet_wrap(vars(pollster)) +
  theme_classic() +
  labs(y = "Trump percent", x = "Date", title = "Linear Model: pct ~ End_date + Pollster")



#### Save model ####
saveRDS(model_date, file = "models/model_date.rds")
saveRDS(model_date_pollster, file = "models/model_date_pollster.rds")

