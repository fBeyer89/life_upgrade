#!/bin/bash
# @authors: medawar@cbs.mpg.de; thieleking@cbs.mpg.de

## Prerequisits: FSL environment; compute server
#
# Previous steps:
# 1. convert DICOM to nifti format for freesurfer
#  2. run freesurfer (peeling)

# Steps:
# 3. compute longitudinal FREESURFER data, with structural MPRAGE images from 2 timepoints

#use to get latest version of freesurfer output data
#/bin/bash /data/pt_nro186_lifeupdate/scripts/check_freesurfer.sh

#export #Needed when you execute a program. The child program inherits its environment variables from the parent. 
subj_list="/data/pt_nro186_lifeupdate/scripts/check/FREESURFER_long_not_existing_subjects.txt"

#for subj in `cat ${subj_list}` #uncomment for running all subjects from scratch
for subj in subj.id
#
 #`sed -n 22,30p $subj_list`
do

SUBJECTS_DIR="/data/pt_nro186_lifeupdate/Data/FREESURFER/FREESURFER_long/"

rm -rf ${SUBJECTS_DIR}/template_$subj
rm -rf ${SUBJECTS_DIR}/$subj_VERIO.long.template_$subj
rm -rf ${SUBJECTS_DIR}/$subj_SKYRA.long.template_$subj

#create the BASE for each subject for all timepoints
#recon-all -base <templateid> -tp <tp1id> -tp <tp2id> ... -all
#recon-all -base template_$subj -tp ${subj}_VERIO -all -openmp 64 #-openmp number of cores; rihanna:32, roxette/rosenstolz/saga:64
recon-all -base template_$subj -tp ${subj}_VERIO -tp ${subj}_SKYRA -all -openmp 64 #-openmp number of cores; rihanna:32, roxette/rosenstolz/saga:64

#run the longitudinal analysis for each timepoint
#recon-all -long <tpNid> <templateid> -all
recon-all -long ${subj}_VERIO template_$subj -all -openmp 64 

recon-all -long ${subj}_SKYRA template_$subj -all -openmp 64


echo "$subj FREESURFER LONGITUDINAL DONE"
done 


##### still contains error for finding VERIO and SKYRA mri files #############
