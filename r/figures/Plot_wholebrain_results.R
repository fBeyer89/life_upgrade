#use the newer version on protactinium
library(fsbrain)
#to install old version without magick.
#packageurl <- "https://cran.r-project.org/src/contrib/Archive/fsbrain/fsbrain_0.3.0.tar.gz"
#install.packages(packageurl, repos=NULL, type="source")

library('rgl');
#r3dDefaults$windowRect=c(50, 50, 500, 500);
rgloptions=list('windowRect'=c(30, 30, 1200, 1200))

makecmap_th = colorRampPalette(RColorBrewer::brewer.pal(9, name="YlOrRd"))
makecmap_pd = colorRampPalette(RColorBrewer::brewer.pal(9, name="RdBu"))


subjects_dir = "/data/pt_nro186_lifeupdate/Data/FREESURFER/FREESURFER_SKYRA_ND"
subject_id = 'fsaverage'
data_dir="/data/pt_nro186_lifeupdate/Results/GMV_project_evelyn_frauke/FS_Group_Analysis/ICC_analysis/ICC_pairedt_results/unwarped/"
output="/data/pt_nro186_lifeupdate/Results/GMV_project_evelyn_frauke/Analysis_R/Figures/PLOS/Revision/vertexwise/unwarped"
type="inflated"

for (o in c("ICC", "pd")){
  for (a in c("thickness", "area", "volume")){
    lh=paste0(data_dir,"lh.",a,"_sm10_",o,".mgz")
    print(lh)
    rh=paste0(data_dir,"rh.",a,"_sm10_",o,".mgz")
    print(rh)
    
    
    lh_data = freesurferformats::read.fs.morph(lh);  
    rh_data = freesurferformats::read.fs.morph(rh);
    if (o=="pd"){
      cm=vis.data.on.subject(subjects_dir, subject_id, lh_data, surface=type, rh_data, rgloptions=rgloptions, 
                           draw_colorbar="horizontal",makecmap_options=list('colFn'=makecmap_pd,'symm'=TRUE),
                           rglactions = list("snapshot_png"=paste0(output,o,"_", type,"_",a,".png")))
    } else {
      cm=vis.data.on.subject(subjects_dir, subject_id, lh_data, surface=type, rh_data, rgloptions=rgloptions, 
                             draw_colorbar="horizontal",makecmap_options=list('colFn'=makecmap_th),
                             rglactions = list("snapshot_png"=paste0(output,o,"_", type,"_",a,".png")))
      
    }

    
  }
}








#img = vis.export.from.coloredmeshes(cm, colorbar_legend='Sulcal depth [mm]', output_img = "~/sulcal_depth.png")
