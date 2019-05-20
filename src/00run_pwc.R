#check to make sure required packages are installed
list.of.packages <- c("plyr", "dplyr", "reshape2", "ggplot2", "grid", "gridExtra", "sensitivity", "abind", 
                      "ppcor")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)>0) {install.packages(new.packages)}

#install and load library dependencies
#install.packages("magrittr")
#install.packages("sensitivity")
library(magrittr)
library(plyr)
library(reshape2)
library(ggplot2)
library(grid)
library(gridExtra)
library(sensitivity)
library(abind)
library(tools)
library(ppcor)
library(dplyr)
#echo environment
Sys.info()
Sys.info()[4]
.Platform
version


#set some default directories based on machine location
#Tom's mac air
if(Sys.info()[4]=="stp-air"){
  pwcdir <- "~/git/sinnathamby_pwc/"
}
#Tom's epa window
if(Sys.info()[4]=="DZ2626UTPURUCKE"){
  pwcdir <- "d:/git/sinnathamby_pwc/"
  # pwc,przm (without directory, the file needs to be in vpdir_exe above)
  pwc_filename <- "urban.PWC"
  przm_filename <- "PRZM5.inp"
}
#Sumathy's window
if(Sys.info()[4]=="DZ2626USSINNATH"){
  pwcdir <- "C:/Users/SSinnath/Research/Urban_Pesticide_Modeling/PWC/urban_pesticide/"
  # pwc,przm file (without directory, the file needs to be in vpdir_exe above)
  pwc_filename <- "urban.PWC"
  przm_filename <- "PRZM5.inp"
}
#Sumathy's desktop
if(Sys.info()[4]=="DESKTOP-7UFGA86"){
  pwcdir <- "C:/Users/Sumathy/sinnathamby_pwc/"
  # pwc,przm file (without directory, the file needs to be in vpdir_exe above)
  pwc_filename <- "urban.PWC"
  przm_filename <- "PRZM5.inp"
}
print(paste("Root directory location: ", pwcdir, sep=""))


#subdirectories
pwcdir_input <- paste(pwcdir, "input/", sep = "")
pwcdir_output <- paste(pwcdir, "output/", sep = "")
pwcdir_log <- paste(pwcdir, "log/", sep = "")
pwcdir_fig <- paste(pwcdir, "figures/", sep = "")
pwcdir_exe <- paste(pwcdir, "exe/", sep = "")
przmdir_exe <- paste(pwcdir, "exe/", sep = "")
vvwmdir_exe <- paste(pwcdir, "exe/", sep = "")
pwcdir_io <- paste(pwcdir, "io/", sep = "")
pwcdir_in_przm <- paste(pwcdir_input, "przm/", sep = "")
pwcdir_in_vvwm <- paste(pwcdir_input, "vvwm/", sep = "")
pwcdir_out_przm <- paste(pwcdir_output, "przm/", sep = "")
pwcdir_out_vvwm <- paste(pwcdir_output, "vvwm/", sep = "")
pwcdir_weather <- paste(pwcdir, "weather/", sep = "")
pwcdir_sobol <- paste(pwcdir, "sobol/", sep = "")


#pwc executable version
#pwc 1.59
pwc_binary<- "pwc159.exe"
pwcdir_executable <- paste(pwcdir_exe, pwc_binary, sep="")
przm_binary<- "PRZM5.exe"
przmdir_executable <- paste(przmdir_exe, przm_binary, sep="")
vvwm_binary<- "VVWM.exe"
vvwmdir_executable <- paste(vvwmdir_exe, vvwm_binary, sep="")
#number of simulations 

Nsims <- 50

#weather file
#can be .dvf or .wea
pwc_weather_used <- "22534_gridn.wea"
pwc_weather <- paste(pwcdir_weather, pwc_weather_used, sep="")

#simulation start and end
#must have mm/dd/yyyy format
simstart <- "01/01/2009"
simend <- "12/31/2014"

#run everything
# parameterize inputs
#source(paste(pwcdir,"src/01a_parameterization.R",sep = ""))
source(paste(pwcdir,"src/01b_lhs_parameterization.R",sep = ""))
#write_update_run_vvwm
source(paste(pwcdir,"src/01write_update_run_pwc.R",sep = ""))

#create input dataframe
#source(paste(pwcdir,"src/03write_input_dataframe.R",sep = ""))
# read text,csv files and save results into dataframe
source(paste(pwcdir,"src/04_write_ouput_into_df.R",sep = ""))

# load input and output objects into environment
source(paste(pwcdir,"src/05load_io.R",sep = ""))

# run sensitivity analysis on time daily arrays
source(paste(pwcdir,"src/06daily_sensitivity_analysis_linear.R",sep = ""))

#
source(paste(pwcdir,"src/06Max_sensitivity_analysis_linear.R",sep = ""))
# plot results
source(paste(pwcdir,"src/07sensitivity_analyses_graphics.R",sep = ""))
source(paste(pwcdir,"src/08pardistribution.R",sep = ""))
