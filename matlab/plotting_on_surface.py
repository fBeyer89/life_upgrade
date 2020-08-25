#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu May  7 10:46:16 2020
Plotting results nicely
@author: fbeyer
"""


from nilearn import plotting
from nilearn import datasets
from nilearn import surface
import numpy as np
import matplotlib.pyplot as plt

fsaverage = datasets.fetch_surf_fsaverage(mesh="fsaverage")


surf=surface.load_surf_data('/data/pt_nro186_lifeupdate/Results/GMV_project_evelyn_frauke/FS_Group_Analysis/ICC_analysis/ICC_pairedt_results/lh.thickness_sm10_ICC.mgz')
print(np.size(surf))
print(min(surf))
surf[np.isnan(surf)]=0
print(np.size(surf))
#plotting.plot_surf_roi(fsaverage['pial_left'], roi_map=surf,
#                       hemi='left', view='medial',
#                       bg_map=fsaverage['sulc_left'], bg_on_data=True,
#                       title='')

#plotting.plot_surf_stat_map(surf_mesh=fsaverage['pial_left'], stat_map=surf,
#                      hemi='left', view='medial', bg_map=fsaverage['sulc_left'], vmin=0.5, vmax=1)

#plotting.plot_surf_roi(fsaverage['pial_left'], roi_map=surf,
#                       hemi='left', view='medial',
#                       bg_map=fsaverage['sulc_left'], bg_on_data=True,
#                       title='')

#plotting.plot_surf(fsaverage['pial_left'], surf_map=surf,
#                       hemi='left', view='medial',
#                       bg_map=fsaverage['sulc_left'], 
#                       bg_on_data=True, 
#                       colorbar=True,
#                       title='', 
#                       vmin=0.5, vmax=1)
#plotting.show()


for measure in ["thickness","area","volume"]:
    for hemi in ["lh", "rh"]:
        for quantity in ["ICC", "pd", "ttest"]:
            file="/data/pt_nro186_lifeupdate/Results/GMV_project_evelyn_frauke/FS_Group_Analysis/ICC_analysis/ICC_pairedt_results/%s.%s_sm10_%s.mgz" %(hemi, measure, quantity)
            surf=surface.load_surf_data(file)
            #set Nan values to 0
            surf[np.isnan(surf)]=0
            print("plotting %s for %s on %s" %(quantity, measure, hemi))
            if hemi == "lh":
                 plotting.plot_surf(fsaverage['pial_left'], surf_map=surf,
                       hemi='left', view='medial',colorbar=True,
                       bg_map=fsaverage['sulc_left'], bg_on_data=True,
                       title='',
                       output_file="/data/pt_nro186_lifeupdate/Results/GMV_project_evelyn_frauke/FS_Group_Analysis/ICC_analysis/ICC_pairedt_results/%s.%s_sm10_%s_medial.png" %(hemi, measure, quantity))
                 plotting.plot_surf(fsaverage['pial_left'], surf_map=surf,
                       hemi='left', view='lateral',colorbar=True,
                       bg_map=fsaverage['sulc_left'], bg_on_data=True,
                       title='',
                       output_file="/data/pt_nro186_lifeupdate/Results/GMV_project_evelyn_frauke/FS_Group_Analysis/ICC_analysis/ICC_pairedt_results/%s.%s_sm10_%s_lateral.png" %(hemi, measure, quantity))
            else:
                plotting.plot_surf(fsaverage['pial_right'], surf_map=surf,
                       hemi='right', view='medial',colorbar=True,
                       bg_map=fsaverage['sulc_right'], bg_on_data=True,
                       title='',
                       output_file="/data/pt_nro186_lifeupdate/Results/GMV_project_evelyn_frauke/FS_Group_Analysis/ICC_analysis/ICC_pairedt_results/%s.%s_sm10_%s_medial.png" %(hemi, measure, quantity))
                plotting.plot_surf(fsaverage['pial_right'], surf_map=surf,
                       hemi='right', view='lateral',colorbar=True,
                       bg_map=fsaverage['sulc_right'], bg_on_data=True,
                       title='',
                       output_file="/data/pt_nro186_lifeupdate/Results/GMV_project_evelyn_frauke/FS_Group_Analysis/ICC_analysis/ICC_pairedt_results/%s.%s_sm10_%s_lateral.png" %(hemi, measure, quantity))