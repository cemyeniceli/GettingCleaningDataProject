# Getting And Cleaning Data - Course Project

## Introduction

This repo contains the course project for [Coursera](https://www.coursera.org) ["Getting And Cleaning Data"](https://class.coursera.org/getdata-002) course that is part of [Data Science](https://www.coursera.org/specialization/jhudatascience/1?utm_medium=listingPage) specialization.

There is an R script called `dataProcess.R`. It contains the code to do the following:

1. Download a raw Human Activity Recognition Using Smartphones Dataset from UCI to `data` dir
2. Read data
3. Manipulate and process data to extract necessary tidy dataset
4. Write output data to a CSV file inside `data/output` dir

There is also a codebook called 'CodeBook.md' which describes the variables, the data, and any transformations or work that performed to clean up the data. In addition, the processed output data can also be found in this repo called 'output_dataset.csv'.

## Run from command line

1. Clone this repo
2. Run the script:

       $ Rscript dataProcess.R

3. Look for the final dataset at `output/uci_har_mean_std_averages.csv`

	   $ head -3 data/output/meanStdAverage_UCI_HAR.csv.csv