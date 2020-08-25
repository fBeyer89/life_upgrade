#!/bin/bash

SUBJECTS_DIR="/data/pt_nro186_lifeupdate/Data/FREESURFER/FREESURFER_long_unwarped"

for subj in subj.id #`cat /data/pt_nro186_lifeupdate/Analysis/Freesurfer/FS_scripts_recon/gradunwarp/freesurfer/participants_N116_1_24.txt`

do 
echo ${subj}

if [ -f /data/pt_nro186_lifeupdate/Data/NIFTIS/${subj}/VERIO/20*MPRAGEADNI32ChPAT2*_unwarped_fov0.2_nump_200_intp4.nii ];

then 

if [ -f ${SUBJECTS_DIR}/${subj}_unwarped_VERIO/mri/aparc+aseg.mgz ];
then
#recon-all -all -parallel -no-isrunning -openmp 8 -subjid 
echo "VERIO cross done"
#resume processing

else

if [ -d ${SUBJECTS_DIR}/${subj}_unwarped_VERIO/ ];then
recon-all -make all -s ${subj}_unwarped_VERIO 
else
recon-all -all -parallel -i /data/pt_nro186_lifeupdate/Data/NIFTIS/${subj}/VERIO/20*MPRAGEADNI32ChPAT2*_unwarped_fov0.2_nump_200_intp4.nii -no-isrunning -openmp 8 -subjid ${subj}_unwarped_VERIO 
fi
fi

else
echo "unwarping did not finish"
fi

if [ -f /data/pt_nro186_lifeupdate/Data/NIFTIS/${subj}/SKYRA/20*MPRAGEADNI32ChPAT2*_unwarped_fov0.2_nump_200_intp4.nii ];
then 

if [ -f ${SUBJECTS_DIR}/${subj}_unwarped_SKYRA/mri/aparc+aseg.mgz ];
then
#recon-all -all -parallel -no-isrunning -openmp 8 -subjid 
echo "SKYRA cross done"
#resume processing

else

if [ -d ${SUBJECTS_DIR}/${subj}_unwarped_SKYRA ];
then
recon-all -all -parallel -no-isrunning -openmp 8 -subjid ${subj}_unwarped_SKYRA 
#resume processing
recon-all -make all -s ${subj}_unwarped_SKYRA
else
recon-all -all -parallel -i /data/pt_nro186_lifeupdate/Data/NIFTIS/${subj}/SKYRA/20*MPRAGEADNI32ChPAT2*_unwarped_fov0.2_nump_200_intp4.nii -no-isrunning -openmp 8 -subjid ${subj}_unwarped_SKYRA 
fi
fi

else
echo "unwarping did not finish"
fi

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




