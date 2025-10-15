## code to prepare `DATASET` dataset goes here

usethis::use_data(DATASET, overwrite = TRUE)

# Purpose: Import and clean data from a series of experiments.

# Load packages
library(readxl)
library(dplyr)

# A for loop for importing files ###########

# All files from experiments
files <- list.files("data-raw/experiments/")

# A list to store data
combined_data <- list()

# For-loop
for (i in seq_along(files)) {

  # Read the file in iteration i
  combined_data[[i]] <- read_excel(
    paste0("data-raw/experiments/", files[i])
  ) |>
    # Add a new id column to track the file source
    mutate(id = paste0("file_", i))
}

# Combine all files into one data frame
mytemplatedata <- bind_rows(combined_data)

# Save the cleaned data
usethis::use_data(mytemplatedata, overwrite = TRUE)
