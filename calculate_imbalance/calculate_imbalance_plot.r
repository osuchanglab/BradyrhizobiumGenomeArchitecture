source("figure_colors.r")
library(ggplot2)
library(tidyr)
library(patchwork)


cladetab<-read.table("cladetable.txt",header=T,stringsAsFactors=F,sep="\t")


skewitab<-read.table("skewi_table.txt",header=T,stringsAsFactors=F,sep="\t")


mytab<-read.table("strain_ori_ter_table.txt",header=T,stringsAsFactors=F,sep="\t")
mytab$rep1length<-mytab$ter
mytab$rep2length<-mytab$genomesize - mytab$ter
mytab$halfsize <- mytab$genomesize / 2
mytab$replichore_imbalance<-abs(mytab$halfsize - mytab$rep1length) / mytab$halfsize * 100
mytab$degreeimbalance<-abs((mytab$rep1length / mytab$genomesize * 360) - 180)
mytab$abscds<-abs(mytab$cdscumskew)

mytab$icetype<-gsub("^.*with__","",mytab$strain)
mytab$icetype<-gsub("__from__.*","",mytab$icetype)

mytab$icesource<-gsub("^.*from__","",mytab$strain)

mytab$strainname<-gsub("__with__.*","",mytab$strain)

mytab$strainnamelab<-gsub(".noSI.rot","",mytab$strainname)
mytab$strainnamelabbetter<-mytab$strainnamelab
mytab$strainnamelabbetter<-gsub("^B_","",mytab$strainnamelabbetter)
mytab$strainnamelabbetter<-gsub("^sp._","",mytab$strainnamelabbetter)
mytab$strainnamelabbetter<-gsub("japonicum_","",mytab$strainnamelabbetter)
mytab$strainnamelabbetter<-gsub("diazoefficiens_","",mytab$strainnamelabbetter)
mytab$strainnamelabbetter<-gsub("lablabi_","",mytab$strainnamelabbetter)
mytab$strainnamelabbetter<-gsub("erythrophlei_","",mytab$strainnamelabbetter)
mytab$strainnamelabbetter<-gsub("icense_","",mytab$strainnamelabbetter)
mytab$strainnamelabbetter<-gsub("oligotrophicum_","",mytab$strainnamelabbetter)
mytab$strainnamelabbetter<-gsub("ottawaense_","",mytab$strainnamelabbetter)
mytab$strainnamelabbetter<-gsub("elkanii_","",mytab$strainnamelabbetter)
mytab$strainnamelabbetter<-gsub("genosp._","",mytab$strainnamelabbetter)
mytab$strainnamelabbetter<-gsub("_Brage","",mytab$strainnamelabbetter)
mytab$strainnamelabbetter<-gsub("_Brael","",mytab$strainnamelabbetter)
mytab$strainnamelabbetter<-gsub("japonicum","",mytab$strainnamelabbetter)
mytab$strainnamelabbetter<-gsub("diazoefficiens","",mytab$strainnamelabbetter)
mytab$strainnamelabbetter<-gsub("_Bra1417","",mytab$strainnamelabbetter)
mytab$strainnamelabbetter<-gsub("_str._","_",mytab$strainnamelabbetter)
mytab$strainnamelabbetter<-gsub("inoc2","#2",mytab$strainnamelabbetter)
mytab$strainnamelabbetter<-gsub("inoc4-2","#4",mytab$strainnamelabbetter)
mytab$strainnamelabbetter<-gsub("11LoS34_2","#155",mytab$strainnamelabbetter)
mytab$strainnamelabbetter<-gsub("11LoS34_4","#156",mytab$strainnamelabbetter)
mytab$strainnamelabbetter<-gsub("11LoS34_6","#183",mytab$strainnamelabbetter)
mytab$strainnamelabbetter<-gsub("11LoS34_10","#184",mytab$strainnamelabbetter)
mytab$strainnamelabbetter<-gsub("13LoS100_1","#195",mytab$strainnamelabbetter)
mytab$strainnamelabbetter<-gsub("13LoS70_1","#191",mytab$strainnamelabbetter)
mytab$strainnamelabbetter<-gsub("13LoS70_2","#192",mytab$strainnamelabbetter)
mytab$strainnamelabbetter<-gsub("13LoS28_1","#131",mytab$strainnamelabbetter)
mytab$strainnamelabbetter<-gsub("11LoS18_3","#172",mytab$strainnamelabbetter)
mytab$strainnamelabbetter<-gsub("11LoS11_3","#170",mytab$strainnamelabbetter)
mytab$strainnamelabbetter<-gsub("13LoS78_1","#200",mytab$strainnamelabbetter)
mytab$strainnamelabbetter<-gsub("05LoS16R3_25","#40",mytab$strainnamelabbetter)
mytab$strainnamelabbetter<-gsub("inoc15-2","#15",mytab$strainnamelabbetter)
mytab$strainnamelabbetter<-gsub("11LoS7_1","#187",mytab$strainnamelabbetter)

mytab$strainclade<-cladetab$clade[match(mytab$strainname,cladetab$strain)]

mytab$skewi<-skewitab$skewi[match(mytab$strain,skewitab$strain)]

mytab$withSI<-gsub("^.*__with__","",mytab$strain)
mysubimballong<-mytab[,c("strainname","withSI","replichore_imbalance")]
mysubdegreelong<-mytab[,c("strainname","withSI","degreeimbalance")]
mysubcdslong<-mytab[,c("strainname","withSI","abscds")]
mysubdegreewide<-spread(mysubdegreelong,withSI,degreeimbalance)
mysubimbalwide<-spread(mysubimballong,withSI,replichore_imbalance)
mysubcdswide<-spread(mysubcdslong,withSI,abscds)

pdf("Figure_sim_degree_vs_cds.pdf",width=9,height=5)

ggplot(mytab,aes(x=degreeimbalance,y=abscds,shape=icetype,colour=strainclade,fill=strainclade))  + geom_point() +
scale_shape_manual(values=ICEtypeshapes)

dev.off()

mytabclade1<-mytab[mytab$strainname %in% cladetab$strain[cladetab$clade == "clade1"],]

pdf("Figure_sim_degree_vs_cds_metaepi.pdf",width=8.5,height=8)

p1<-ggplot(mytabclade1,aes(degreeimbalance,colour=icetype,fill=icetype)) + 
geom_density(alpha=0.1) 

p2<-ggplot(mytabclade1,aes(x=degreeimbalance,y=abscds,shape=icetype,colour=icetype,fill=icetype))  + 
geom_point(aes(alpha=0.5)) +
scale_shape_manual(values=ICEtypeshapes)

p1 / p2 + plot_layout(heights=c(0.6,2))

dev.off()


pdf("Figure_sim_percimbal_vs_cds_metaepi.pdf",width=8.5,height=8)

p1<-ggplot(mytabclade1,aes(replichore_imbalance,colour=icetype,fill=icetype)) + geom_density(alpha=0.1)

p2<-ggplot(mytabclade1,aes(x=replichore_imbalance,y=abscds,shape=icetype,colour=icetype,fill=icetype))  + 
geom_text(aes(label=strainnamelab),size=0.5) +
scale_shape_manual(values=ICEtypeshapes)

p1 / p2 + plot_layout(heights=c(0.6,2))

dev.off()




#plot with native indicated
mytabclade1$native=mytabclade1$strainnamelab == mytabclade1$icesource
mytabclade1[mytabclade1$strain %in% c("05LoS16R3_25.noSI.rot__with__chromosome","11LoS7_1.noSI.rot__with__chromosome","B_sp._AT1.noSI.rot__with__chromosome","B_sp._BF49.noSI.rot__with__chromosome","B_sp._DOA1.noSI.rot__with__chromosome","B_sp._DOA9.noSI.rot__with__chromosome","B_sp._S23321.noSI.rot__with__chromosome","inoc15-2.noSI.rot__with__chromosome"),]$native <- TRUE
pdf("Figure_sim_percimbal_vs_cds_metaepi_labelnative.pdf",width=8.5,height=8)

p1<-ggplot(mytabclade1,aes(replichore_imbalance,colour=icetype,fill=icetype)) + geom_density(alpha=0.1)

p2<-ggplot(mytabclade1,aes(x=replichore_imbalance,y=abscds,shape=icetype,colour=icetype,fill=icetype))  +
geom_point(aes(alpha=0.5)) +
geom_text(data=subset(mytabclade1, native == TRUE),aes(label=strainnamelabbetter),color="black",size=0.8) +
scale_shape_manual(values=ICEtypeshapes)

p1 / p2 + plot_layout(heights=c(0.6,2))

dev.off()



pdf("Figure_sim_percimbal_vs_skewi_metaepi_labelnative.pdf",width=8.5,height=8)

p1<-ggplot(mytabclade1,aes(replichore_imbalance,colour=icetype,fill=icetype)) + geom_density(alpha=0.1)

p2<-ggplot(mytabclade1,aes(x=replichore_imbalance,y=skewi,shape=icetype,colour=icetype,fill=icetype))  +
geom_point(aes(alpha=0.5)) +
geom_text(data=subset(mytabclade1, native == TRUE),aes(label=strainnamelabbetter),color="black",size=0.8) +
scale_shape_manual(values=ICEtypeshapes)

p1 / p2 + plot_layout(heights=c(0.6,2))

dev.off()

