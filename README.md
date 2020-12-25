# Japanese J1 League Results from 2012-2020

## Introduction

This repository contains an R script for scraping historical J1 League match results. The dataset is available for download on [Kaggle](https://www.kaggle.com/irkaal/japanese-j1-league).

## Scraping

You can scrape the dataset from
[Football-Data.co.uk](https://football-data.co.uk) with:

```r
# install.packages(
#   c(
#     "arrow",
#     "tidyverse",
#     "usethis"
#   )
# )
source("results.R")
```

The csv and parquet files are stored in the data folder.
