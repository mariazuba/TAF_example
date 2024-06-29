# Script information ------------------------------------------------------

# run retrospective analysis 
# Load packages -----------------------------------------------------------

library(r4ss)
library(icesTAF)
library(lubridate)

old_wd <- getwd()
# Run retrospective analysis ----------------------------------------------
# copy files to the retro directory --
run.dir<-paste0(getwd(),"/model/run")
retro.dir <- paste0(getwd(),"/model/retro")

copy_SS_inputs(dir.old = run.dir, 
               dir.new =  retro.dir,
               copy_exe = TRUE,
               verbose = FALSE)

wd <- paste0(getwd(),"/model/retro")
system(wd)
system(paste0("chmod 755 ",wd,"/ss3"))
retro(dir = wd, oldsubdir = "", newsubdir = "", 
      years = 0:-5,exe = "ss3")

# End of script -----------------------------------------------------------
setwd(old_wd)
rm(list=ls())
