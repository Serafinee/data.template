## code to prepare `DATASET` dataset goes here
# Purpose: Import and clean data from a series of experiments.

# Load packages
library(readxl)
library(dplyr)

# A for loop for importing files ###########

# All files from experiments
files <- list.files("data-raw/experiments/")

# A list to store data
combined_data <- list()

# For-loop with preprocessing
for (i in seq_along(files)) {

  # Read the file in iteration i
  data <- read_excel(paste0("data-raw/experiments/", files[i]))

  # Identify which type of measurements exist in the file
  if (any(grepl("^glucose", names(data)))) {
    data <- data |> mutate(measurement_type = "glucose")
  } else if (any(grepl("^xylose", names(data)))) {
    data <- data |> mutate(measurement_type = "xylose")
  }

  # Add an id column to track the file source
  data <- data |> mutate(id = paste0("file_", i))

  # Store the processed data in the list
  combined_data[[i]] <- data
}

# Combine all files into one data frame
full_data <- bind_rows(combined_data)

#Reshaping data into long format
library(tidyr)

# Reshape the data into long format for glucose, xylose, and standard deviations
data_long <- full_data |>
  pivot_longer(
    cols = starts_with("glucose") | starts_with("xylose") | starts_with("std.dev"), # Include std.dev columns
    names_to = c("type", "group"),                                                 # Split column names into two parts
    names_sep = "_",                                                               # Separator between parts
    values_to = "value"                                                            # New column for the values
  ) |>
  mutate(
    measurement_type = case_when(
      type == "glucose" ~ "glucose",
      type == "xylose" ~ "xylose",
      startsWith(type, "std.dev") ~ "std.dev",
      TRUE ~ NA_character_  # Catch-all for unexpected cases
    )
  )
# Save the cleaned data
usethis::use_data(data_long, overwrite = TRUE)
