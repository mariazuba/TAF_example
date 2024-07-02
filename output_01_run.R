# Script information ------------------------------------------------------


# Load packages -----------------------------------------------------------

library(icesTAF)
library(r4ss)
library(tidyverse)
library(lubridate)

# Setup and read in files -----------------------------------------------------

# set assessment year (interim year)

ass.yr <- lubridate::year(Sys.Date())

# directory with output files

dir.spaly <- file.path("model/run")

# directory to save plots and tables

res.plots <- file.path("output/run")

# read in ss3 files 

inputs <- r4ss::SS_read(dir = dir.spaly, verbose = TRUE)

# Create the standard ss3 plots -----------------------------------------------

spaly <- r4ss::SS_output(dir = dir.spaly,forecast=FALSE)

r4ss::SS_plots(replist = spaly, dir = res.plots)

# summary table of data


tab.pop <-catch


write.taf(tab.pop, file="output/run/catch.csv")

# Save tables -------------------------------------------------------------

save(tab.pop, file="output/run/output_run.RData")

# End of script -----------------------------------------------------------

# End of script -----------------------------------------------------------

rm(list=ls())