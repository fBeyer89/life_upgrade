#!/bin/bash
# @authors: medawar@cbs.mpg.de; thieleking@cbs.mpg.de

## Prerequisits: FSL environment; compute server
#
# Steps:
# 1. convert DICOM to nifti format for freesurfer
#  2. run freesurfer (peeling)


#export #Needed when you execute a program. The child program inherits its environment variables from the parent. 
#subj_list="/data/pt_nro186_lifeupdate/Participants_ID_only_existingDICOM_re-run3.txt"
orig_dir="/data/pt_nro186_lifeupdate/Data/NIFTIS"
results_dir="/data/pt_nro186_lifeupdate/Data/FREESURFER"
#for subj in `cat ${subj_list}` #uncomment for running all subjects from the scratch
# 
# ###VERIO
# 
#  for subj in `sed -n 6,11p ${verio_missing_subj_list}`
# for subj in `cat ${subj_list}` #uncomment for running all subjects from the scratch

###VERIO

for subj in # `cat ${verio_missing_subj_list}`
# for subj in `sed -n 1p ${verio_missing_subj_list}` #put in the line numbers (e.g. 1-8) we need; look in the list and divide number of subjects through number of compute servers

do

SUBJECTS_DIR=$results_dir/VERIO/

echo $subj

recon-all -all -s $subj -openmp 64 -hippocampal-subfields-T1 
done 



###SKYRA


# for subj in `cat ${skyra_missing_subj_list}`
# 
# do
# 
# SUBJECTS_DIR=$results_dir/SKYRA/
# 
# echo $subj
# 
# cd $orig_dir/$subj/SKYRA/
# # inputnifti=$(find -name '*MPRAGEADNI*.nii.gz' ! -name 'co*' ! -name 'o*') # | grep -v 'co*' | grep -v 'o*')
# # echo "$inputnifti"
# # #cp $inputnifti MPRAGE.nii.gz
# # set -- $inputnifti
# # recon-all -all -s $subj -i $1 -openmp 64 -hippocampal-subfields-T1 -mail medawar@cbs.mpg.de  #-openmp number of cores; rihanna:32, roxette/rosenstolz/saga:64
# 
# 
# done

