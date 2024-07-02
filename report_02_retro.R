# Load packages -----------------------------------------------------------

library(icesTAF)
library(r4ss)
library(tidyverse)
library(lubridate)
library(ggpubr)
# working directory
wd <- getwd()

  retroModels<-SSgetoutput(dirvec=file.path("model/retro",
                                            paste("retro",0:-4,sep="")))
  retroSummary <- SSsummarize(retroModels)
  
  png(file.path("report/retro/Retro.png"),width=7,height=7.5,res=300,units='in')
  sspar(mfrow=c(2,1),plot.cex=0.8)
  
  rb = SSplotRetro(retroSummary,
                   add=T,
                   forecast = T,
                   legend = T,
                   verbose=F)
  
  rf = SSplotRetro(retroSummary,
                   add=T,
                   subplots="F",
                   forecast = T,
                   legend = T,
                   legendloc = "topleft",
                   legendcex = 0.8,
                   verbose=F)
  dev.off()


rho_ssb<-SShcbias(retroSummary,
         quant="SSB",
         verbose=F)

rho_f<-SShcbias(retroSummary,
         quant="F",
         verbose=F)

