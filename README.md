# Starter folder

## Overview

This project predicts the U.S. election outcome by analyzing polling data for Kamala Harris and Donald Trump. Using linear and Bayesian models, we explore trends and uncertainties in voter support over time. After processing poll data from various sources, we applied statistical models to capture each candidate’s support trajectory, integrating updates as new data arrives.

## File Structure

The repo is structured as:

-  `simulated data` contains the simulated 1000 data.
-   `data/raw_data` contains the raw data as obtained from  FiveThirtyEight.
-   `data/analysis_data` contains the cleaned dataset that was constructed.
-   `model` contains fitted models. 
-   `other` contains relevant literature, details about LLM chat interactions, and sketches.
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper. 
-   `scripts` contains the R scripts used to simulate, download and clean data.


## Statement on LLM usage

Aspects of this project were developed with the assistance of the AI tool, ChatGPT. The abstract, introduction, result, and discussion sections were written with the help of ChatGPT. Portions of the code were adapted from resources in Telling Stories with Data and with ChatGPT. Additionally, the modelling, prediction, results, data analysis, introduction, and discussion sections were conducted using ChatGPT-4o. The entire chat history available in inputs/llms/usage.txt.