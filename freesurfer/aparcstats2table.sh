#!/bin/bash


for analysis in main unwarped
do
if [ ${analysis} == "main" ];
then
echo ${subj_file}

subj_file="/data/pt_nro186_lifeupdate/Analysis/Freesurfer/ROI_vals/long_subj_ids_for_fs.txt"
SUBJECTS_DIR="/data/pt_nro186_lifeupdate/Data/FREESURFER/FREESURFER_long/"
qdec="/data/pt_nro186_lifeupdate/Analysis/Freesurfer/ROI_vals/long.qdec.table.dat"
output="/data/pt_nro186_lifeupdate/Results/GMV_project_evelyn_frauke/FS_Group_Analysis/FS_stats_allsubjects/longitudinal_statistics/subcort/aseg_stats.txt"

else
echo ${subj_file}

subj_file="/data/pt_nro186_lifeupdate/Analysis/Freesurfer/ROI_vals/long_subj_ids_for_fs_unwarped.txt"
SUBJECTS_DIR="/data/pt_nro186_lifeupdate/Data/FREESURFER/FREESURFER_long_unwarped/"
qdec="/data/pt_nro186_lifeupdate/Analysis/Freesurfer/ROI_vals/long.qdec.table_unwarped.dat"
output="/data/pt_nro186_lifeupdate/Results/GMV_project_evelyn_frauke/FS_Group_Analysis/FS_stats_allsubjects/longitudinal_statistics/subcort/aseg_stats_unwarped.txt"

fi
#for hemi in lh rh
#do
#for measure in volume thickness area 
#do
#aparcstats2table --subjectsfile ${subj_file}  --hemi ${hemi} -m ${measure} --skip -t /data/pt_nro186_lifeupdate/Results/GMV_project_evelyn_frauke/FS_Group_Analysis/FS_stats_allsubjects/longitudinal_statistics/cort/DK_${measure}_VERIO_ND_SKYRA_D_${hemi}_${analysis}.txt
#echo ${subj_file} ${hemi} ${measure}
#done
#done

asegstats2table --qdec-long=$qdec --meas volume --tablefile $output

done




