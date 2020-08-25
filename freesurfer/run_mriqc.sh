#!/bin/bash

#singularity run /data/u_fbeyer_software/mriqc/mriqc_0.15.0.simg -B /data/pt_nro186_lifeupdate/Data/BIDS/ -B /data/pt_nro186_lifeupdate/Data/BIDS/derivatives/mriqc

singularity run -B /data/pt_nro186_lifeupdate/Data/BIDS/,/data/pt_nro186_lifeupdate/Data/BIDS/derivatives/mriqc,/data/pt_life/data_fbeyer/wd /data/u_fbeyer_software/mriqc/mriqc_0.15.0.simg /data/pt_nro186_lifeupdate/Data/BIDS/ /data/pt_nro186_lifeupdate/Data/BIDS/derivatives/mriqc participant -m T1w -w /data/pt_life/data_fbeyer/wd
