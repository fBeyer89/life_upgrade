# Gradient distortion correction for LIFE Update

## 0_gradunwarp_scripts

Scripts based on [HCP](https://github.com/Washington-University/gradunwarp) implementation of spherical harmonics unwarping. Vendor files are in `SKYRA_MPI` and `VERIO_TK`.

`gradunwarp` contains main analysis python script & helper functions (in `gradunwarp/core`) and wrapper scripts to run on our data.

1. default parameters were used (--fovmin -0.3, --fovmax 0.3, interp_order=1, numpoints=60)

scripts are in `gradunwarp/first_round_wrong_settings`. This yielded large intensity deviations (and therefore a worsening of test-retest reliability).

2. optimized parameters (--fovmin -0.2, --fovmax 0.2, interp_order=4, numpoints=200)

main run script `run_distor_correct.sh`

optimization was done using `run_distor_correct_test.sh`, results can be found in `example_skyra_06133.b9` where I compared the result of unwarping for different parameters with the raw & online correction. 

## freesurfer

Scripts to run cross- and long freesurfer on the unwarped files.