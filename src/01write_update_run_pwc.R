#Create empty dataframe for outputs
#############PRZM###########################################
df_przm <- read.table(paste(pwcdir,"output/output",".zts", sep=""), header= FALSE, sep= "",
                skip = 3, stringsAsFactors = FALSE, row.names=NULL)
# dim(df)
# str(df)
nrows_przm <- dim(df_przm)[[1]]
ncols_przm <- dim(df_przm)[[2]]
outputdf <- array(data=NA, c(nrows_przm,ncols_przm,Nsims))
#dim(outputdf)
#############PWC#########################################
pwcdf_o <- read.csv(paste(pwcdir,"output/output_CAalmond_WirrigSTD_Custom_Parent_daily.csv", sep=""), header= FALSE, sep= ",",
                  skip = 5, stringsAsFactors = FALSE, row.names=NULL)
# dim(pwcdf_o)
# str(pwcdf_o)
rows_pwc <- dim(pwcdf_o)[[1]]
cols_pwc <- dim(pwcdf_o)[[2]]
pwcoutdf <- array(data=NA, c(rows_pwc,cols_pwc,Nsims))
#######################Conversion factor dataframe###############################
con_fac <- data.frame(matrix(ncol = 1, nrow = Nsims))
dim(con_fac)

###############update input file################
set.seed(42)
for (Ite in 1:Nsims){
  print(Ite)
  con_przm5 <- file(paste(pwcdir, "input/przm/PRZM5",".inp",sep=""))
  a_old=readLines(con_przm5)
  a=readLines(con_przm5)
  close(con_przm5)
###########update parameter##########################################################################
  a[4]="C:\\git\\sinnathamby_pwc\\output\\20737_grid.wea"
 
  a[6]="C:\\git\\sinnathamby_pwc\\output\\przm\\output.zts"
 
  ############################################################################################################
  ######Pan factor##############
  PFAC=round(input_list[Ite,"PFAC"],2)
  a[10]=paste(sprintf("%.02f", PFAC),substr(a[10],5,16), sep="")
  ###########Evaporation Depth (cm)################################
  ANETD=round(input_list[Ite,"ANETD"],1)
  ANETD_list <- unlist(strsplit(a[10],","))
  ANETD_list[3]<-ANETD
  a[10]=paste(ANETD_list,collapse=",")
  #####USLEK#######################
  # uslek=round(input_list[Ite,"uslek"],2)
  # a[14]=paste(sprintf("%.02f", uslek),substr(a[14],5,34), sep="")
  uslek=round(input_list[Ite,"uslek"],2)
  uslek_list <- unlist(strsplit(a[14],","))
  uslek_list[1]<-uslek
  a[14]=paste(uslek_list,collapse=",")
  #############uslels slope length factor, representing the effect of slope length on erosion########################################
  uslels=round(input_list[Ite,"uslels"],2)
  uslels_list <- unlist(strsplit(a[14],","))
  uslels_list[2]<-uslels
  a[14]=paste(uslels_list,collapse=",")
  #############uslep############################################################################################
  uslep=round(input_list[Ite,"uslep"],2)
  uslep_list <- unlist(strsplit(a[14],","))
  uslep_list[3]<-uslep
  a[14]=paste(uslep_list,collapse=",")
  ################slope#######################################################################################
  slp=round(input_list[Ite,"slp"],2)
  slp_list <- unlist(strsplit(a[14],","))
  slp_list[6]<-slp
  a[14]=paste(slp_list,collapse=",")
  ##############################hydraulic length##############################################################
  hl=round(input_list[Ite,"hl"],0)
  hl_list <- unlist(strsplit(a[14],","))
  hl_list[7]<-hl
  a[14]=paste(hl_list,collapse=",")
  #############CN###############################################################################################

  Num=24#Number of Applications
  CN=round(input_list[Ite,"CN"],0)
  row_0=18
  for (i in 1:Num){
    row_t=row_0+(i-1)
    cn_list <- unlist(strsplit(a[row_t],","))
    #cn_list[6]<-(as.numeric(CNPer[Ite]))*(as.numeric(cn_list[6]))
    cn_list[6]<-CN
    a[row_t]=paste(cn_list,collapse=",")

  }

 # Num=8#Number of Applications
 # CN_f=round(input_list[Ite,"CN_f"],0)
 # row_0=34
 # for (i in 1:Num){
 #   row_t=row_0+(i-1)
 #   cn_list <- unlist(strsplit(a[row_t],","))
 #   #cn_list[6]<-(as.numeric(CNPer[Ite]))*(as.numeric(cn_list[6]))
 #   cn_list[6]<-CN_f
 #   a[row_t]=paste(cn_list,collapse=",")
 # 
 # }
 ######################USLEC##########################################################################################
 # Num=24#Number of crop periods that follow
 # uslec=round(input_list[Ite,"uslec"],3)
 # row_0=18
 # for (i in 1:Num){
 #   row_t=row_0+(i-1)
 #   uslec_list <- unlist(strsplit(a[row_t],","))
 #   uslec_list[4]<-uslec
 #   a[row_t]=paste(uslec_list,collapse=",")
 #   #a[row_t]=paste(substr(a[row_t],1,71), sprintf("%.02f",uslec), substr(a[row_t],76,92),sep="")
 # }

 # Num=8#Number of crop periods that follow
 # uslec_f=round(input_list[Ite,"uslec_f"],3)
 # row_0=34
 # for (i in 1:Num){
 #   row_t=row_0+(i-1)
 #   uslec_list <- unlist(strsplit(a[row_t],","))
 #   uslec_list[4]<-uslec_f
 #   a[row_t]=paste(uslec_list,collapse=",")
 #   #a[row_t]=paste(substr(a[row_t],1,71), sprintf("%.02f",uslec), substr(a[row_t],76,92),sep="")
 # }
 #

 #################################manning's n#################################################
 Num_r5=24#Number of crop periods that follow
 MNGN=round(input_list[Ite,"MNGN"],3)
 row_r5=18
 for (i in 1:Num_r5){
   row_t=row_r5+(i-1)
   MNGN_list <- unlist(strsplit(a[row_t],","))
   MNGN_list[5]<-MNGN
   a[row_t]=paste(MNGN_list,collapse=",")
   #a[row_t]=paste(substr(a[row_t],1,71), sprintf("%.02f",uslec), substr(a[row_t],76,92),sep="")
 }
 #####################root depth###############################################################################
 # Numd=6#Number of crop periods that follow
 # depth=round(input_list[Ite,"depth"],0)
 # row_0=45
 # for (i in 1:Numd){
 #   row_t=row_0+(i-1)
 #   depth_list <- unlist(strsplit(a[row_t],","))
 #   depth_list[10]<-depth
 #   a[row_t]=paste(depth_list,collapse=",")
 # }
#################################COVMAX############################################
 # Numd=6#Number of crop periods that follow
 # COVMAX=round(input_list[Ite,"COVMAX"],3)
 # row_0=45
 # for (i in 1:Numd){
 #   row_t=row_0+(i-1)
 #   COVMAX_list <- unlist(strsplit(a[row_t],","))
 #   COVMAX_list[11]<-COVMAX
 #   a[row_t]=paste(COVMAX_list,collapse=",")
 # }
 # #############################HTMAX########################################################
 # Numd=6#Number of crop periods that follow
 # HTMAX=round(input_list[Ite,"HTMAX"],0)
 # row_0=45
 # for (i in 1:Numd){
 #   row_t=row_0+(i-1)
 #   HTMAX_list <- unlist(strsplit(a[row_t],","))
 #   HTMAX_list[12]<-HTMAX
 #   a[row_t]=paste(HTMAX_list,collapse=",")
 # }
 # #############################holdup (cm)####################################
 # Numd=6#Number of crop periods that follow
 # holdup=round(input_list[Ite,"holdup"],2)
 # row_0=45
 # for (i in 1:Numd){
 #   row_t=row_0+(i-1)
 #   holdup_list <- unlist(strsplit(a[row_t],","))
 #   holdup_list[13]<-holdup
 #   a[row_t]=paste(holdup_list,collapse=",")
 # }
 ###############max rate irrigation#########
 # RATEAP=input_list[Ite,"RATEAP"]
 # RATEAP_list <- unlist(strsplit(a[64],","))
 # RATEAP_list[4]<-RATEAP
 # a[64]=paste(RATEAP_list,collapse=",")
 ####Bulk density#############################################################################################

 # bd1=round(input_list[Ite,"bd1"],2)
 # #bd2=round(input_list[Ite,"bd2"],2)
 # #bd3=round(input_list[Ite,"bd3"],2)
 # #bd4=round(input_list[Ite,"bd4"],2)
 # # bd5=round(input_list[Ite,"bd5"],2)
 # 
 # # BD6=runif(Nsims, min=1, max=2)
 # 
 # bd1_list <- c(unlist(strsplit(a[57],",")),"")#adding extra empty value at end
 # bd1_list[5]<-bd1
 # a[57]=paste(bd1_list,"",collapse=",")
 # #a[69]=paste(substr(a[69],1,15), sprintf("%.02f",bd1), substr(a[69],20,55),sep=",")

 # bd2_list <- c(unlist(strsplit(a[58],",")),"")#adding extra empty value at end
 # bd2_list[5]<-bd2
 # a[58]=paste(bd2_list,"",collapse=",")
 # #a[70]=paste(substr(a[70],1,13), sprintf("%.02f",bd2), substr(a[70],19,55),sep=",")
 # 
 # bd3_list <- c(unlist(strsplit(a[59],",")),"")#adding extra empty value at end
 # bd3_list[5]<-bd3
 # a[59]=paste(bd3_list,"",collapse=",")
 # #a[71]=paste(substr(a[71],1,14), sprintf("%.02f",bd3), substr(a[71],19,55),sep=",")

#
#  bd4_list <-c(unlist(strsplit(a[60],",")),"")#adding extra empty value at end
#  bd4_list[5]<-bd4
#  a[60]=paste(bd4_list,"",collapse=",")
 #a[72]=paste(substr(a[72],1,14), sprintf("%.02f",bd4), substr(a[72],19,55),sep=",")

 # bd5_list <- c(unlist(strsplit(a[63],",")),"")
 # bd5_list[5]<-bd5
 # a[63]=paste(bd5_list,"",collapse=",")
 # #a[73]=paste(substr(a[73],1,14), sprintf("%.02f",bd5), substr(a[73],19,55),sep=",")
  #####################################FC###########################################################################
 # Num_s=1#soil layer
 # fc=round(input_list[Ite,"fc"],2)
 # row_s=57
 # for (i in 1:Num_s){
 #   row_t=row_s+(i-1)
 #   fc_list <- unlist(strsplit(a[row_t],","))
 #   fc_list[7]<-fc
 #   a[row_t]=paste(fc_list,collapse=",")
 # 
 # }
 # ##################################WP############################################################################
 # Num_s=1#soil layer
 # WP=round(input_list[Ite,"WP"],2)
 # row_s=57
 # for (i in 1:Num_s){
 #   row_t=row_s+(i-1)
 #   WP_list <- unlist(strsplit(a[row_t],","))
 #   WP_list[8]<-WP
 #   a[row_t]=paste(WP_list,collapse=",")
 # 
 # }
 ##################OC#######################################################################################
 # Num_s=1#soil layer
 # OC=round(input_list[Ite,"OC"],2)
 # row_s=57
 # for (i in 1:Num_s){
 #   row_t=row_s+(i-1)
 #   OC_list <- unlist(strsplit(a[row_t],","))
 #   OC_list[9]<-OC
 #   a[row_t]=paste(OC_list,collapse=",")
 # 
 # }
#  ################################################################################################
 Num=72#Number of Applications
 app_tm=round(input_list[Ite,"app_tm"],0)
 row_0=66
 for (i in 1:Num){
   row_t=row_0+(i-1)
   app_tm_list <- unlist(strsplit(a[row_t],","))
   app_tm_list[1]<-app_tm
   a[row_t]=paste(app_tm_list,collapse=",")

 }
 # #################################################################################################
 # Num=16#Number of Applications
 # app_m=round(input_list[Ite,"app_tm"],0)
 # row_0=82
 # for (i in 1:Num){
 #   row_t=row_0+(i-1)
 #   app_m_list <- unlist(strsplit(a[row_t],","))
 #   app_m_list[4]<-app_m
 #   a[row_t]=paste(app_m_list,collapse=",")
 #   
 # }
 #####################################depth of the pesticide application ##################################################################

 Num=72#Number of Applications
 dep=round(input_list[Ite,"dep"],2)
 row_0=66
 for (i in 1:Num){
   row_t=row_0+(i-1)
   dep_list <- unlist(strsplit(a[row_t],","))
   dep_list[5]<-dep
   a[row_t]=paste(dep_list,collapse=",")

 }

  ##############application rate###################################################################
 #Num=12#Number of Applications
 Num = 72
 app_rate=round(input_list[Ite,"app_rate"],2)
 row_0=66
 for (i in 1:Num){
   row_t=row_0+(i-1)
   app_rate_list <- unlist(strsplit(a[row_t],","))
   app_rate_list[6]<-app_rate
   a[row_t]=paste(app_rate_list,collapse=",")

 }
 ##############################application_eff##############################
 Num=72#Number of Applications
 app_eff=round(input_list[Ite,"app_eff"],2)
 row_0=66
 for (i in 1:Num){
   row_t=row_0+(i-1)
   app_eff_list <- unlist(strsplit(a[row_t],","))
   app_eff_list[7]<-app_eff
   a[row_t]=paste(app_eff_list,collapse=",")

 }
 #################PLVKRT############################################################
 PLVKRT=input_list[Ite,"PLVKRT"]
 PLVKRT_list <- unlist(strsplit(a[141],","))
 PLVKRT_list[1]<-PLVKRT
 a[141]=paste(PLVKRT_list,collapse=",")
 ####################PLDKRT############################################
 # PLDKRT=round(input_list[Ite,"PLDKRT"],3)
 # PLDKRT_list <- unlist(strsplit(a[99],","))
 # PLDKRT_list[2]<-PLDKRT
 # a[99]=paste(PLDKRT_list,collapse=",")
 ##########################DWRATE##################################################################
 Numhz=1#Number of soil layer
 DWRATE=round(input_list[Ite,"DWRATE"],3)
 row_hz=157
 for (i in 1:Numhz){
   row_t=row_hz+(i-1)
   DWRATE_list <- unlist(strsplit(a[row_t],","))
   DWRATE_list[1]<-DWRATE
   a[row_t]=paste(DWRATE_list,collapse=",")
 }
 ############################DSRATE###########################################################################
 Numhz=1#Number of soil layer
 #DSRATE=input_list[Ite,"DSRATE"]
 row_hz=157
 for (i in 1:Numhz){
   row_t=row_hz+(i-1)
   DSRATE_list <- unlist(strsplit(a[row_t],","))
   DSRATE_list[2]<-DWRATE
   a[row_t]=paste(DSRATE_list,collapse=",")
 }
 ###########################################################################################################
  newdir <- paste0(pwcdir,"input/przm/input",Ite)
  print(newdir)
  dir.create(newdir,showWarnings = FALSE) 
  cwd <- getwd()          # CURRENT dir
  setwd(newdir) 
  #copy weather file
  weather_input <- paste(pwcdir_exe, pwc_weather_used, sep="")
  file.copy(weather_input,newdir, recursive = FALSE, 
            copy.mode = TRUE)

  file_path_as_absolute(newdir)
  #update weather and output under each input folder
  a[4]=paste(file_path_as_absolute(newdir),"/",pwc_weather_used, sep="")
  a[6]=paste(file_path_as_absolute(newdir),"/","output.zts", sep="")
  #copy PRZM.exe############################################
  print(paste(file.exists(przmdir_executable), ": executable file at", przmdir_executable))
  file.copy(przmdir_executable,newdir, recursive = FALSE, 
            copy.mode = TRUE)
  # ###########Update vvwm##################################################

  source(paste(pwcdir,"src/02_write_update_vvwm.R",sep = ""))

  #copy VVWM.exe
  print(paste(file.exists(vvwmdir_executable), ": executable file at", vvwmdir_executable))
  file.copy(vvwmdir_executable,newdir, recursive = FALSE,
            copy.mode = TRUE)
  #write input file
  przm_file <- paste("PRZM5",".inp", sep="")
  file.exists(przm_file)
  file.create(przm_file)
  file.exists(przm_file)
  con_przm <-file(przm_file)
  writeLines(a,
             con_przm)
  close(con_przm)
  # source(paste(pwcdir,"src/02write_przm_input.R",sep = ""))
  #run###PRZM.exe#
  system2(przmdir_executable)
  # #run###vvwm.exe#
  system2(vvwmdir_executable, "vvwmTransfer.txt")
  #############################Write input into csv##############################

  ###############PRZM#############################################################
  df <- read.table(paste(newdir,"/","output",".zts", sep=""), header= FALSE, sep= "",
                   skip = 3, stringsAsFactors = FALSE, row.names=NULL)
  #print(df)
  #print(dim(df))
 # newdf <- df[,3:ncols]
  outputdf[1:nrows_przm,1:ncols_przm,Ite] <- abind(df[1:nrows_przm,1:ncols_przm], along=3)
  #print(outputdf)
  #print(dim(outputdf))
  ########################PWC outpput################################################################
  pwcdf <- read.csv(paste(newdir,"/","output_CAalmond_WirrigSTD_Custom_Parent_daily",".csv", sep=""), header= FALSE, sep= ",",
                    skip = 5, stringsAsFactors = FALSE, row.names=NULL)
  

  pwcoutdf[1:rows_pwc,1:cols_pwc,Ite] <- abind(pwcdf[1:rows_pwc,1:cols_pwc], along=3)
  

  ###########################################################################################
 #reading conversion factor from output################
  #con_fac <- scan((paste(newdir,"/","output_CAalmond_WirrigSTD_Custom_Parent",".txt", sep="")),skip=15,nlines=1,what="int")
  
  con_almond <- file(paste(newdir,"/","output_CAalmond_WirrigSTD_Custom_Parent",".txt", sep=""))
  #print(con)
  open(con_almond)
  con_fac_line <- read.table(con_almond,skip=15,nrow=1) #16-th line
  con_fac[Ite,]<-as.numeric(con_fac_line%>%select_if(is.numeric))
  print(con_fac)
  close(con_almond)
  ##############################################################################################
  setwd(cwd)
}

output <- data.frame(con_fac)
save(output, file = paste(pwcdir,"io/output.RData",sep = ""))
class(output)




