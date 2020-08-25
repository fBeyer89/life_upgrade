create_cnr_th_table <- function (data){
  
  cnr_th_res<- data.frame(ROI=character(),
                       hemi=character(),
                       est_cnr=double(),
                       est_scanner=double(),
                       p_scanner=double(),
                       p_scanner_adjust=double(),
                       p_cnr=double(),
                       p_cnr_adjust=double(),
                       stringsAsFactors = FALSE)
  
  i=1
  for (roi in colnames(data)[7:40])
  {#print(roi)
    for (side in c("lh","rh"))
    {
      tmp=data[data$hemi==side,]
      myformula <- as.formula(paste0(roi, " ~ cnr + scanner + (1|subj)"))
      res=lmerTest::lmer(myformula,data=tmp)
      
      cnr_th_res[i,"ROI"]=roi
      cnr_th_res[i,"hemi"]=side
      cnr_th_res[i,"est_cnr"]=summary(res)$coefficients["cnr","Estimate"]
      cnr_th_res[i,"est_scanner"]=summary(res)$coefficients["scannerVERIO","Estimate"]
      cnr_th_res[i,"p_cnr"]=summary(res)$coefficients["cnr","Pr(>|t|)"]
      cnr_th_res[i,"p_scanner"]=summary(res)$coefficients["scannerVERIO","Pr(>|t|)"]
      
      i=i+1
    }
  }
  cnr_th_res$p_cnr_adjust=round(p.adjust(cnr_th_res$p_cnr, method = "fdr"),2)
  cnr_th_res$p_scanner_adjust=round(p.adjust(cnr_th_res$p_scanner, method = "fdr"),2)
  return(cnr_th_res)
}