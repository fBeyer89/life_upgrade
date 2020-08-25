create_long_table_aparc<- function (data,type){
#create variables for scanner and if separately
for (i in 1:nrow(data)){
  #print(strsplit(toString(data[i,"ID"]),'_')[[1]][1])
  #print(strsplit(toString(data[i,"ID"]),'_')[[1]][2])
  data[i,"subj.ID"]=strsplit(toString(data[i,"ID"]),'_')[[1]][1]
  if (strsplit(toString(data[i,"ID"]),'_')[[1]][2]=="unwarped")
  {data[i,"scanner"]=strsplit(toString(data[i,"ID"]),'_')[[1]][3]}
  else
  {data[i,"scanner"]=strsplit(toString(data[i,"ID"]),'_')[[1]][2]}}

  
  
data$scanner=as.factor(data$scanner)
levels(data$scanner)[levels(data$scanner)=="SKYRA.long.template"] <- "SKYRA"
levels(data$scanner)[levels(data$scanner)=="VERIO.long.template"] <- "VERIO"
#

#recode hemispheres into long format

if (type=="area"){
  #print(colnames(data))
  data=data[,c(2:35,39:72,76,77)]
  
  data_l <- reshape(data, varying=list(c(1,35),
                                       c(2,36),
                                       c(3,37),
                                       c(4,38),
                                       c(5,39),
                                       c(6,40),
                                       c(7,41),
                                       c(8,42),
                                       c(9,43),
                                       c(10,44),
                                       c(11,45),
                                       c(12,46),
                                       c(13,47),
                                       c(14,48),
                                       c(15,49),
                                       c(16,50),
                                       c(17,51),
                                       c(18,52),
                                       c(19,53),
                                       c(20,54),
                                       c(21,55),
                                       c(22,56),
                                       c(23,57),
                                       c(24,58),
                                       c(25,59),
                                       c(26,60),
                                       c(27,61),
                                       c(28,62),
                                       c(29,63),
                                       c(30,64),
                                       c(31,65),
                                       c(32,66),
                                       c(33,67),
                                       c(34,68)),
                    v.names = 
                      c("bankssts", "caudalanteriorcingulate", "caudalmiddlefrontal",
                        "cuneus", "entorhinal", "fusiform", "inferiorparietal",
                        "inferiortemporal", "isthmuscingulate", "lateraloccipital",
                        "lateralorbitofrontal", "lingual", "medialorbitofrontal",
                        "middletemporal", "parahippocampal", "paracentral",
                        "parsopercularis", "parsorbitalis", "parstriangularis",
                        "pericalcarine", "postcentral", "posteriorcingulate",
                        "precentral", "precuneus","rostralanteriorcingulate",
                        "rostralmiddlefrontal","superiorfrontal",         
                        "superiorparietal","superiortemporal",        
                        "supramarginal","frontalpole",             
                        "temporalpole","transversetemporal", "insula"), 
                    times=c('rh', 'lh'), idvar='subjid', direction='long')
  colnames(data_l)[3]="hemi"
  data_l$hemi=as.factor(data_l$hemi)
  return(data_l)
}
else if (type=="thickness"){
data=data[,c(2:36,39:73,76,77)]
data_l <- reshape(data, varying=list(c(1,36),
                                             c(2,37),
                                             c(3,38),
                                             c(4,39),
                                             c(5,40),
                                             c(6,41),
                                             c(7,42),
                                             c(8,43),
                                             c(9,44),
                                             c(10,45),
                                             c(11,46),
                                             c(12,47),
                                             c(13,48),
                                             c(14,49),
                                             c(15,50),
                                             c(16,51),
                                             c(17,52),
                                             c(18,53),
                                             c(19,54),
                                             c(20,55),
                                             c(21,56),
                                             c(22,57),
                                             c(23,58),
                                             c(24,59),
                                             c(25,60),
                                             c(26,61),
                                             c(27,62),
                                             c(28,63),
                                             c(29,64),
                                             c(30,65),
                                             c(31,66),
                                             c(32,67),
                                             c(33,68),
                                             c(34,69),
                                             c(35,70)),
                      v.names = 
                        c("bankssts", "caudalanteriorcingulate", "caudalmiddlefrontal",
                          "cuneus", "entorhinal", "fusiform", "inferiorparietal",
                          "inferiortemporal", "isthmuscingulate", "lateraloccipital",
                          "lateralorbitofrontal", "lingual", "medialorbitofrontal",
                          "middletemporal", "parahippocampal", "paracentral",
                          "parsopercularis", "parsorbitalis", "parstriangularis",
                          "pericalcarine", "postcentral", "posteriorcingulate",
                          "precentral", "precuneus","rostralanteriorcingulate",
                          "rostralmiddlefrontal","superiorfrontal",         
                          "superiorparietal","superiortemporal",        
                          "supramarginal","frontalpole",             
                          "temporalpole","transversetemporal", "insula", "MeanThickness"), 
                      times=c('rh', 'lh'), idvar='subjid', direction='long')
colnames(data_l)[3]="hemi"
data_l$hemi=as.factor(data_l$hemi)
return(data_l)
}
else if (type=="volume"){
  data=data[,c(2:35,38:71,74,75)]
  #print(colnames(data))
  data_l <- reshape(data, varying=list(c(1,35),
                                       c(2,36),
                                       c(3,37),
                                       c(4,38),
                                       c(5,39),
                                       c(6,40),
                                       c(7,41),
                                       c(8,42),
                                       c(9,43),
                                       c(10,44),
                                       c(11,45),
                                       c(12,46),
                                       c(13,47),
                                       c(14,48),
                                       c(15,49),
                                       c(16,50),
                                       c(17,51),
                                       c(18,52),
                                       c(19,53),
                                       c(20,54),
                                       c(21,55),
                                       c(22,56),
                                       c(23,57),
                                       c(24,58),
                                       c(25,59),
                                       c(26,60),
                                       c(27,61),
                                       c(28,62),
                                       c(29,63),
                                       c(30,64),
                                       c(31,65),
                                       c(32,66),
                                       c(33,67),
                                       c(34,68)),
                    v.names = 
                      c("bankssts", "caudalanteriorcingulate", "caudalmiddlefrontal",
                        "cuneus", "entorhinal", "fusiform", "inferiorparietal",
                        "inferiortemporal", "isthmuscingulate", "lateraloccipital",
                        "lateralorbitofrontal", "lingual", "medialorbitofrontal",
                        "middletemporal", "parahippocampal", "paracentral",
                        "parsopercularis", "parsorbitalis", "parstriangularis",
                        "pericalcarine", "postcentral", "posteriorcingulate",
                        "precentral", "precuneus","rostralanteriorcingulate",
                        "rostralmiddlefrontal","superiorfrontal",         
                        "superiorparietal","superiortemporal",        
                        "supramarginal","frontalpole",             
                        "temporalpole","transversetemporal", "insula"), 
                    times=c('rh', 'lh'), idvar='subjid', direction='long')
  colnames(data_l)[3]="hemi"
  data_l$hemi=as.factor(data_l$hemi)
  return(data_l)
}

}

create_long_table_subcort<- function (data){
  #create variables for scanner and if separately
  for (i in 1:nrow(data)){
    #print(strsplit(toString(data[i,"Measure.volume"]),'_')[[1]][1])
    #print(strsplit(toString(data[i,"Measure.volume"]),'_')[[1]][2])
    data[i,"subj.ID"]=strsplit(toString(data[i,"Measure.volume"]),'_')[[1]][1]
    
    if (strsplit(toString(data[i,"Measure.volume"]),'_')[[1]][2]=="unwarped")
    {data[i,"scanner"]=strsplit(toString(data[i,"Measure.volume"]),'_')[[1]][3]}
    else
    {data[i,"scanner"]=strsplit(toString(data[i,"Measure.volume"]),'_')[[1]][2]}}

  data$scanner=as.factor(data$scanner)
  #levels(data$scanner)= c("SKYRA","VERIO")
  levels(data$scanner)[levels(data$scanner)=="SKYRA.long.template"] <- "SKYRA"
  levels(data$scanner)[levels(data$scanner)=="VERIO.long.template"] <- "VERIO"

  
  #recode hemispheres into long format
  data=data[,c(1,6:9,13:14,16,24:30,64:66)]
  data_l <- reshape(data, varying=list(c(2,9),
                                       c(3,10),
                                       c(4,11),
                                       c(5,12),
                                       c(6,13),
                                       c(7,14),
                                       c(8,15)),
                    v.names = 
                      c("Thalamus", "Caudate", "Putamen",
                        "Pallidum", "Hippocampus", "Amygdala", "Accumbens"), 
                    times=c('Left', 'Right'), idvar='subjid', direction='long')
  colnames(data_l)[5]="hemi"
  data_l$hemi=as.factor(data_l$hemi)
  return(data_l)
}