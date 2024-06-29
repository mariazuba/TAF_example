## Run analysis, write model results

## Before:
## After:

library(TAF)

# check working directory
getwd()

# create output folder and sub-folders using the function mkdir from icesTAF
mkdir("model")
mkdir("model/run")
mkdir("model/retro")

# Run script for stock assessment -----------------------------------------

source("model_01_run.R")

# Run script for retro ----------------------------------------------------

source("model_02_retro.R")

# Session info ------------------------------------------------------------

sessionInfo()

# End of script -----------------------------------------------------------

rm(list=ls())
