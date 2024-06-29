# Load packages -----------------------------------------------------------

library(icesTAF)
library(r4ss)
library(tidyverse)
library(lubridate)

# working directory

wd <- getwd()

# Assessment year
ass.yr <- lubridate::year(Sys.Date())

# directory with output files

dir0 <- file.path("model/run")
replist <- r4ss::SS_output(dir = dir0,forecast=FALSE)
# read in ss3 files 

inputs <- r4ss::SS_read(dir = dir0, verbose = TRUE)

# Figures --------------------------------------------


