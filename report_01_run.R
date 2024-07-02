# Load packages -----------------------------------------------------------

library(icesTAF)
library(r4ss)
library(tidyverse)
library(lubridate)
library(ggpubr)
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
## Temporal coverage of input data ----
png(file.path("report/run/input_data.png"),width=9,height=5,res=300,units='in')
sspar(mfrow = c(1, 1), plot.cex = 0.8)
SSplotData(replist, subplots = 2,cex.main = 0.8,cex = 1,margins = c(2.1, 2.1, 1.1, 8.1))
dev.off()

## Growth curve, length-weight relationship and maturity ----
png(file.path("report/run/Biology.png"),width=10,height=8,res=300,units='in')
sspar(mfrow = c(2, 2), plot.cex = 0.8)
SSplotBiology(replist, subplot = c(1,5,6),seas=4,mainTitle = FALSE)
dev.off()

## Fit data: Abundance indices ----
png(file.path("report/run/Indices_fit.png"),width=6,height=7,res=300,units='in')
sspar(mfrow = c(3, 2), plot.cex = 0.6)
SSplotIndices(replist, subplots = c(2,3),mainTitle = T)
dev.off()

## Fit data: Length composition (aggregated) ----
png(file.path("report/run/Length_fit_agg.png"),width=8,height=9,res=300,units='in')
SSplotComps(replist, subplots = c(21),kind = "LEN",maxrows = 2,maxcols = 2,
            showsampsize = F,showeffN = F,mainTitle = T)
dev.off()

## Fit data: Length composition by source data ----
### *FLEET by quarters* ----
png(file.path("report/run/Length_fit_Seine.png"),width=10,height=9,res=300,units='in')
SSplotComps(replist, subplots = c(1),kind = "LEN",fleets = 1,maxrows = 12,maxcols =12,
            showsampsize = F,showeffN = F,mainTitle = T)
dev.off()

### *PELAGO spring survey* ----
png(file.path("report/run/Length_fit_Pelago.png"),width=8,height=9,res=300,units='in')
SSplotComps(replist, subplots = c(1),kind = "LEN",fleets = 3,maxrows = 6,maxcols = 4,
            showsampsize = F,showeffN = F,mainTitle = T)
dev.off()

### *ECOCADIZ summer survey* ----
png(file.path("report/run/Length_fit_Ecocadiz.png"),width=8,height=9,res=300,units='in')
SSplotComps(replist, subplots = c(1),kind = "LEN",fleets = 2,maxrows = 4,maxcols = 4,
            showsampsize = F,showeffN = F,mainTitle = T)
dev.off()

### *ECOCADIZ-RECLUTAS fall survey* ----
png(file.path("report/run/Length_fit_EcocadizRecl.png"),width=8,height=9,res=300,units='in')
SSplotComps(replist, subplots = c(1),kind = "LEN",fleets = 4,maxrows = 4,maxcols = 4,
            showsampsize = F,showeffN = F,mainTitle = T)
dev.off()

## Residuals length composition by source data

### *FLEET by quarters* ----
png(file.path("report/run/Length_residuals_Seine.png"),width=9,height=4,res=300,units='in')
SSplotComps(replist, subplots = c(24),kind = "LEN",fleets = 1,maxrows = 12,maxcols = 5,
            showsampsize = F,showeffN = F)
dev.off()

### *PELAGO spring survey* ----
png(file.path("report/run/Length_residuals_Pelago.png"),width=9,height=4,res=300,units='in')
SSplotComps(replist, subplots = c(24),kind = "LEN",fleets =3,maxrows = 12,maxcols = 5,
            showsampsize = F,showeffN = F)
dev.off()

### *ECOCADIZ summer survey* ----
png(file.path("report/run/Length_residuals_Ecocadiz.png"),width=9,height=4,res=300,units='in')
SSplotComps(replist, subplots = c(24),kind = "LEN",fleets = 2,maxrows = 12,maxcols = 5,
            showsampsize = F,showeffN = F)
dev.off()

### *ECOCADIZ-RECLUTAS fall survey* ----
png(file.path("report/run/Length_residuals_EcocadizRecl.png"),width=9,height=4,res=300,units='in')
SSplotComps(replist, subplots = c(24),kind = "LEN",fleets = 4,maxrows = 12,maxcols = 5,
            showsampsize = F,showeffN = F)
dev.off()

## Run test indices ----
png(file.path("report/run/Runtest_residuals_indices.png"),width=7,height=7,res=300,units='in')
sspar(mfrow = c(4, 1), plot.cex = 0.8)
SSplotRunstest(replist,subplots = "cpue", add = TRUE, legendcex = 0.8,verbose = F)
SSplotJABBAres(replist,subplots = "cpue", add = TRUE, legendcex = 0.8,verbose = F)
dev.off()

## Run test length ----
png(file.path("report/run/Runtest_residuals_length.png"),width=7,height=7,res=300,units='in')
sspar(mfrow = c(3, 2), plot.cex = 0.8)
SSplotRunstest(replist,subplots = "len", add = TRUE, legendcex = 0.8,verbose = F)
SSplotJABBAres(replist,subplots = "len", add = TRUE, legendcex = 0.8,verbose = F)
dev.off()

## Selectivity ----
png(file.path("report/run/Selectividad.png"),width=6,height=5,res=300,units='in')
SSplotSelex(replist,subplots =1)
dev.off()

## time series ----

stdreptlist<-data.frame(replist$derived_quants[,1:3])
summary <- read.table(("model/run/ss_summary.sso"),header=F,sep="",na="NA",fill=T) 

year <- unique(inputs$dat$catch$year[inputs$dat$catch$year != -999])


ssb<-stdreptlist %>% filter(grepl("SSB", Label)) %>% mutate(year = as.numeric(sub("SSB_", "", Label))) %>%
  filter(!is.na(year)) %>% 
  filter(year >= inputs$dat$styr & year <= inputs$dat$endyr) %>%  # Filtrar por el rango de años
  select(year,Value,StdDev)


recr<-stdreptlist %>% filter(grepl("Recr", Label)) %>% mutate(year = as.numeric(sub("Recr_", "", Label))) %>%
  filter(!is.na(year)) %>% 
  filter(year >= inputs$dat$styr & year <= inputs$dat$endyr) %>%  # Filtrar por el rango de años
  select(year,Value,StdDev)

ft<-stdreptlist %>% filter(grepl("F", Label)) %>% mutate(year = as.numeric(sub("F_", "", Label))) %>% filter(!is.na(year)) %>% 
  filter(year >= inputs$dat$styr & year <= inputs$dat$endyr) %>%  # Filtrar por el rango de años
  select(year,Value,StdDev)

bt<-summary %>% filter(grepl("TotBio", V1)) %>% 
  mutate(year = as.numeric(sub("TotBio_", "", V1))) %>% 
  filter(!is.na(year)) %>% 
  filter(year >= inputs$dat$styr & year <= inputs$dat$endyr) %>%  # Filtrar por el rango de años
  select(year,V2)

catch<-summary %>% filter(grepl("TotCatch", V1)) %>% 
  mutate(year = as.numeric(sub("TotCatch_", "", V1))) %>% 
  filter(!is.na(year)) %>% 
  filter(year >= inputs$dat$styr & year <= inputs$dat$endyr) %>%  # Filtrar por el rango de años
  select(year,V2)


data<-data.frame(yrs=recr$year,
                 Rt=round(as.numeric(recr$Value),0), 
                 BD=round(as.numeric(ssb$Value),0),
                 Bt=round(as.numeric(bt$V2),0),
                 Ft=round(as.numeric(ft$Value),2),
                 Ct=round(as.numeric(catch$V2),0))
data

rt<- data.frame(x=recr$year,
                y=recr$Value,
                lower = (recr$Value-1.96*recr$StdDev),
                upper = (recr$Value+1.96*recr$StdDev))%>% 
  mutate(indicador='Rt')
Bt<- data.frame(x=bt$year,
                y=as.numeric(bt$V2))%>% 
  mutate(indicador='BT')

Ct<- data.frame(x=catch$year,
                y=as.numeric(catch$V2))%>% 
  mutate(indicador='CT')

bd<- data.frame(x=ssb$year,
                y=ssb$Value,
                lower = (ssb$Value-1.96*ssb$StdDev),
                upper = (ssb$Value+1.96*ssb$StdDev))%>% 
  mutate(indicador='SSB')

Ft<- data.frame(x=ft$year,
                y=ft$Value,
                lower = (ft$Value-1.96*ft$StdDev),
                upper = (ft$Value+1.96*ft$StdDev))%>% 
  mutate(indicador='Ft')

p1<- ggplot(data=rt)+
  geom_line(aes(x=x,y=y))+
  geom_ribbon(aes(ymin=lower,ymax=upper,x=x),alpha=0.2)+
  labs(x = '', y = "Recluitment")  +
  scale_x_continuous(breaks = seq(from = 1960, to = 2060, by = 4)) +
  theme_bw(base_size=9) +
  ggtitle('')+
  theme(plot.title = element_text(hjust = 0.5),legend.position="top")

p2<- ggplot(data=Bt)+
  geom_line(aes(x=x,y=y))+
  #geom_ribbon(aes(ymin=lower,ymax=upper,x=x),alpha=0.2)+
  labs(x = '', y = "Total biomass 1+")  +
  scale_x_continuous(breaks = seq(from = 1960, to = 2060, by = 4)) +
  theme_bw(base_size=9) +
  ggtitle('')+
  theme(plot.title = element_text(hjust = 0.5),legend.position="top")

p3<- ggplot(data=bd)+
  geom_line(aes(x=x,y=y))+
  geom_ribbon(aes(ymin=lower,ymax=upper,x=x),alpha=0.2)+
  labs(x = '', y = "SSB")  +
  scale_x_continuous(breaks = seq(from = 1960, to = 2060, by = 4)) +
  theme_bw(base_size=9) +
  ggtitle('')+
  theme(plot.title = element_text(hjust = 0.5),legend.position="top")

p4<- ggplot(data=Ft)+
  geom_line(aes(x=x,y=y))+
  geom_ribbon(aes(ymin=lower,ymax=upper,x=x),alpha=0.2)+
  labs(x = '', y = "F")  +
  scale_x_continuous(breaks = seq(from = 1960, to = 2060, by = 4)) +
  theme_bw(base_size=9) +
  ggtitle('')+
  theme(plot.title = element_text(hjust = 0.5),legend.position="top")

p5<- ggplot(data=Ct)+
  geom_line(aes(x=x,y=y))+
  #geom_ribbon(aes(ymin=lower,ymax=upper,x=x),alpha=0.2)+
  labs(x = '', y = "Catch")  +
  scale_x_continuous(breaks = seq(from = 1960, to = 2060, by = 4)) +
  theme_bw(base_size=9) +
  ggtitle('')+
  theme(plot.title = element_text(hjust = 0.5),legend.position="top")

fig<-ggarrange(p2,p1,p4,ncol=1,nrow=3,common.legend=TRUE,legend='right') 
ggsave("report/run/SeriesTiempo.png", fig,  width=7, height=6)

setwd(wd)
