#############################  CONTROL ######################################
ndays <- length(timearray)

## load przm output

dim(outputdf)
outputdf[1:365,,1]#check output
ro <- outputdf[,4,1:Nsims]
sum(is.nan(pestinro))
pesthrooutput <- outputdf[,6,1:Nsims]#6pesticide concentration in runoff, 7 pesticide concentration in erosion,8pesticide concentration in pore water
pestinro<-ro*pesthrooutput*1e+9
#write.csv(pestinro, file = paste(pwcdir, "io/pestinro.csv", sep = ""))
dim(pestinro)
head(pestinro)
dim(inputdata)
nvars <- length(inputdata)#number of input variables

#create partial correlation coefficients array for output
tarray_pccout<- array(data=NA, c(ndays,nvars))#create time series input array
i=1
#partial correlation coefficients
for (i in 1:ndays){  #break
  out_sim<- pestinro[i,1:Nsims]
  temp_pcc<- pcc(inputdata[1:Nsims,], out_sim, rank = F)
  print(paste(i,"out of",ndays)) 
  tarray_pccout[i,] <- temp_pcc$PCC[[1]]
}

#write control pcc results to disk
dim(tarray_pccout)
save(tarray_pccout,file = paste(pwcdir,"io/tarray_pccout.RData", sep = ""))
write.csv(tarray_pccout, file = paste(pwcdir, "io/tarray_pccout.csv", sep = ""))
#plot(temp_pcc)
#####################################################################################################################
#############################  PWC ######################################
# ndays <- length(timearray)
# 
# ## load przm output
# 
# dim(pwcoutdf)
# pwcoutdf[1:10,,1]#check output
# 
# pwch2output <- pwcoutdf[,2,1:Nsims]#1depth, 2Ave.Conc.H20, 3Ave.Conc.benth, 4Peak.Conc.H20
# plot(pwcoutdf[,2,1:Nsims])
# dim(pwch2output)# simulations x variables
# dim(inputdata)# days x simulations
# nvars <- length(inputdata)#number of input variables
# 
# #create partial correlation coefficients array for input
# tarray_pwcpccout<- array(data=NA, c(ndays,nvars))
# 
# #partial correlation coefficients
# for (i in 1:ndays){  #break
#   out_sim<- pwch2output[i,1:Nsims]
#   
#   temp_pcc<- pcc(inputdata[1:Nsims,], out_sim, rank = F)
#   print(paste(i,"out of",ndays)) 
#   tarray_pwcpccout[i,] <- temp_pcc$PCC[[1]]
# }

#write control pcc results to disk

# dim(tarray_pccout)
# save(tarray_pccout,file = paste(pwcdir,"io/tarray_pccout.RData", sep = ""))
# write.csv(tarray_pccout, file = paste(pwcdir, "io/tarray_pccout.csv", sep = ""))
# 
# plot(temp_pcc)

