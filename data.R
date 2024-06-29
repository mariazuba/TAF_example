## Preprocess data, write TAF data tables

## Before:
## After:
library(TAF)
library(icesTAF)
library(r4ss)

# check working directory

getwd()


# create output folder and sub-folders using the function mkdir from icesTAF
mkdir("data")
# Read data ---------------------------------------------------------------
# read input files
inputs <- r4ss::SS_read(dir = "boot/data", verbose = TRUE)

# Prepare TAF tables ------------------------------------------------------

# catch in tonnes
catch<-subset(inputs$dat$catch, year>=(inputs$dat$styr), c('year','catch'))
# biomass acoustic survey 
bio_pelago <- subset(inputs$dat$CPUE,index==3,c("year","obs"))
bio_ecocadiz <- subset(inputs$dat$CPUE,index==2,c("year","obs"))
bio_ecocadizRec <- subset(inputs$dat$CPUE,index==4,c("year","obs"))

# total numbers at size catches Seine
catlength <- subset(inputs$dat$lencomp,FltSvy==1 & Yr>=(inputs$dat$styr) & Yr<(inputs$dat$endyr),c("Yr",paste0("l",seq(2.5,22,0.5))))

# total numbers at size catches Pelago
pellength <- subset(inputs$dat$lencomp,FltSvy==2 & Yr>=(inputs$dat$styr) & Yr<(inputs$dat$endyr),c("Yr",paste0("l",seq(2.5,22,0.5))))

# total numbers at size catches Ecocadiz
ecolength <- subset(inputs$dat$lencomp,FltSvy==3 & Yr>=(inputs$dat$styr) & Yr<(inputs$dat$endyr),c("Yr",paste0("l",seq(2.5,22,0.5))))

# total numbers at size catches Ecocadiz-Reclutas
ecoRlength <- subset(inputs$dat$lencomp,FltSvy==4 & Yr>=(inputs$dat$styr) & Yr<(inputs$dat$endyr),c("Yr",paste0("l",seq(2.5,22,0.5))))

# biological parameters
MGbio<-inputs$ctl$MG_parms[,c("LO","HI","INIT","PHASE")]

natmort<-inputs$ctl$natM
# Write TAF tables in data folder -----------------------------------------

write.taf(list(natmort = natmort, 
               catlength = catlength, 
               pellength = pellength,
               ecolength = ecolength,
               ecoRlength = ecoRlength,
               catch = catch, 
               bioPel = bio_pelago,
               bioEco = bio_ecocadiz,
               bioEcoR = bio_ecocadizRec,
               biology = MGbio),dir="./data")

# Save data in RData file  -----------------------------------------

save.image("./data/inputData.RData")

# Script info -------------------------------------------------------------

sessionInfo()

# End of script -----------------------------------------------------------

rm(list=ls())
