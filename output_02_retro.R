
# load libraries ----------------------------------------------------------

library(icesTAF)
library(icesAdvice)
library(tidyverse)
library(reshape)
library(ss3diags)
# retro's directories

retro_dir <- "model/retro"
plot_dir <- "output/retro"


retroModels<-SSgetoutput(dirvec=file.path(retro_dir,paste("retro",0:-5,sep="")))
retroSummary <- SSsummarize(retroModels)

png(file.path(plot_dir,paste0("Retro.png")),width=7,height=4.5,res=300,units='in')
sspar(mfrow=c(1,2),plot.cex=0.8)

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

ssb.retro<-SShcbias(retroSummary,
         quant="SSB",
         verbose=F)

f.retro<-SShcbias(retroSummary,
         quant="F",
         verbose=F)

# Save output objects -----------------------------------------------------

save(ssb.retro,f.retro, file="output/retro/retrospective.RData")

# End of script -----------------------------------------------------------

rm(list=ls())