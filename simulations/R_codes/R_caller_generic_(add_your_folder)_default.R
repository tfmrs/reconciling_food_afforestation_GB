#Session 1
rm(list=ls())
###Scenario: sub = zero
source("[your path here]/simulations/R_codes/script_emulation_model_run_SIM_(07_08_25)_RAS_sub_0.R")
#Note: in the previous line, change the last third digit, "0", to "0.5", "1", "1.5" or "2" depending
#on your desired subsidy level 

data<-read.delim("[your path here]/simulations/param_default_delta_revised_after_emulation_09_09_25.txt",sep="#")
names(data)

##This is the root folder where the simulations folder is in your machine
#It is also where folders with outputs of each scenario ran will be created
data$root_directory<-"[your path here]/simulations/"

#This line runs the simulation
pepmp(0,data$delta,data$alpha,data$irate,data$pchitin,data$pplj,data$pfeed,data$psalt,data$root_directory)
