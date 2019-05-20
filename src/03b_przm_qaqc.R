dim(inputdf)
dim(input_list)
# sims cols
#50 34
dim(outputdf) # days outputs sims

colnames(inputdf)
colnames(outputdf) <- c("YYYY","MM","DD","RUNF0","ESLS0","RFLX1","EFLX1","DCON1","INFL0")
colnames(outputdf)

Npcc <- Nsims
Npcc <- 50

io_df <- matrix(NA,Npcc,37)
for(i in 1:Npcc){
  io_df[i,] <- as.vector(unlist(c(inputdf[i,4:34],outputdf[1200,4:9,i])))
}
colnames(io_df) <- c(colnames(inputdf)[4:34],colnames(outputdf)[4:9])
#View(io_df)
write.csv(io_df, file = paste(pwcdir, "io/io_df_03qaqc.csv", sep = ""))

dim(io_df)
for(j in 32:37){
  output_var <- colnames(io_df)[j]
  nonzero_keepers <- which(io_df[,j]>0)
  nonzero_count <- length(nonzero_keepers)
  print(paste("there are", nonzero_count, "non-zero values"))
  for(i in 1:31){
    var <- colnames(io_df)[i]
    pcc_value <- pcor(cbind(io_df[nonzero_keepers,i],io_df[nonzero_keepers,j]), method="pearson")$estimate[1,2]
    print(paste(output_var, var, pcc_value, min(io_df[nonzero_keepers,i]), max(io_df[nonzero_keepers,i])))
  }
}
