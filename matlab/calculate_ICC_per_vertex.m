%Calculate ICC per vertex
addpath("/afs/cbs.mpg.de/software/freesurfer/6.0.0p1/ubuntu-bionic-amd64/matlab/lme")

%use 10mm smoothed values to create ICC maps, as Liem et al. showed increased power for this case!

for measure = ["thickness" "area" "volume"]
    for hemi = ["lh" "rh"]
        [x,mri]=fs_read_Y(sprintf('/data/pt_nro186_lifeupdate/Results/GMV_project_evelyn_frauke/FS_Group_Analysis/ICC_analysis/analysis_outputs/%s.%s_sm10.mgh', hemi,measure));
        res_icc=[];
        res_pd_mean=[];
        res_pd_sd=[];
        res_pairedt=[];
        for i=1:length(x)
            tmp=x(:,i);
            verio=tmp(1:2:length(tmp));
            skyra=tmp(2:2:length(tmp));
            comb=[verio,skyra];
            [r, LB, UB, F, df1, df2, p]=ICC(comb, 'A-1');
            [h,p,ci,stats] = ttest(verio, skyra);
            pd_mean=mean(2*(verio-skyra)./(verio+skyra)*100);
            pd_sd=std(2*(verio-skyra)./(verio+skyra)*100);
            if r<0
                %set all r<0 to zero -> they are probably due to low
                %between-subject variance 
                %(https://stats.stackexchange.com/questions/214124/what-to-do-with-negative-icc-values-adjust-the-test-or-interpret-it-differently
                comb;
                r;
                r=0;
            end
            res_icc(i)=r;
            res_pd_mean(i)=pd_mean;
            res_pd_sd(i)=pd_sd;
            res_pairedt(i)=stats.tstat;
        end

        mri.volsz=[163842,1,1,1];
        fs_write_Y(res_icc,mri,sprintf('/data/pt_nro186_lifeupdate/Results/GMV_project_evelyn_frauke/FS_Group_Analysis/ICC_analysis/ICC_pairedt_results/%s.%s_sm10_ICC.mgz', hemi,measure))
        fs_write_Y(res_pd_mean,mri,sprintf('/data/pt_nro186_lifeupdate/Results/GMV_project_evelyn_frauke/FS_Group_Analysis/ICC_analysis/ICC_pairedt_results/%s.%s_sm10_pd.mgz', hemi,measure))        
        fs_write_Y(res_pairedt,mri,sprintf('/data/pt_nro186_lifeupdate/Results/GMV_project_evelyn_frauke/FS_Group_Analysis/ICC_analysis/ICC_pairedt_results/%s.%s_sm10_ttest.mgz', hemi,measure))
        fs_write_Y(res_pd_sd,mri,sprintf('/data/pt_nro186_lifeupdate/Results/GMV_project_evelyn_frauke/FS_Group_Analysis/ICC_analysis/ICC_pairedt_results/%s.%s_sm10_pd_sd.mgz', hemi,measure))
       
    
    
    end
end

