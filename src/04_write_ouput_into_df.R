
#############################################################################################################
Ite <- 1
df <- read.table(paste(newdir,"/","output",".zts", sep=""), header= FALSE, sep= "",
                 skip = 3, stringsAsFactors = FALSE, row.names=NULL)
dim(df)
nrows <- dim(df)[[1]] #this is dependent on the duration of the simulation as set in the comparison.vrp file
ncols <- dim(df)[[2]]

timearray<-seq(as.Date("2009-01-01"), as.Date("2014-12-31"), by="days")#1961-01-01
timearray<- as.Date(timearray,"%m/%d/%Y")
timediff <- timearray[3]-timearray[2]
timearray[1] <- timearray[2]-timediff
length(timearray)
save(timearray, file = paste(pwcdir,"io/timearray.RData",sep = ""))
#write.csv(timearray, file = paste(pwcdir, "io/timearray.csv", sep = ""))
#############################################################################################################

#read przm output and save as Rdata
# df <- read.table(paste(newdir,"/","output",".zts", sep=""), header= FALSE, sep= "",
#                  skip = 3, stringsAsFactors = FALSE, row.names=NULL)
# dim(df)
# str(df)
# nrows <- dim(df)[[1]] 
# ncols <- dim(df)[[2]]
# 
# outputdf <- array(data=NA, c(nrows,ncols,Nsims))
# 
# dim(outputdf)
# str(outputdf)
# 
# for (Ite in 1:Nsims) {
#   print(Ite)
#   
#   df <- read.table(paste(newdir,"/","output",".zts", sep=""), header= FALSE, sep= "",
#                    skip = 3, stringsAsFactors = FALSE, row.names=NULL)
#   #print(df)
#   newdf <- df[,3:ncols]
#   outputdf[1:nrows,1:ncols,Ite] <- abind(df[1:nrows,1:ncols], along=3)
#   
#   dim(outputdf)
#   print(outputdf)
# }
colnames(outputdf) <- c("YYYY","MM","DD","RUNF0","ESLS0","RFLX1","EFLX1","DCON1","INFL0")
save(outputdf, file = paste(pwcdir,"io/przmout.RData",sep = ""))
#write.csv(outputdf, file = paste(pwcdir, "io/przmout.csv", sep = ""))
rm(outputdf)

#PWC csv output#######################################################################################################
# pwcdf <- read.csv(paste(newdir,"/","output_CAalmond_WirrigSTD_Custom_Parent_daily.csv", sep=""), header= FALSE, sep= ",",
#                  skip = 5, stringsAsFactors = FALSE, row.names=NULL)
# dim(pwcdf)
# str(pwcdf)
# nrows <- dim(pwcdf)[[1]]
# ncols <- dim(pwcdf)[[2]]
# pwcoutdf <- array(data=NA, c(nrows,ncols,Nsims))
# 
# dim(pwcoutdf)
# str(pwcoutdf)
# for (Ite in 1:Nsims) {
#   print(Ite)
#   
#   pwcdf <- read.csv(paste(newdir,"/","output_CAalmond_WirrigSTD_Custom_Parent_daily",".csv", sep=""), header= FALSE, sep= ",",
#                     skip = 5, stringsAsFactors = FALSE, row.names=NULL)
# 
#   str(pwcdf)
#   dim(pwcdf)
#   colnames(pwcdf)
# 
#   dim(pwcoutdf)
#   pwcoutdf[1:nrows,1:ncols,Ite] <- abind(pwcdf[1:nrows,1:ncols], along=3)
# 
#   dim(pwcoutdf)
#   str(pwcoutdf)
# }
colnames(pwcoutdf) <- c("Depth(m)","Ave.Conc.H20","Ave.Conc.benth","Peak.Conc.H20")
#colnames(pwcoutdf) <- c("Ave.Conc.H20","Ave.Conc.benth","Peak.Conc.H20")
save(pwcoutdf, file = paste(pwcdir,"io/pwcout.RData", sep = ""))
#write.csv(pwcoutdf, file = paste(pwcdir, "io/pwctest.csv", sep = ""))


# 
# #############################################################################################################
# Ite <- 1
# df <- read.table(paste(newdir,"/","output",".zts", sep=""), header= FALSE, sep= "",
#                  skip = 3, stringsAsFactors = FALSE, row.names=NULL)
# dim(df)
# nrows <- dim(df)[[1]] #this is dependent on the duration of the simulation as set in the comparison.vrp file
# ncols <- dim(df)[[2]]
# 
# timearray<-seq(as.Date("1961-01-01"), as.Date("2014-12-31"), by="days")#1961-01-01
# timearray<- as.Date(timearray,"%m/%d/%Y")
# timediff <- timearray[3]-timearray[2]
# timearray[1] <- timearray[2]-timediff
# length(timearray)
# save(timearray, file = paste(pwcdir,"io/timearray.RData",sep = ""))
# #write.csv(timearray, file = paste(pwcdir, "io/timearray.csv", sep = ""))
# #############################################################################################################
# 
# #read przm output and save as Rdata
# # df <- read.table(paste(newdir,"/","output",".zts", sep=""), header= FALSE, sep= "",
# #                  skip = 3, stringsAsFactors = FALSE, row.names=NULL)
# # dim(df)
# # str(df)
# # nrows <- dim(df)[[1]] 
# # ncols <- dim(df)[[2]]
# # 
# # outputdf <- array(data=NA, c(nrows,ncols,Nsims))
# # 
# # dim(outputdf)
# # str(outputdf)
# # 
# # for (Ite in 1:Nsims) {
# #   print(Ite)
# #   
# #   df <- read.table(paste(newdir,"/","output",".zts", sep=""), header= FALSE, sep= "",
# #                    skip = 3, stringsAsFactors = FALSE, row.names=NULL)
# #   #print(df)
# #   newdf <- df[,3:ncols]
# #   outputdf[1:nrows,1:ncols,Ite] <- abind(df[1:nrows,1:ncols], along=3)
# #   
# #   dim(outputdf)
# #   print(outputdf)
# # }
# colnames(outputdf) <- c("YYYY","MM","DD","RUNF0","ESLS0","RFLX1","EFLX1","DCON1","INFL0")
# 
# save(outputdf, file = paste(pwcdir,"io/przmout.RData",sep = ""))
# #write.csv(outputdf, file = paste(pwcdir, "io/przmout.csv", sep = ""))
# rm(outputdf)
# 
# #PWC csv output#######################################################################################################
# # pwcdf <- read.csv(paste(newdir,"/","output_CAalmond_WirrigSTD_Custom_Parent_daily.csv", sep=""), header= FALSE, sep= ",",
# #                  skip = 5, stringsAsFactors = FALSE, row.names=NULL)
# # dim(pwcdf)
# # str(pwcdf)
# # nrows <- dim(pwcdf)[[1]]
# # ncols <- dim(pwcdf)[[2]]
# # pwcoutdf <- array(data=NA, c(nrows,ncols,Nsims))
# # 
# # dim(pwcoutdf)
# # str(pwcoutdf)
# # for (Ite in 1:Nsims) {
# #   print(Ite)
# #   
# #   pwcdf <- read.csv(paste(newdir,"/","output_CAalmond_WirrigSTD_Custom_Parent_daily",".csv", sep=""), header= FALSE, sep= ",",
# #                     skip = 5, stringsAsFactors = FALSE, row.names=NULL)
# # 
# #   str(pwcdf)
# #   dim(pwcdf)
# #   colnames(pwcdf)
# # 
# #   dim(pwcoutdf)
# #   pwcoutdf[1:nrows,1:ncols,Ite] <- abind(pwcdf[1:nrows,1:ncols], along=3)
# # 
# #   dim(pwcoutdf)
# #   str(pwcoutdf)
# # }
# colnames(pwcoutdf) <- c("Depth(m)","Ave.Conc.H20","Ave.Conc.benth","Peak.Conc.H20")
# #colnames(pwcoutdf) <- c("Ave.Conc.H20","Ave.Conc.benth","Peak.Conc.H20")
# save(pwcoutdf, file = paste(pwcdir,"io/pwcout.RData", sep = ""))
# #write.csv(pwcoutdf, file = paste(pwcdir, "io/pwctest.csv", sep = ""))
# 
# #View(pwcoutdf)
# 
# rm(pwcoutdf)