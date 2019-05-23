#devtools::install_github('cran/ggplot2')
##calculate Max value
# colMax <- function(data)sapply(data, max, na.rm = TRUE)
# colMax(pwch2output)

przmh2output <- (outputdf[,6,1:Nsims]*1000000)
head (przmh2output)
przmsedoutput <- (outputdf[,7,1:Nsims]*1000000)
head (przmsedoutput)
przmmax_h20<-apply(przmh2output, 2, function(x) max(x, na.rm = TRUE))
przmmax_sed<-apply(przmsedoutput, 2, function(x) max(x, na.rm = TRUE))
summary(przmmax_sed)

# pwch2output <- (pwcoutdf[,2,1:Nsims]*1000000)#in ug/ml
# pwcpeak<- (pwcoutdf[,4,1:Nsims]*1000000)#in ug/ml


# #colnames(pwcoutdf) 
# #write.csv(pwch2output, file = paste(pwcdir, "io/pwch2output.csv", sep = ""))
# #plot(pwch2output)
# #pwch2output <- (pwcoutdf[,4,1:Nsims]*1000000)#concentration in ppb
# max_h20<-apply(pwch2output, 2, function(x) max(x, na.rm = TRUE))
# #plot(max_h20)
# #write.csv(pwch2output, file = paste(pwcdir, "io/pwch2output.csv", sep = ""))
# #Calculate PCC in H2o
# #plot(pwch2output)
# max_peak<-apply(pwcpeak, 2, function(x) max(x, na.rm = TRUE))
# #plot(max_h20)
# #extract benthic concentration
# pwcbenutput <- (pwcoutdf[,3,1:Nsims]*1000000)
# #pwcbenutput <- (pwcoutdf[,3,1:Nsims]*1000000)#1depth, 2Ave.Conc.H20, 3Ave.Conc.benth, 4Peak.Conc.H20
# ##calculate Maxbenthic concentration
# max_ben<-apply(pwcbenutput, 2, function(x) max(x, na.rm = TRUE))
# ########finding sediment pcc####################
# max_sed=output*max_ben
# max_sedd=as.numeric(unlist(max_sed))
# typeof(max_sed)
# which(is.na(as.numeric(as.character(max_ben[[1]]))))
# is.infinite(max_ben)

inputdf <- cbind(inputdata, przmmax_h20)
inputdf <- cbind(inputdata, przmmax_sed)
#inputdf <- cbind(inputdata, max_peak)
#View(inputdf)
# inputdf <- cbind(inputdf, max_ben)
# inputdf <- cbind(inputdf, output)
# inputdf <- cbind(inputdf, max_sedd)
write.csv(inputdf, file = paste(pwcdir, "io/inputdata_przm_max.csv", sep = ""))

library(ppcor)
dim(inputdf)
# pearson correlation
dim(inputdata)
for(i in 1:28){
  var <- colnames(inputdata)[i]
  pcor_value <- pcor(cbind(inputdata[,i],przmmax_h20), method="pearson")$estimate[1,2]
  print(paste(var, pcor_value, min(inputdata[,i]), max(inputdata[,i])))
}
pcc

#cor_value<-pcor(inputdf[,-c(52:54)],method="pearson")

#, rank = TRUE,nboot = 0, conf = 0.95)
przmmax_h2opcc<- pcc(inputdata, przmmax_h20, rank = F, conf = 0.95)
przmmax_sedpcc<- pcc(inputdata, przmmax_sed, rank = F, conf = 0.95)
print(przmmax_h2opcc)
print(przmmax_sedpcc)


# max_peakpcc<- pcc(inputdata, max_peak, rank = F)
# max_h2opcc<- pcc(inputdata, max_h20, rank = F)
# max_benpcc<- pcc(inputdata, max_ben, rank = F)
# max_sedpcc<- pcc(inputdata, max_sedd, rank = F)
par(mfrow=c(2,1))
plot(przmmax_h2opcc, ylim = c(-1,1))

plot(przmmax_sedpcc, ylim = c(-1,1))
