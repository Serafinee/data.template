#' My Template Data for the Template Data Package
#'
#' Data from a series of experiements.
#'
#' @format ## `data_long`
#' A long format data frame with 84 rows and 11 columns:
#' \describe{
#'   \item{id}{Identification from which experimental file it came from}
#'   \item{group}{experimental group: NI, PI or Shi}
#'   \item{measurment_type}{what sugar was measured, glucose or xylose, OR if the value is standard deviation}
#'   \item{value}{The value from the experimental read out, either sugar concentration (g/L) if measurment_type is glucose or xylose, OR standard deviation number if measurment_type is std.dev}
#' }
#'
"data_long"
