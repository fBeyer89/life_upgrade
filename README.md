# life_upgrade
This repository contains data and code for the project "Estimating the effect of a scanner upgrade on measures of gray matter structure for longitudinal designs" by Medawar et al.
After revisions of the paper, the Rmd files of the manuscript and supplementary were updated to reflect all changes.
`[Last update: 2020-05-06]`

Please contact medawar@cbs.mpg.de or fbeyer@cbs.mpg.de, if you have questions!

1. `freesurfer`
includes scripts to
- run offline gradient distortion correction (`gradunwarp`)
- run cross- and long FreeSurfer pipelines on main (`recon_scripts`) and unwarped data (`gradunwarp`).
- run `mriqc` on T1-weighted images (`run_mriqc.sh`)
- extract aparc and aseg statistics (`aparcstats2table.sh`)

2. `matlab`
includes scripts to
- perform vertex-wise ICC analysis
- plot vertes-wise results (used in Supplementary Material)

3. `r`
includes manuscript draft, data and code to
- `Manuscript_Effect_of_scanner_upgrade_afterRevision2021` (formerly `Manuscript_Effect_of_scanner_upgrade_August2020.Rmd`) creates the main manuscript as pdf with rmarkdown in R version 3.6.1
- Supplementary material pdf is created with `SuppMat_PLOS.Rmd`
