

create_icc_table_aparc <- function (data){

icc_res<- data.frame(ROI=character(),
                     hemi=character(),
                     icc=double(),
                     icc_lb=double(),
                     icc_ub=double(),
                     pd=double(),
                     ttest=double(),
                     #cohensD=double(),
                     p=double(),
                     p_adjust=double(),
                     stringsAsFactors = FALSE)

icc.boot <- function(data,x) {icc(data[x,])[[7]]}
i=1
for (roi in colnames(data)[4:37])
{
  for (side in c("lh","rh"))
  {
    tmp.verio=data[data$hemi==side&data$scanner=="VERIO",roi]
    tmp.skyra=data[data$hemi==side&data$scanner=="SKYRA",roi]
    tmp.data=data.frame(tmp.verio, tmp.skyra)

    tmp_icc=icc(tmp.data)
    
    icc_res[i,"ROI"]=roi
    icc_res[i,"hemi"]=side
    icc_res[i,"icc"]=round(tmp_icc$icc.agreement,3)
    
    
    res <- boot(tmp.data,icc.boot,5)
    t=quantile(res$t,c(0.025,0.975))
    icc_res[i,"icc_lb"]=round(t[1],3)
    icc_res[i,"icc_ub"]=round(t[2],3)
    
    icc_res[i,"pd"]=round((200/nrow(tmp.data))*sum((tmp.data[1]-tmp.data[2])/(tmp.data[1]+tmp.data[2])),2)
    #icc_res[i,"cohensD"]=round(cohensD(tmp.verio, tmp.skyra,method = "paired"),2)
    tmp_t=t.test(tmp.verio,tmp.skyra, paired=TRUE)
    icc_res[i, "ttest"]=round(tmp_t$statistic,2)  
    icc_res[i,"p"]=round(tmp_t$p.value,2)
    i=i+1
  }
}
icc_res$p_adjust=round(p.adjust(icc_res$p, method = "fdr"),2)
return(icc_res)
}

create_icc_table_vol <- function (data){
  
  icc_res<- data.frame(ROI=character(),
                       hemi=character(),
                       icc=double(),
                       icc_lb=double(),
                       icc_ub=double(),
                       pd=double(),
                       ttest=double(),
                       #cohensD=double(),
                       p=double(),
                       p_adjust=double(),
                       stringsAsFactors = FALSE)
  
  icc.boot <- function(data,x) {icc(data[x,])[[7]]}
  i=1
  # x11() #could also use PDF or so for saving.
  # par(mfrow=c(2,4)) 
  # par(mar=c(3,3,3,3))
  # x11()
  # par(mfrow=c(2,4))
  # par(mar=c(3,3,3,3))
  #print(dev.list())
  for (roi in colnames(data)[6:12])
  {
    for (side in c("Left","Right"))
    {
      tmp.verio=data[data$hemi==side&data$scanner=="VERIO",roi]
      tmp.skyra=data[data$hemi==side&data$scanner=="SKYRA",roi]
      tmp.data=data.frame(tmp.verio, tmp.skyra)
      tmp.data
      tmp_icc=icc(tmp.data)
      icc_res[i,"ROI"]=roi
      icc_res[i,"hemi"]=side
      icc_res[i,"icc"]=round(tmp_icc$icc.agreement,2)
      
      res <- boot(tmp.data,icc.boot,5)
      t=quantile(res$t,c(0.025,0.975))
      icc_res[i,"icc_lb"]=round(t[1],2)
      icc_res[i,"icc_ub"]=round(t[2],2)
      
      icc_res[i,"pd"]=round((200/nrow(tmp.data))*sum(abs(tmp.data[1]-tmp.data[2])/(tmp.data[1]+tmp.data[2])),2)
      #icc_res[i,"cohensD"]=round(cohensD(tmp.verio, tmp.skyra,method = "paired"),2)
      tmp_t=t.test(tmp.verio,tmp.skyra, paired=TRUE)
      icc_res[i, "ttest"]=round(tmp_t$statistic,2)
      icc_res[i,"p"]=round(tmp_t$p.value,2)
     
      # if (side=="Right"){
      #   print(side)
      #   dev.set(2)
      #   signeddiff=(tmp.data[1]-tmp.data[2])/(tmp.data[1]+tmp.data[2])
      #   hist(signeddiff$tmp.verio, main=roi)}
      # if (side=="Left"){
      #   print(side)
      #   dev.set(3)
      #   signeddiff=(tmp.data[1]-tmp.data[2])/(tmp.data[1]+tmp.data[2])
      #   hist(signeddiff$tmp.verio, main=roi)}
      
      i=i+1
    }
  }
  icc_res$p_adjust=round(p.adjust(icc_res$p, method = "fdr"),2)
  return(icc_res)
}