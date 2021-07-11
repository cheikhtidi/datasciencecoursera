<<<<<<< HEAD
corr=function(directory,threshold=0){
  files_full=list.files(directory,full.names=T)
  #create empty data set
  
  dat=vector(mode="numeric", length=0)
  
  for (i in 1:length(files_full)){
    
    tmp=read.csv(files_full[i])
    
    csum=sum((!is.na(tmp$sulfate)) & (!is.na(tmp$nitrate)))
    
    if (csum>threshold){
      sul=tmp[which(!is.na(tmp$sulfate)),]
      nit=sul[which(!is.na(sul$nitrate)),]
      dat=c(dat,cor(nit$sulfate,nit$nitrate))
    }
    
  }
  dat
}

corr(getwd(),150)
=======
>>>>>>> 1d8c4d1d1aafaba1a86aa37bbeb28dabea1f7e52

