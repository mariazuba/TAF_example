
library("icesTAF")

# crea estructura
taf.skeleton()

# crea DATA.bib
draft.data(
  originator = "SS3",
  year = 2024,
  title = "simple",
  period = "2001-2010",file=TRUE)
taf.bootstrap() # se obtiene los datos de la carpeta boot/data

# crea SOFTWARE.bib
draft.software('boot/initial/software/ss3',file=TRUE)
taf.bootstrap() # se obtiene los datos de la carpeta boot/data, 


