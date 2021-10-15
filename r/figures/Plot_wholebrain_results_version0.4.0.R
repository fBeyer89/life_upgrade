#use the newer version on protactinium
library(fsbrain)
#to install old version without magick.
#packageurl <- "https://cran.r-project.org/src/contrib/Archive/fsbrain/fsbrain_0.3.0.tar.gz"
#install.packages(packageurl, repos=NULL, type="source")

library('rgl');
#r3dDefaults$windowRect=c(50, 50, 500, 500);
rgloptions=list('windowRect'=c(30, 30, 800, 800))

library(psy)
library(boot)
source("/data/pt_nro186_lifeupdate/Results/GMV_project_evelyn_frauke/Analysis_R/PLOS_submission_0920/Review/icc_table.R")
source("/data/pt_nro186_lifeupdate/Results/GMV_project_evelyn_frauke/Analysis_R/PLOS_submission_0920/Review/create_long_table.R")
source("/data/pt_nro186_lifeupdate/Results/GMV_project_evelyn_frauke/Analysis_R/PLOS_submission_0920/cnr_rh_table.R")
source("/data/pt_nro186_lifeupdate/Results/GMV_project_evelyn_frauke/Analysis_R/PLOS_submission_0920/Review/Bland_Altman.R")


makecmap_th = colorRampPalette(RColorBrewer::brewer.pal(9, name="YlOrRd"))
makecmap_pd = colorRampPalette(RColorBrewer::brewer.pal(9, name="RdBu"))


subjects_dir = "/data/pt_nro186_lifeupdate/Data/FREESURFER/FREESURFER_SKYRA_ND"
subject_id = 'fsaverage'
data_dir="/data/pt_nro186_lifeupdate/Results/GMV_project_evelyn_frauke/FS_Group_Analysis/ICC_analysis/ICC_pairedt_results/unwarped/"
#"/data/pt_nro186_lifeupdate/Results/GMV_project_evelyn_frauke/FS_Group_Analysis/ICC_analysis/ICC_pairedt_results/nd_nd/"
output="/data/pt_nro186_lifeupdate/Results/GMV_project_evelyn_frauke/Analysis_R/Figures/PLOS/Revision/vertexwise/unwarped/"
type="pial" #"inflated" 
atlas = 'aparc';

for (o in c("ICC", "pd")){
  for (a in c("thickness", "area", "volume")){
    lh=paste0(data_dir,"lh.",a,"_sm10_",o,".mgz")
    print(lh)
    rh=paste0(data_dir,"rh.",a,"_sm10_",o,".mgz")
    print(rh)
    
    outputimg=paste0(output,a,"_sm10_",o,".png")
    
    if (o=="pd"){
      o1="PD"
      unit="[in %]"
      name=" (gradunwarp Verio ND - Skyra ND) " #" (Verio ND - Skyra ND) " " (Verio ND -Skyra D) "
    } else {
      o1="ICC"
      unit="[in a.u.]"
      name=" in gradunwarp Skyra ND vs. Verio ND "} #" in Skyra ND vs. Verio ND " " in Skyra D vs. Verio ND "
    
    if (a=="thickness"){
      a1="CT"
    } else if (a=="area") {
      a1="CA"} else {
        a1="CV"
      }
    cb_legend=paste0(o1, " for ", a1, name, unit)
    #cb_legend=paste0(o1, " for ", a1, name , unit)
    #cb_legend=paste0(o1, " for ", a1, name, unit)
    
    lh_data = freesurferformats::read.fs.morph(lh);  
    rh_data = freesurferformats::read.fs.morph(rh);
    if (o=="pd"){
      cm=vis.data.on.subject(subjects_dir, "fsaverage", lh_data, surface=type, rh_data, rgloptions=rgloptions, 
                           draw_colorbar="horizontal",makecmap_options=list('colFn'=makecmap_pd,'symm'=TRUE),views=NULL,
                           rglactions=list('no_vis'=T))
      img = vis.export.from.coloredmeshes(cm, colorbar_legend=cb_legend, output_img = outputimg );
      } else {
      cm=vis.data.on.subject(subjects_dir, "fsaverage", lh_data, surface=type, rh_data, rgloptions=rgloptions,
                             draw_colorbar="horizontal",makecmap_options=list('colFn'=makecmap_th),views=NULL,
                             rglactions=list('no_vis'=T))
      img = vis.export.from.coloredmeshes(cm, colorbar_legend=cb_legend, output_img = outputimg )}}}


#close all rgl windows
while (rgl.cur() > 0) { rgl.close() }


####### Region-level
outputdir="/data/pt_nro186_lifeupdate/Results/GMV_project_evelyn_frauke/Analysis_R/Figures/PLOS/Revision/regionwise/"

####### CT #######
aparc_ct_rh=read.csv("/data/pt_nro186_lifeupdate/Results/GMV_project_evelyn_frauke/FS_Group_Analysis/FS_stats_allsubjects/longitudinal_statistics/cort/DK_thickness_VERIO_ND_SKYRA_ND_rh_nd.txt", sep = '\t')
aparc_ct_lh=read.csv("/data/pt_nro186_lifeupdate/Results/GMV_project_evelyn_frauke/FS_Group_Analysis/FS_stats_allsubjects/longitudinal_statistics/cort/DK_thickness_VERIO_ND_SKYRA_ND_lh_nd.txt", sep = '\t')
aparc_ct=merge(aparc_ct_rh,aparc_ct_lh, by.x="rh.aparc.thickness", by.y="lh.aparc.thickness")
colnames(aparc_ct)[1]="ID"
aparc_ct_l=create_long_table_aparc(aparc_ct,"thickness")
#---- calculate ICC and PD for FreeSurfer cortical thickness----
icc_res_th<-create_icc_table_aparc(aparc_ct_l)
colnames(icc_res_th)=c("ROI","hemi","ICC", "lower ICC", "upper ICC", "PD", "T", "p", "adj.p")

lh_region_value_list=icc_res_th[icc_res_th$hemi=="lh","ICC"]
names(lh_region_value_list) = icc_res_th[icc_res_th$hemi=="lh","ROI"] 
rh_region_value_list=icc_res_th[icc_res_th$hemi=="rh","ICC"]
names(rh_region_value_list) = icc_res_th[icc_res_th$hemi=="rh","ROI"] 

cb_legend=paste0("ICC for CT in Skyra ND vs. Verio ND [in a.u.]")
cm=vis.region.values.on.subject(subjects_dir, subject_id, atlas, lh_region_value_list, 
                             rh_region_value_list, views=NULL, draw_colorbar="horizontal",
                             rgloptions=rgloptions,rglactions=list('no_vis'=T))
img = vis.export.from.coloredmeshes(cm, colorbar_legend=cb_legend, output_img = paste0(outputdir,"thickness_icc.png"))

lh_region_value_list=icc_res_th[icc_res_th$hemi=="lh","PD"]
names(lh_region_value_list) = icc_res_th[icc_res_th$hemi=="lh","ROI"] 
rh_region_value_list=icc_res_th[icc_res_th$hemi=="rh","PD"]
names(rh_region_value_list) = icc_res_th[icc_res_th$hemi=="rh","ROI"] 

cb_legend=paste0("PD for CT (Verio ND - Skyra ND) [in %]")
cm=vis.region.values.on.subject(subjects_dir, subject_id, atlas, lh_region_value_list, 
                                rh_region_value_list, views=NULL,
                                draw_colorbar="horizontal", makecmap_options=list('colFn'=makecmap_pd,'symm'=TRUE),
                                rgloptions=rgloptions,rglactions=list('no_vis'=T))
img = vis.export.from.coloredmeshes(cm, colorbar_legend=cb_legend, output_img = paste0(outputdir,"thickness_pd.png" ))

####### CA #######
aparc_area_rh=read.csv("/data/pt_nro186_lifeupdate/Results/GMV_project_evelyn_frauke/FS_Group_Analysis/FS_stats_allsubjects/longitudinal_statistics/cort/DK_area_VERIO_ND_SKYRA_ND_rh_nd.txt", sep = '\t')
aparc_area_lh=read.csv("/data/pt_nro186_lifeupdate/Results/GMV_project_evelyn_frauke/FS_Group_Analysis/FS_stats_allsubjects/longitudinal_statistics/cort/DK_area_VERIO_ND_SKYRA_ND_lh_nd.txt", sep = '\t')
aparc_area=merge(aparc_area_rh,aparc_area_lh, by.x="rh.aparc.area", by.y="lh.aparc.area")
colnames(aparc_area)[1]="ID"
aparc_area_l=create_long_table_aparc(aparc_area, "area")
#---- calculate ICC and PD for FreeSurfer cortical area----
icc_res_area<-create_icc_table_aparc(aparc_area_l)
colnames(icc_res_area)=c("ROI","hemi","ICC", "lower ICC", "upper ICC", "PD", "T", "p", "adj.p")


lh_region_value_list=icc_res_area[icc_res_area$hemi=="lh","ICC"]
names(lh_region_value_list) = icc_res_area[icc_res_area$hemi=="lh","ROI"] 
rh_region_value_list=icc_res_area[icc_res_area$hemi=="rh","ICC"]
names(rh_region_value_list) = icc_res_area[icc_res_area$hemi=="rh","ROI"] 

cb_legend=paste0("ICC for CA in Skyra ND vs. Verio ND [in a.u.]")
cm=vis.region.values.on.subject(subjects_dir, subject_id, atlas, lh_region_value_list, 
                                rh_region_value_list, views=NULL, draw_colorbar="horizontal",
                                rgloptions=rgloptions,rglactions=list('no_vis'=T))
img = vis.export.from.coloredmeshes(cm, colorbar_legend=cb_legend, output_img = paste0(outputdir,"area_icc.png"))

lh_region_value_list=icc_res_area[icc_res_area$hemi=="lh","PD"]
names(lh_region_value_list) = icc_res_area[icc_res_area$hemi=="lh","ROI"] 
rh_region_value_list=icc_res_area[icc_res_area$hemi=="rh","PD"]
names(rh_region_value_list) = icc_res_area[icc_res_area$hemi=="rh","ROI"] 
vis.region.values.on.subject(template_subjects_dir, template_subject, atlas, lh_region_value_list, rh_region_value_list, views=c('t4'), draw_colorbar="horizontal",rgloptions=rgloptions, rglactions = list("snapshot_png"="/data/pt_nro186_lifeupdate/Results/GMV_project_evelyn_frauke/Analysis_R/Figures/PLOS/Revision/Figures_labels/pd_area_large.png"),makecmap_options=list('colFn'=makecmap_pd,'symm'=TRUE));

cb_legend=paste0("PD for CA (Verio ND - Skyra ND) [in %]")
cm=vis.region.values.on.subject(subjects_dir, subject_id, atlas, lh_region_value_list, 
                                rh_region_value_list, views=NULL,
                                draw_colorbar="horizontal",makecmap_options=list('colFn'=makecmap_pd,'symm'=TRUE),
                                rgloptions=rgloptions,rglactions=list('no_vis'=T))
img = vis.export.from.coloredmeshes(cm, colorbar_legend=cb_legend, output_img = paste0(outputdir,"area_pd.png"))

###### CV ########
aparc_volume_rh=read.csv("/data/pt_nro186_lifeupdate/Results/GMV_project_evelyn_frauke/FS_Group_Analysis/FS_stats_allsubjects/longitudinal_statistics/cort/DK_volume_VERIO_ND_SKYRA_ND_rh_nd.txt", sep = '\t')
aparc_volume_lh=read.csv("/data/pt_nro186_lifeupdate/Results/GMV_project_evelyn_frauke/FS_Group_Analysis/FS_stats_allsubjects/longitudinal_statistics/cort/DK_volume_VERIO_ND_SKYRA_ND_lh_nd.txt", sep = '\t')
aparc_volume=merge(aparc_volume_rh,aparc_volume_lh, by.x="rh.aparc.volume", by.y="lh.aparc.volume")
colnames(aparc_volume)[1]="ID"
aparc_volume_l=create_long_table_aparc(aparc_volume,"volume")
#---- calculate ICC and PD for FreeSurfer cortical volume----
icc_res_vol<-create_icc_table_aparc(aparc_volume_l)
colnames(icc_res_vol)=c("ROI","hemi","ICC", "lower ICC", "upper ICC", "PD", "T", "p", "adj.p")


lh_region_value_list=icc_res_vol[icc_res_vol$hemi=="lh","ICC"]
names(lh_region_value_list) = icc_res_vol[icc_res_vol$hemi=="lh","ROI"] 
rh_region_value_list=icc_res_vol[icc_res_vol$hemi=="rh","ICC"]
names(rh_region_value_list) = icc_res_vol[icc_res_vol$hemi=="rh","ROI"] 

cb_legend=paste0("ICC for CV in Skyra ND vs. Verio ND [in a.u.]")
cm=vis.region.values.on.subject(subjects_dir, subject_id, atlas, lh_region_value_list, 
                                rh_region_value_list, views=NULL, draw_colorbar="horizontal",
                                rgloptions=rgloptions,rglactions=list('no_vis'=T))
img = vis.export.from.coloredmeshes(cm, colorbar_legend=cb_legend, output_img = paste0(outputdir,"volume_icc.png"))

lh_region_value_list=icc_res_vol[icc_res_vol$hemi=="lh","PD"]
names(lh_region_value_list) = icc_res_vol[icc_res_vol$hemi=="lh","ROI"] 
rh_region_value_list=icc_res_vol[icc_res_vol$hemi=="rh","PD"]
names(rh_region_value_list) = icc_res_vol[icc_res_vol$hemi=="rh","ROI"] 

cb_legend=paste0("PD for CV (Verio ND - Skyra ND) [in %]")
cm=vis.region.values.on.subject(subjects_dir, subject_id, atlas, lh_region_value_list, 
                                rh_region_value_list, views=NULL, 
                                draw_colorbar="horizontal",makecmap_options=list('colFn'=makecmap_pd,'symm'=TRUE),
                                rgloptions=rgloptions,rglactions=list('no_vis'=T))
img = vis.export.from.coloredmeshes(cm, colorbar_legend=cb_legend, output_img = paste0(outputdir,"volume_pd.png"))


### Correlation of CNR and PD
## Preparation of data
qa=read.table('/data/p_nro186_lifeupdate/BIDS/derivatives/mriqc/group_T1w.tsv', header=T)
for (i in 1:nrow(qa)){
  #print(i)
  #print(qa[i,1])
  tmp=strsplit(toString(qa[i,1]),'_')[[1]]
  #print(tmp)
  qa[i,"subj"]=tmp[1]
  qa[i,"scanner"]=tmp[2]
  qa[i,"acq"]=tmp[3]
}

qa$Scanner=as.factor(qa$scanner)
levels(qa$Scanner)=c("Skyra","Verio")
qa$Acquisition=as.factor(qa$acq)
levels(qa$Acquisition)=c("D","ND")
for (i in 1:nrow(aparc_ct_l[1:418,])){
  aparc_ct_l[i,"subj"]=paste("sub-",strsplit(toString(aparc_ct_l[i,"subj.ID"]),'[.]')[[1]][1],strsplit(toString(aparc_ct_l[i,"subj.ID"]),'[.]')[[1]][2],sep="")
}
aparc_ct_l[419:464,"subj"]=paste("sub-",aparc_ct_l[419:464,"subj.ID"],sep="")
aparc_ct_l$scanner_m=aparc_ct_l$scanner

qa[qa$scanner=="ses-VER1","scanner_m"]="VERIO"
qa[qa$scanner=="ses-SKYRA"&qa$acq=="acq-ND","scanner_m"]="SKYRA" #changed to use Skyra_ND

merged_qa=merge(qa[!is.na(qa$scanner_m),c("subj","scanner_m","cnr")],aparc_ct_l, by=c("subj","scanner_m"))
merged_qa$scanner_m=as.factor(merged_qa$scanner_m)
levels(merged_qa$scanner_m)=c("VERIO","SKYRA") #use different reference region.
cnr_th_table=create_cnr_th_table(merged_qa)
####################################################################################
###Plotting
lh_region_value_list = cnr_th_table[cnr_th_table$hemi=="lh","est_cnr"];       
names(lh_region_value_list) = cnr_th_table[cnr_th_table$hemi=="lh","ROI"] 
rh_region_value_list = cnr_th_table[cnr_th_table$hemi=="rh","est_cnr"];       
names(rh_region_value_list) = cnr_th_table[cnr_th_table$hemi=="rh","ROI"]                    

# Now we have region_value_lists for both hemispheres. Time to visualize them:
cb_legend=paste0("Coefficient of CNR effect on CT [in mm]")
cm=vis.region.values.on.subject(subjects_dir, subject_id, atlas, lh_region_value_list, 
                                rh_region_value_list, views=NULL, draw_colorbar="horizontal",
                                rgloptions=rgloptions,rglactions=list('no_vis'=T), makecmap_options=list('colFn'=makecmap_pd,'symm'=TRUE))
img = vis.export.from.coloredmeshes(cm, colorbar_legend=cb_legend, output_img = paste0(outputdir,"cnr_thickness.png"))



lh_region_value_list = cnr_th_table[cnr_th_table$hemi=="lh","est_scanner_m"];       
names(lh_region_value_list) = cnr_th_table[cnr_th_table$hemi=="lh","ROI"] 
rh_region_value_list = cnr_th_table[cnr_th_table$hemi=="rh","est_scanner_m"];       
names(rh_region_value_list) = cnr_th_table[cnr_th_table$hemi=="rh","ROI"]   

cb_legend=paste0("Coefficient of scanner effect (Verio-Skyra) on CT [in mm]")
cm=vis.region.values.on.subject(subjects_dir, subject_id, atlas, lh_region_value_list, 
                                rh_region_value_list, views=NULL, draw_colorbar="horizontal",
                                rgloptions=rgloptions,rglactions=list('no_vis'=T), makecmap_options=list('colFn'=makecmap_pd,'symm'=TRUE))
img = vis.export.from.coloredmeshes(cm, colorbar_legend=cb_legend, output_img = paste0(outputdir,"scanner_thickness.png"))


############ unwarped region-wise  ############
aparc_ct_rh=read.csv("/data/pt_nro186_lifeupdate/Results/GMV_project_evelyn_frauke/FS_Group_Analysis/FS_stats_allsubjects/longitudinal_statistics/cort/DK_thickness_VERIO_ND_SKYRA_ND_rh_unwarped.txt", sep = '\t')
aparc_ct_lh=read.csv("/data/pt_nro186_lifeupdate/Results/GMV_project_evelyn_frauke/FS_Group_Analysis/FS_stats_allsubjects/longitudinal_statistics/cort/DK_thickness_VERIO_ND_SKYRA_ND_lh_unwarped.txt", sep = '\t')
aparc_ct=merge(aparc_ct_rh,aparc_ct_lh, by.x="rh.aparc.thickness", by.y="lh.aparc.thickness", all.x)
colnames(aparc_ct)[1]="ID"
#there is none complete data for some subjects, which are probably running right now.
aparc_ct_l=create_long_table_aparc(aparc_ct, "thickness")

#---- calculate ICC and PD for FreeSurfer cortical thickness----
icc_res_th_unw<-create_icc_table_aparc(aparc_ct_l)
colnames(icc_res_th_unw)=c("ROI","hemi","ICC", "lower ICC", "upper ICC", "PD", "T", "p", "adj.p")

#### plotting
lh_region_value_list=icc_res_th_unw[icc_res_th_unw$hemi=="lh","ICC"]
names(lh_region_value_list) = icc_res_th_unw[icc_res_th_unw$hemi=="lh","ROI"] 
rh_region_value_list=icc_res_th_unw[icc_res_th_unw$hemi=="rh","ICC"]
names(rh_region_value_list) = icc_res_th_unw[icc_res_th_unw$hemi=="rh","ROI"] 

cb_legend=paste0("ICC for CT in gradunwarp Skyra ND vs. Verio ND [in a.u.]")
cm=vis.region.values.on.subject(subjects_dir, subject_id, atlas, lh_region_value_list, 
                                rh_region_value_list, views=NULL, draw_colorbar="horizontal",
                                rgloptions=rgloptions,rglactions=list('no_vis'=T))
img = vis.export.from.coloredmeshes(cm, colorbar_legend=cb_legend, output_img = paste0(outputdir,"thickness_icc_unwarped.png"))

lh_region_value_list=icc_res_th_unw[icc_res_th_unw$hemi=="lh","PD"]
names(lh_region_value_list) = icc_res_th_unw[icc_res_th_unw$hemi=="lh","ROI"] 
rh_region_value_list=icc_res_th_unw[icc_res_th_unw$hemi=="rh","PD"]
names(rh_region_value_list) = icc_res_th_unw[icc_res_th_unw$hemi=="rh","ROI"] 

cb_legend=paste0("PD for CT (gradunwarp Verio ND - Skyra ND) [in %]")
cm=vis.region.values.on.subject(subjects_dir, subject_id, atlas, lh_region_value_list, 
                                rh_region_value_list, views=NULL, 
                                draw_colorbar="horizontal",makecmap_options=list('colFn'=makecmap_pd,'symm'=TRUE),
                                rgloptions=rgloptions,rglactions=list('no_vis'=T))
img = vis.export.from.coloredmeshes(cm, colorbar_legend=cb_legend, output_img = paste0(outputdir,"thickness_pd_unwarped.png"))



