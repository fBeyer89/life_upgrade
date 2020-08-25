#!/bin/bash

SUBJECTS_DIR="/data/pt_nro186_lifeupdate/Data/FREESURFER/FREESURFER_long_unwarped"

for subj in subj.id #`cat /data/pt_nro186_lifeupdate/Analysis/Freesurfer/FS_scripts_recon/gradunwarp/freesurfer/participants_extra3.txt`

do 
echo ${subj}

if [ ! -f /data/pt_nro186_lifeupdate/Data/FREESURFER/FREESURFER_long_unwarped/template_${subj}_unwarped/mri/aparc+aseg.mgz ];
then
recon-all -base template_${subj}_unwarped -tp ${subj}_unwarped_SKYRA -tp ${subj}_unwarped_VERIO -all -openmp 64
else
echo "template done"
fi

if [ ! -f /data/pt_nro186_lifeupdate/Data/FREESURFER/FREESURFER_long_unwarped/${subj}_unwarped_SKYRA.long.template_${subj}_unwarped/mri/aparc+aseg.mgz ];then
recon-all -long ${subj}_unwarped_SKYRA template_${subj}_unwarped -all -openmp 64
else 
echo "Skyra long done"
fi

if [ ! -f /data/pt_nro186_lifeupdate/Data/FREESURFER/FREESURFER_long_unwarped/${subj}_unwarped_VERIO.long.template_${subj}_unwarped/mri/aparc+aseg.mgz ];then
recon-all -long ${subj}_unwarped_VERIO template_${subj}_unwarped -all -openmp 64
else
echo "verio done"
fi

done

