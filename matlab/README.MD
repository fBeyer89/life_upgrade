# README 

**How** to calculate vertex-wise statistics for cortical measures from LIFE Upgrade Study

1. start Freesurfer version 6.0.0p1 environment
2. start MATLAB, matlab gui. (version 9.7, 2019b)
3. Use script `calculate_ICC_per_vertex.m`
   - This scripts loads necessary functions from the `matlab/lme` subfolder in the Freesurfer directory.
4. ICC smaller than 0 indicates low between-subject variance and is set to 0 for plotting.
5. Use nilearn in Python 2.7 to plot vertex-wise ICC + PD results on the surface with `plotting_on_surface.py`

*Sidenote*:   
Liem et al. stated that 10mm smoothing improves power (and reliability for cortical thickness). Therefore, we perform smoothing before calculating the ICC.

