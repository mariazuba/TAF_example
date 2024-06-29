
# Load packages -----------------------------------------------------------

library(r4ss)

old_wd <- getwd()
# Get input files --------------------------------------------------------

cp("boot/data/data.ss", "model/run")
cp("boot/data/control.ss", "model/run")
cp("boot/data/forecast.ss", "model/run")
cp("boot/data/starter.ss", "model/run")

# Get model executable ----------------------------------------------------
cp("boot/software/ss3", "model/run")

# Save main directory
wd <- paste0(getwd(),"/model/run")

# Run SS from r (need to change directory to run SSs)
setwd(wd)

system(wd)
system(paste0("chmod 755 ",wd,"/ss3"))
r4ss::run(dir=wd, exe="ss3", skipfinished=FALSE, show_in_console =T)

setwd(old_wd)
# End of script -----------------------------------------------------------

rm(list=ls())