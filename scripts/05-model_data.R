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

# Model: pct as a function of end_date and pollster
model_trump_date_pollster <- lm(pct ~ end_date + pollster, data = just_trump_high_quality)

# Augment data with model predictions from model_trump_date_pollster
just_trump_high_quality <- just_trump_high_quality %>%
  mutate(
    fitted_date_pollster = predict(model_trump_date_pollster)
  )

# Plot Model with Predictions
ggplot(just_trump_high_quality, aes(x = end_date)) +
  geom_point(aes(y = pct), color = "black") +
  geom_line(aes(y = fitted_date_pollster), color = "blue", linetype = "dotted") +
  facet_wrap(vars(pollster)) +
  theme_classic() +
  labs(y = "Trump percent", x = "Date", title = "Linear Model: pct ~ End_date + Pollster")


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

trump_predictions <- posterior_predict(spline_trump_model)

# Calculate summary statistics for plotting
# Get mean prediction and 95% credible intervals
just_trump_high_quality <- just_trump_high_quality %>%
  mutate(
    mean_pred = colMeans(trump_predictions),
    lower_credible = apply(trump_predictions, 2, quantile, probs = 0.025),
    upper_credible = apply(trump_predictions, 2, quantile, probs = 0.975)
  )

# Plot with credible intervals
ggplot(just_trump_high_quality, aes(x = end_date_num, y = pct)) +
  geom_point(color = "black", alpha = 0.5) +
  geom_line(aes(y = mean_pred), color = "blue") +
  geom_ribbon(aes(ymin = lower_credible, ymax = upper_credible), alpha = 0.2, fill = "blue") +
  facet_wrap(vars(state)) +
  theme_classic() +
  labs(y = "Trump Percent", x = "Date", title = "Bayesian Regression Spline: pct ~ Spline(End_date) + State + Pollscore + Pollster")







#### Starter Harris models ####

# Linear Model: pct as a function of end_date and pollster
model_harris_date_pollster <- lm(pct ~ end_date + pollster, data = just_harris_high_quality)

# Augment data with model predictions
just_harris_high_quality <- just_harris_high_quality |>
  mutate(
    fitted_date_pollster = predict(model_date_pollster)
  )

ggplot(just_harris_high_quality, aes(x = end_date)) +
  geom_point(aes(y = pct), color = "black") +
  geom_line(aes(y = fitted_date_pollster), color = "blue", linetype = "dotted") +
  facet_wrap(vars(pollster)) +
  theme_classic() +
  labs(y = "Harris percent", x = "Date", title = "Linear Model: pct ~ End_date + Pollster")

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

harris_predictions <- posterior_predict(spline_harris_model)

# Calculate summary statistics for plotting
# Get mean prediction and 95% credible intervals
just_harris_high_quality <- just_harris_high_quality %>%
  mutate(
    mean_pred = colMeans(harris_predictions),
    lower_credible = apply(harris_predictions, 2, quantile, probs = 0.025),
    upper_credible = apply(harris_predictions, 2, quantile, probs = 0.975)
  )

# Plot with credible intervals
ggplot(just_harris_high_quality, aes(x = end_date_num, y = pct)) +
  geom_point(color = "black", alpha = 0.5) +
  geom_line(aes(y = mean_pred), color = "blue") +
  geom_ribbon(aes(ymin = lower_credible, ymax = upper_credible), alpha = 0.2, fill = "blue") +
  facet_wrap(vars(state)) +
  theme_classic() +
  labs(y = "Harris Percent", x = "Date (numeric)", title = "Bayesian Regression Spline: pct ~ Spline(End_date) + State + Pollscore + Pollster")



#### Save model ####
saveRDS(spline_harris_model, file = "models/model_harris_bayesian.rds")
saveRDS(model_harris_date_pollster, file = "models/model_date_pollster_harris.rds")
saveRDS(spline_trump_model, file = "models/model_trump_bayesian.rds")
saveRDS(model_trump_date_pollster, file = "models/model_date_trump_pollster.rds")




