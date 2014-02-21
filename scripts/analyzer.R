#read from file
data=read.csv("/home/behrooz/twofourFS/run/shm/results/gcc_base.gcc43-64bit//gcc_base.gcc43-64bit_load.csv",header=FALSE)
#Sort them
ordered = data[order(-data[,2],data[,2]),2]
#ranks
ranks = rank(-ordered)
#Unique
uniqued = ordered[!duplicated(ordered)]
#unique ranks
uniqueranks=ranks[!duplicated(ranks)]
#plot the log log graph
d.f <- data.frame( x = uniqueranks, y = uniqued )
plot( y ~ x, data = d.f,log="xy")
#Compute the frequencies
tabled=table(ordered)


#try an expnential distribution
exp = rexp(2000,rate=1000)
ordered = exp[order(-exp,exp)]
plot(ordered,log="xy")



initial.dir<-getwd()
# change to the new directory
dir = "/home/behrooz/valgrind_result/SPECPU/"
setwd(dir)
loadFiles = list.files(pattern = '*load.csv');
for(i in loadFiles) {
  #zipf[[i]]  <- do.call("rbind",lapply(read.table(i, header=T, quote="\""),mean))
  #read from file
  data=read.csv(i,header=FALSE)
  #Sort them
  ordered = data[order(-data[,2],data[,2]),2]
  #ranks
  ranks = rank(-ordered)
  #Unique
  uniqued = ordered[!duplicated(ordered)]
  #unique ranks
  uniqueranks=ranks[!duplicated(ranks)]
  #plot the log log graph
  d.f <- data.frame( x = uniqueranks, y = uniqued )
  #output
  name=paste(dir,i,"")
  pureName=gsub(".csv","",name)
  name=paste(pureName,"1(xy).png");
  png(name)
  plot( y ~ x, data = d.f,xlab="Log(rank) Rank Mem Address",ylab="Log(Frequency) Freq. Mem Address",log="xy",main=paste(gsub(".csv","",i)," log(xy)"))
  dev.off()
  name=paste(pureName,"2(y).png");
  png(name)
  plot( y ~ x, data = d.f,xlab="Rank Mem Address",ylab="Log(Frequency) Freq. Mem Address",log="y",main=paste(gsub(".csv","",i),"log(y)"))
  dev.off()
}
# change back to the original directory
setwd(initial.dir)


##for line chart
initial.dir<-getwd()
# change to the new directory
dir = "/home/behrooz/valgrind_result/SPEC-Run3-Douze-CacheLine/mcf_base.gcc43-64bit_load.csv"
setwd(dir)
loadFiles = list.files(pattern = '*load.csv');
for(i in loadFiles) {
  #zipf[[i]]  <- do.call("rbind",lapply(read.table(i, header=T, quote="\""),mean))
  #read from file
  data=read.csv(i,header=FALSE)
  #Sort them
  ordered = data[order(-data[,2],data[,2]),2]
  #ordered=ordered/10
  for(jj in 2:length(ordered)) { ordered[jj] = as.numeric(ordered[jj]+ordered[jj-1])}
  #ranks
  ranks = 1:length(ordered)
  #output
  name=paste(dir,i,"")
  pureName=gsub(".csv","",name)
  name=paste(pureName,"1(all).pdf");
  #pdf(name)
  len=length(ordered)
  #len=47500
  maxX=ordered[len]
  maxX=maxX+maxX/20
  maxY=len+len/20
  plot( ordered[1:len],ranks[1:len],xlab=paste("Accumulative Mem Freq.",(ordered[len]/ordered[length(ordered)])*100),ylab="# of Cache Lines",main=paste(gsub(".csv","",i),len),type="n",xlim=c(0,maxX),ylim=c(0,maxY))
  lines(ordered[1:len],ranks[1:len], type="s") 
  #dev.off()
  name=paste(pureName,"2(1000).png");
  #png(name)
  len=47500
  maxX=ordered[len]
  maxX=maxX+maxX/20
  maxY=len+len/20
  plot( ordered[1:len],ranks[1:len],xlab=paste("Accumulative Mem Freq.",(ordered[len]/ordered[length(ordered)])*100),ylab="# of Cache Lines",main=paste(gsub(".csv","",i),len),type="n",xlim=c(0,maxX),ylim=c(0,maxY))
  lines(ordered[1:len],ranks[1:len], type="s") 
  #dev.off()
  name=paste(pureName,"3(500).png");
  #png(name)
  len=500
  maxX=ordered[len]
  maxX=maxX+maxX/20
  maxY=len+len/20
  plot( ordered[1:len],ranks[1:len],xlab=paste("Accumulative Mem Freq.",(ordered[len]/ordered[length(ordered)])*100),ylab="# of Cache Lines",main=paste(gsub(".csv","",i),len),type="n",xlim=c(0,maxX),ylim=c(0,maxY))
  lines(ordered[1:len],ranks[1:len], type="s") 
  #dev.off()
  name=paste(pureName,"4(100).png");
  #png(name)
  len=100
  maxX=ordered[len]
  maxX=maxX+maxX/20
  maxY=len+len/20
  plot( ordered[1:len],ranks[1:len],xlab=paste("Accumulative Mem Freq.",(ordered[len]/ordered[length(ordered)])*100),ylab="# of Cache Lines",main=paste(gsub(".csv","",i),len),type="n",xlim=c(0,maxX),ylim=c(0,maxY))
  lines(ordered[1:len],ranks[1:len], type="s") 
  dev.off()
}
# change back to the original directory
setwd(initial.dir)






initial.dir<-getwd()
# change to the new directory
dir = "/home/behrooz/valgrind_result/SPEC-Run3-Douze-CacheLine/"
setwd(dir)
loadFiles = list.files(pattern = '*load.csv');
res=c()
counter=1
for(i in loadFiles) {
  #zipf[[i]]  <- do.call("rbind",lapply(read.table(i, header=T, quote="\""),mean))
  #read from file
  data=read.csv(i,header=FALSE)
  #Sort them
  ordered = data[order(-data[,2],data[,2]),2]
  ordered=ordered/10
  for(jj in 2:length(ordered)) { ordered[jj] = as.numeric(ordered[jj]+ordered[jj-1])}
  #ranks
  diff= ordered[length(ordered)]-ordered[96000]
  if(length(ordered)<96000)
    diff = 0
  
  #diff=diff*10
  res[counter]=paste(i,diff)
  counter=counter+1
}
write(res,file="/home/behrooz/FINAL.csv")