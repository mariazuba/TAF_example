## Extract results of interest, write TAF output tables

## Before:
## After:

library(TAF)

# check working directory

getwd()

# create output folder and sub-folders using the function mkdir from icesTAF
mkdir("output")
mkdir("output/run")
mkdir("output/retro")

# Outputs from stock assessment -------------------------------------------

source("output_01_run.R")

# Outputs from retro ------------------------------------------------------

source("output_02_retro.R")


