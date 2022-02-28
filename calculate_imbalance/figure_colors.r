library(RColorBrewer)

gg_color_hue <- function(n) {
  hues = seq(15, 375, length = n + 1)
  hcl(h = hues, l = 65, c = 100)[1:n]
}


#hostcolors<-c("#000000", "#D55E00", "#D55E00", "#000000", "#CC79A7", "#CC79A7", "#CC79A7", "#CC79A7", "#000000", "#E69F00", "#E69F00", "#F0E442", "#F0E442", "#0072B2", "#56B4E9", "#56B4E9", "#56B4E9", "#56B4E9", "#56B4E9", "#56B4E9", "#56B4E9", "#56B4E9", "#56B4E9", "#000000", "#009E73", "#009E73", "#009E73", "#000000", "#999999")
#names(hostcolors)<-c("Saccharum", "Acmispon", "Ornithopus", "Tachigali", "Aeschynomene", "Centrolobium", "Arachis", "Stylosanthes", "Indigofera", "Lonchocarpus", "Millettia", "Desmodium", "Lespedeza", "Glycine max", "Pachyrhizus", "Erythrina", "Vigna", "Lablab", "Centrosema", "Amphicarpaea", "Rhynchosia", "Macrotyloma", "Phaseolus", "Andira", "Lupinus", "Retama", "Leobordea","Other","Acmispon_inef")


#hostlincolors<-c("#CC79A7","#F0E442","#D55E00","#009E73","#E69F00","#56B4E9","#0072B2","#000000")
#names(hostlincolors)<-c("Dalbergieae","Desmodieae","Loteae","Genisteae","Millettieae","Phaseoleae","Phaseoleae_Glycine_max","Other")

hostlincolors<-c("#CC79A7","#F0E442","#E69F00","#D55E00","#009E73","#999999","#56B4E9","#0072B2","#000000")
names(hostlincolors)<-c("Dalbergieae","Desmodieae","Loteae","Loteae_Acmispon_strigosus","Genisteae","Millettieae","Phaseoleae","Phaseoleae_Glycine_max","Other")

phenotypecolors<-c("#009E73","#E69F00","#0072B2","gray72","#8775E2")
#phenotypecolors<-c("#009E73","#E69F00","#0072B2","gray72","gray72")
names(phenotypecolors)<-c("beneficial","ineffective","nonnodulating","zbeneficialnottested","NCBI")

ICEtypeshapes<-c(25, 1, 11, 24, 6, 23, 23, 22, 4, 21, 8, 8, 8, 8,3,7,13,14)
names(ICEtypeshapes)<-c("niffix_island", "plasmid_SI", "tRNA-Arg_recombinase_nod", "tRNA-Glu_symICE", "tRNA-Gly_niffix", "tRNA-IleCAT_Sinoniffix", "tRNA-Ile_symICE", "tRNA-Pro_symICE", "tRNA-Ser_niffix_island", "tRNA-Val_symICE", "unknown_nod", "unknown_SI", "unknown_T3SSniffix", "unknown_T3SSnod","chromosome","tRNA-Gln_symICE","tRNA-Arg_symICE","tripartite_symICE")

bootsup=c(1,0.4)
#bootsup=c(1,0.3)
names(bootsup)<-c("TRUE","FALSE")

bootcol<-c("black","gray")
names(bootcol)<-c("TRUE","FALSE")
