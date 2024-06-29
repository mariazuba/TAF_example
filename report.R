## Prepare plots and tables for report

## Before:
## After:

library(TAF)

# check working directory

getwd()

# create output folder and sub-folders using the function mkdir from icesTAF
mkdir("report")
mkdir("report/run")
mkdir("report/retro")


# Create report figs and tabs ---------------------------------------------

source("report_01_run.R")
source("report_02_retro.R")

# Session info ------------------------------------------------------------

sessionInfo()
