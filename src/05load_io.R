#load output files
#Output.zts
load(paste(pwcdir, "io/przmout.RData", sep = ""))
dim(outputdf)
# #pwc output
# load(paste(pwcdir, "io/pwcout.RData", sep = ""))
# 
# load(paste(pwcdir, "io/output.RData", sep = ""))
# colnames(paste(pwcdir, "io/output.RData", sep = ""))
# dim(pwcoutdf)
#TIME
load(paste(pwcdir,"io/timearray.RData", sep = ""))
#write.csv(timearray, file = paste(pwcdir, "io/timearray.csv", sep = ""))
nrows<- length(timearray)
#read input files
indata <- read.csv(file = paste(pwcdir, "io/inputlist_przm_vvwm.csv", sep = ""), header = TRUE)
class(indata)
dim(indata)
for(i in 1:17){
  print(class(indata[,i]))
}
colnames(indata)
#View(indata)
summary(indata)
# #cut out column "X"
# inputdata<- indata%>%select_if(is.numeric)%>%select(-1)
# inputdata2<- indata%>%select_if(is.numeric)
# #extract input vectors from dataframe
# for(i in 1:length(inputdata)){assign(names(inputdata)[i], inputdata[[i]])}

inputdata <- indata[,-1]
colnames(inputdata)
#inputdata <- indata[,-1:-4]
dim(inputdata)
summary(inputdata)
for(i in 1:16){
  print(class(inputdata[,i]))
}
colnames(inputdata)
