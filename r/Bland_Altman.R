create_bland_altman_cort <- function (data, measure, side, roi, limits=1.96){

measure_c <- parse(text = measure)[[1]]  
side_c <- parse(text = side)[[1]]
roi_c <- parse(text = roi)[[1]] 

tmp.verio=data[data$hemi==side&data$scanner=="VERIO",roi]
tmp.skyra=data[data$hemi==side&data$scanner=="SKYRA",roi]
tmp.data=data.frame(tmp.verio, tmp.skyra)
tmp.data$Diff=tmp.data$tmp.verio-tmp.data$tmp.skyra
tmp.data$Avg=(tmp.data$tmp.verio+ tmp.data$tmp.skyra)/2

if (measure=="CT") 
{xlabel=bquote(atop(Average~of~.(measure_c)~'for',~.(side_c)~.(roi_c)~'in'~mm)) 
 ylabel=expression(paste("Difference Verio-Skyra in mm"))
  } else if (measure=="CA")
{xlabel=bquote(atop(Average~of~.(measure_c)~'for',~.(side_c)~.(roi_c)~'in'~mm^{2}))
ylabel=expression(paste("Difference Verio-Skyra in ", mm^{2}))
  } else 
  {xlabel=bquote(atop(Average~of~.(measure_c)~'for',~.(side_c)~.(roi_c)~'in'~mm^{3}))
  ylabel=expression(paste("Difference Verio-Skyra in ", mm^{3}))}
meandiff=mean(tmp.data$Diff)
lower_lim=mean(tmp.data$Diff) - (limits * sd(tmp.data$Diff))
upper_lim=mean(tmp.data$Diff) + (limits * sd(tmp.data$Diff))

p1 <- ggplot(tmp.data, aes(x = Avg, y = Diff)) +
  geom_point() +
  geom_hline(yintercept = 0, colour = "black", size = 0.2) +
  geom_hline(yintercept = mean(tmp.data$Diff), colour = "blue", size = 0.5) +
  geom_hline(yintercept = mean(tmp.data$Diff) - (limits * sd(tmp.data$Diff)), colour = "red", size = 0.5) +
  geom_hline(yintercept = mean(tmp.data$Diff) + (limits * sd(tmp.data$Diff)), colour = "red", size = 0.5) +
  labs(x=xlabel, y=ylabel)#+
  #theme(plot.margin = unit(c(0.8,1.5, 0.8, 0.8), "cm"))

ggsave(paste("/data/pt_nro186_lifeupdate/Results/GMV_project_evelyn_frauke/Analysis_R/Figures/PLOS/Revision/Bland_Altmann_plot_",measure,"_",side, "_",roi, ".eps", sep=""), p1, dpi=300,width=18, units = "cm")
return(list(p1,meandiff,lower_lim,upper_lim))
}


create_bland_altman_subcort <- function (data, side, roi, limits=1.96){

side_c <- parse(text = side)[[1]]
roi_c <- parse(text = roi)[[1]] 

tmp.verio=data[data$hemi==side&data$scanner=="VERIO",roi]
tmp.skyra=data[data$hemi==side&data$scanner=="SKYRA",roi]
tmp.data=data.frame(tmp.verio, tmp.skyra)
tmp.data$Diff=tmp.data$tmp.verio-tmp.data$tmp.skyra
tmp.data$Avg=(tmp.data$tmp.verio+ tmp.data$tmp.skyra)/2

meandiff=mean(tmp.data$Diff)
lower_lim=mean(tmp.data$Diff) - (limits * sd(tmp.data$Diff))
upper_lim=mean(tmp.data$Diff) + (limits * sd(tmp.data$Diff))


xlabel=bquote(Average~of~GMV~'for'~.(side_c)~.(roi_c)~'in'~mm^{3}) 
ylabel=expression(paste("Difference Verio - Skyra in ", mm^{3}))

p1 <- ggplot(tmp.data, aes(x = Avg, y = Diff)) +
  geom_point() +
  geom_hline(yintercept = 0, colour = "black", size = 0.2) +
  geom_hline(yintercept = mean(tmp.data$Diff), colour = "blue", size = 0.5) +
  geom_hline(yintercept = mean(tmp.data$Diff) - (limits * sd(tmp.data$Diff)), colour = "red", size = 0.5) +
  geom_hline(yintercept = mean(tmp.data$Diff) + (limits * sd(tmp.data$Diff)), colour = "red", size = 0.5) +
  labs(x=xlabel, y=ylabel) #+
  #theme(plot.margin = unit(c(0.8,1.5, 0.8, 0.8), "cm")) #top, right, bottom, left

ggsave(paste0("/data/pt_nro186_lifeupdate/Results/GMV_project_evelyn_frauke/Analysis_R/Figures/PLOS/Revision/Bland_Altmann_plot_subcort_", side,".eps", sep=""), p1, dpi=300,width=18, units = "cm")
return(list(p1,meandiff,lower_lim,upper_lim))
}

create_bland_altman_subcort_all_in_one <- function (data, limits=1.96){
#plot all ROI in one plot so to prove to reviewer that bias does not depend on variability
#
  
xlabel=bquote(Average~of~GMV~'for subcortical regions in'~mm^{3}) 
ylabel=expression(paste("Difference Verio - Skyra in ", mm^{3}))

    

data_l <- reshape(data, varying=list(c(6,7,8,9,10,11,12)),
                    v.names = 
                      c("SubCortVolumes"), 
                    times=c('Thal', 'Cau','Put', 'Pall','Hippo', 'Amyg','Acc'),
                    idvar=c("hemi","scanner",'subj.ID'), direction='long')
data_l=data_l[,c("subj.ID","scanner","hemi", "time", "SubCortVolumes")]
data_l$ROI=as.factor(data_l$time)
data_l$Hemi=as.factor(data_l$hemi)

data_l_m_d <- data_l %>% 
  #mutate(scanner = factor(scanner, c('VERIO','SKYRA'), ordered = T)) %>% 
  #group_by(subj.ID,scanner,time) %>% 
  mutate(diff = -(SubCortVolumes - lag(SubCortVolumes, 1))) %>%
  mutate(mean = (SubCortVolumes + lag(SubCortVolumes, 1))/2) %>%
  filter(scanner=="SKYRA")

p1 <- ggplot(data_l_m_d, aes(x = mean, y = diff, color=ROI,group=Hemi )) +
  geom_point() +
  geom_hline(yintercept = 0, colour = "black", size = 0.5) +
  labs(x=xlabel, y=ylabel)+
  facet_grid(~Hemi)

ggsave(paste0("/data/pt_nro186_lifeupdate/Results/GMV_project_evelyn_frauke/Analysis_R/Figures/PLOS/Revision/Bland_Altmann_plot_subcort_allinone.eps"), p1, dpi=300,width=18, units = "cm")
ggsave(paste0("/data/pt_nro186_lifeupdate/Results/GMV_project_evelyn_frauke/Analysis_R/Figures/PLOS/Revision/Bland_Altmann_plot_subcort_allinone.png"), p1, dpi=300,width=18, units = "cm")

return(p1)
}

