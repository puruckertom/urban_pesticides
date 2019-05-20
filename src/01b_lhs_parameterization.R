#install.packages("lhs")
#import lhs library
library(lhs)
#list input paramters
input_parameters <- c("PFAC","ANETD","uslek","uslels","uslep","slp","hl","CN","MNGN","app_tm","dep","app_rate","app_eff","PLVKRT","DWRATE","DSRATE")
#input_parameters <- c("PFAC","ANETD","uslek","uslels","uslep","slp","hl","CN_c","CN_f","uslec_c","uslec_f","MNGN","depth","COVMAX","HTMAX","holdup","bd1","bd2","bd3","bd4","bd5","fc","WP","OC","dep","app_rate","app_eff","PLDKRT","DWRATE","DSRATE","koc","aer_aq","temp_ref_aer","anae_aq","temp_ref_anae","photo","RFLAT","hydro","SOL","benthic_depth","porosity","bulk_density","FROC2","DOC2","BNMAS","SUSED","CHL","FROC1","DOC1","PLMAS","bf")
#import paramter range csv table
param_ranges <- read.csv(paste(pwcdir,"input/lhs_param_ranges.csv",sep=""),header= TRUE, sep= ",", stringsAsFactors = FALSE, row.names=NULL)



quantile_list <- randomLHS(Nsims, length(input_parameters)) 
dimnames(quantile_list ) <- list(NULL, input_parameters) 
# input_list  is now a uniformly distributed Latin hypercube 
head(quantile_list )


input_list <- data.frame(matrix(NA,nrow=dim(quantile_list)[1],ncol=dim(quantile_list)[2]))
for(i in 1:ncol(quantile_list)){
  #create quasi random numbers
  draw <- round(qunif(quantile_list[,i], min = param_ranges[i,2], max = param_ranges[i,3]),3)
  input_list[,i] <- draw
}
input_list
colnames(input_list) <- c(input_parameters) 
# hist(input_list$PFAC,main="Histogram", xlab="PFAC", border="blue", col="green")
# plot(input_list$CN_c)

#Overwrite DSRATE to be the same as the randomly generated DWRATE
input_list[,"DSRATE"] <- input_list[,"DWRATE"]

write.csv(input_list, file = paste(pwcdir, "io/inputlist_przm_vvwm.csv", sep = ""))