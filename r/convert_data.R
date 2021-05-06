ct_o=read.csv("/data/pt_nro186_lifeupdate/Results/GMV_project_evelyn_frauke/life_upgrade/r/data/aparc_ct.csv")
aparc_ct$rh.aparc.thickness=ct_o$ID
colnames(aparc_ct)[1]="ID"
write.csv(aparc_ct,row.names = F, "/data/pt_nro186_lifeupdate/Results/GMV_project_evelyn_frauke/life_upgrade/r/data/aparc_ct_update.csv" )

ca_o=read.csv("/data/pt_nro186_lifeupdate/Results/GMV_project_evelyn_frauke/life_upgrade/r/data/aparc_area.csv")
aparc_area$rh.aparc.area=ca_o$ID
colnames(aparc_area)[1]="ID"
write.csv(aparc_area,row.names = F,"/data/pt_nro186_lifeupdate/Results/GMV_project_evelyn_frauke/life_upgrade/r/data/aparc_area_update.csv" )


ca_v=read.csv("/data/pt_nro186_lifeupdate/Results/GMV_project_evelyn_frauke/life_upgrade/r/data/aparc_volume.csv")
aparc_volume$rh.aparc.volume=ca_v$ID
colnames(aparc_volume)[1]="ID"
write.csv(aparc_volume,row.names = F,"/data/pt_nro186_lifeupdate/Results/GMV_project_evelyn_frauke/life_upgrade/r/data/aparc_volume_update.csv" )

aseg_o=read.csv("/data/pt_nro186_lifeupdate/Results/GMV_project_evelyn_frauke/life_upgrade/r/data/aseg_volume.csv")
vol$Measure.volume=aseg_o$Measure.volume
write.csv(vol,row.names = F,"/data/pt_nro186_lifeupdate/Results/GMV_project_evelyn_frauke/life_upgrade/r/data/aseg_update.csv" )
