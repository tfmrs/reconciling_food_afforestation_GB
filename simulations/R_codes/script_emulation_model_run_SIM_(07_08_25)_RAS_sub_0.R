#rm(list=ls())

pepmp <- function(param_vec_id,param_delta,param_alpha,param_irate,param_pchitin,param_pplj,param_pfeed,param_psalt,param_root_directory) {
##Start of function for emulation
start_time<<-Sys.time()
print(paste("The run's start time is ", start_time,sep=""))


#(0) Parameters
#P = d0* + d1*Qsourc
#Q = P/d1* - d0*/d1*
#d0 = -d0*/d1*
#d1 = 1/d1*
#(1) x_intercept = -d0*/d1*
#From (1): slope = 1/d1* = (-1)*x_intercept/d0*
#(2) y_intercept = d0* 

#Direct demand
x_intercept =  71228242.25182
y_intercept =   23.5610
dir_d0<-x_intercept
dir_d1<--x_intercept/y_intercept			
dir_d<-c(dir_d0,dir_d1)

#Inverse demand (needed for pseudo-EQ)
mat_P_d = as.matrix(rbind(0,y_intercept))
mat_X_d = as.matrix(rbind(c(1,x_intercept),c(1,0)))
d = solve(mat_X_d)%*% mat_P_d

#Supply
r_inp_delta_out<<-param_delta
r_inp_alpha_out<<-param_alpha 
r_inp_irate_out<<-param_irate
r_inp_d_SLR_RAS_out<<-1
r_inp_nOW_out<<-1
r_inp_disc_RAS_CAPEX_out<<-0
r_inp_type_sim<<-"'RAS_all_delta_SLQ_BL_lowres'"
r_inp_type_sim_mid<<-"'RAS_all_delta_set_aside_nocalconstraint_wq'"
#Prices (extra) [OBS: no change = 0, change = +0.1/-0.1]
##31/07/25: prices percent approach (to keep same upload data and "cs" notation)
#cs_x = (price_sens/price_base - 1)
r_inp_cs_chitin<<-(param_pchitin/12-1)
r_inp_cs_PLJ<<-(param_pplj/50-1)
r_inp_cs_feed<<-(param_pfeed/2.4-1)
r_inp_cs_salt<<-(param_psalt/0.984-1)
#new pol: RAS SUB
r_inp_ras_sub<<-0

r_inp_vec_id<<-param_vec_id

#reporter param vec
print(paste("vec_id=",r_inp_vec_id,"delta=",param_delta,"_alpha=",param_alpha,"_irate=",param_irate,"_pchitin=",param_pchitin,"_PLJ=",param_pplj,"_feed=",param_pfeed,"_salt=",param_psalt,sep=""))

######Directory
r_inp_input_directory<<-param_root_directory
r_inp_output_directory<<-paste("'",gsub("'","",r_inp_input_directory),gsub("'","",r_inp_type_sim),"_ras_sub_",r_inp_ras_sub,"_vid_",r_inp_vec_id,"/'",sep="")
dir.create(gsub("'","",r_inp_output_directory), showWarnings = TRUE, recursive = FALSE)
r_inp_wood_only_directory<<-paste("'",gsub("'","",r_inp_input_directory),"set_aside_only_gis_nocalconstraint_EWCO","_ras_sub_",0,"/'",sep="")



##############################STAGE 1: RAS-only interpolation##############################STAGE 1: RAS-only interpolation##############################STAGE 1: RAS-only interpolation##############################STAGE 1: RAS-only interpolation
##############################STAGE 1: RAS-only interpolation##############################STAGE 1: RAS-only interpolation##############################STAGE 1: RAS-only interpolation##############################STAGE 1: RAS-only interpolation
##############################STAGE 1: RAS-only interpolation##############################STAGE 1: RAS-only interpolation##############################STAGE 1: RAS-only interpolation##############################STAGE 1: RAS-only interpolation
print("flag_1_stage_1_start")

###Function 1: Run ML
mlrun<-function(input) {

# Tell the user
  message("Running the simulator")

#timing for file name
r_inp_timing<<-paste("'",gsub("[.]","p",gsub(":","_",gsub(" ","_",gsub("-","_",Sys.time())))),"'",sep="")

matlab_command <- paste("matlab -nosplash -noFigureWindows -r \" delta_out =",r_inp_delta_out,"; alpha_out =",r_inp_alpha_out,"; irate_out =",r_inp_irate_out,"; d_SLR_RAS_out =",r_inp_d_SLR_RAS_out,"; nOW_out =",r_inp_nOW_out,"; disc_RAS_CAPEX_out =",r_inp_disc_RAS_CAPEX_out,"; type_sim =",r_inp_type_sim,"; timing=",r_inp_timing,"; cs_chitin=",r_inp_cs_chitin,"; cs_PLJ=",r_inp_cs_PLJ,"; cs_feed=",r_inp_cs_feed,"; cs_salt=",r_inp_cs_salt,"; ras_sub=",r_inp_ras_sub,"; input_directory=",r_inp_input_directory, "; output_directory=",r_inp_output_directory, "; price_meat =", input," ;run('",gsub("'","",r_inp_input_directory),"pre_simulation_module_interpol_emulation.m'); exit\"",sep="")

system(matlab_command,intern = T)

while(file.exists(paste(gsub("'","",r_inp_output_directory),"ws_pre_",substring(gsub("'","",r_inp_type_sim),1,3),"_ras_sub_",r_inp_ras_sub,"_",round(input,4),"__",gsub("'","",r_inp_timing),".txt",sep=""))==F) {
#print("ML running")
}


###Need to wait before ML fully writes to the output file
Sys.sleep(1)
quantity_supply<<-read.delim(paste(gsub("'","",r_inp_output_directory),"ws_pre_",substring(gsub("'","",r_inp_type_sim),1,3),"_ras_sub_",r_inp_ras_sub,"_",round(input,4),"__",gsub("'","",r_inp_timing),".txt",sep=""),sep=",")$agg_quantity_meat
return(quantity_supply)
}

###Function 2: pseudo-price (updated 16/06/25)

equilibrium<-function(supply) {
rolleq<-NA
rollsupply<-NA
#%segment search
#%Find the slope of supply
for (kih in c(1:(nrow(supply)-1))) {
#kih = 1
##Avoiding crash due to vertical line slope calc.
if (supply[kih,2] != supply[kih+1,2]) {
    mat_P<-as.matrix(rbind(supply[kih,1], supply[kih+1,1]))
    mat_X<-as.matrix(rbind(c(1,supply[kih,2]), c(1,supply[kih+1,2])))
    s<-solve(mat_X) %*% mat_P

#Find the intersection for the specific slope
eq_q<-(d[1]-s[1])/(s[2]-d[2])
eq_p<-d[1] + d[2]*eq_q

#P = d(1) + d(2)*Q --> Q = -d(1)/d(2) + 1/d(2)*P
#P = s(1) + s(2)*Q --> Q = -s(1)/s(2) + 1/s(2)*P

#Check if intersection price is in the particular segment
d_in_seg<-0
if (eq_p >= supply[kih,1] & eq_p <= supply[kih+1,1]) {
d_in_seg<-1
}
rolleq<-rbind(rolleq, c(d_in_seg,eq_q,eq_p))
} else {
rolleq<-rbind(rolleq, c(0,NA,NA))
s<-rbind(NA,NA)
d_in_seg<-0
}
rollsupply<-rbind(rollsupply, c(d_in_seg,t(s)))
}
return(rolleq)
}


###From stackoverflow
permutations <-function(n) {
if(n==1) {
return(matrix(1))
} else {
sp <- permutations(n-1)
p<-nrow(sp)
A<-matrix(nrow=n*p,ncol=n)
for (i in 1:n) {
A[(i-1)*p+1:p,] <-cbind(i,sp+(sp>=i))
}
return(A)
}
}
#OBS: this function is redundant because order matters on it
#but not for us

#permres
permequilibrium<-function(supply,permstop) {
#should not accumulate previous eq points
rolleqperm<-NA
permres<-permutations(length(c(2:(nrow(supply)-1))))
permres<-permres+1
##i = one sequence/permutation (of supply points); j = a point
#for (i in 1:nrow(permres)) {
for (i in permstop) {
#i<-6
for (j in 1:(ncol(permres)-1)) {
    mat_P<-as.matrix(rbind(supply[permres[i,j],1], supply[permres[i,j+1],1]))
    mat_X<-as.matrix(rbind(c(1,supply[permres[i,j],2]), c(1,supply[permres[i,j+1],2])))
    s<-solve(mat_X) %*% mat_P

#Find the intersection for the specific slope
eq_q<-(d[1]-s[1])/(s[2]-d[2])
eq_p<-d[1] + d[2]*eq_q

#P = d(1) + d(2)*Q --> Q = -d(1)/d(2) + 1/d(2)*P
#P = s(1) + s(2)*Q --> Q = -s(1)/s(2) + 1/s(2)*P

#Check if intersection price is in the particular segment
d_in_seg<-0
if (eq_p >= supply[permres[i,j],1] & eq_p <= supply[permres[i,j+1],1]) {
d_in_seg<-1
}
rolleqperm<-rbind(rolleqperm, c(d_in_seg,eq_q,eq_p))
rollsupply<-rbind(rollsupply, c(d_in_seg,t(s)))
#close loop
}

}
return(rolleq)
}

####Algorithm 1: guess prices
#source("D:/Pesquisa/Pesquisa_2024/Sustainable_Prawn/script_guess_prices_R_02_01_25.R")
#source("D:/Pesquisa/Pesquisa_2024/Sustainable_Prawn/script_guess_prices_R_03_01_25.R")
#source("D:/Pesquisa/Pesquisa_2024/Sustainable_Prawn/script_guess_prices_(RASsubpol)_R_08_01_25.R")
source(paste(gsub("'","",r_inp_input_directory),"script_guess_prices_R_06_02_25.R",sep=""))

AVC_10_units
AVC_10_units_mean

print("flag_2_stage_1_guess_prices")

simulator_inputs <- matrix(c(BEP_1,AVC_10_units) , ncol = 1)
#af bug, 28/07, test full, remove from final
#simulator_inputs <- matrix(AVC_10_units, ncol = 1)
simulator_outputs <- matrix(sapply(simulator_inputs, mlrun), ncol = 1)
#?mapply

supply<-as.data.frame(cbind(simulator_inputs,simulator_outputs))

#s1<-read.delim(paste(gsub("'","",r_inp_output_directory),"ws_pre_RAS_ras_sub_0_20.0074__2025_07_28_12_29_23.txt",sep=""),sep=",")
#s2<-read.delim(paste(gsub("'","",r_inp_output_directory),"ws_pre_RAS_ras_sub_0_27.4734__2025_07_28_06_39_48.txt",sep=""),sep=",")
#s12<-rbind(s1,s2)
#supply<-subset(s12,select=c(price_meat,agg_quantity_meat))

colnames(supply)<-c("meat_price","quantity_supply")
supply<-supply[order(supply$meat_price),]
supply
##07/08 this is storing for further check by avoiding side-effects of "<<"
supply_store<<-supply


rolleq<-as.data.frame(equilibrium(supply))
pseudo_eq<-rolleq
colnames(pseudo_eq)<-c("d_in_seg","eq_q","eq_p")
pseudo_eq
pseudo_eq<-subset(pseudo_eq,d_in_seg==1,select=c(eq_p,eq_q))
colnames(pseudo_eq)<-c("meat_price","quantity_supply")
pseudo_eq



####Algorithm 2: interpolate
print("flag_3_stage_1_interpolation_start")
d_gp_crash<-0


stepcount<-1
error_metric<-10^6
#pseudo_eq_roll<-pseudo_eq
pseudo_eq_roll<-supply[2:3,]
while (error_metric >= 0.1) {
#while (stepcount < 17) {
#(1) Simulated quantity

##04/08/25
if (nrow(pseudo_eq) == 0) {
message("interpol crashed due to guess prices not leading to crossing point")
d_gp_crash<-1
break
}

quantity_sim<-mlrun(pseudo_eq$meat_price)

#(2) Error metric (if < 0.1, exit)
quantity_demand<-dir_d0 + dir_d1*pseudo_eq$meat_price
#error_metric <- abs(pseudo_eq$quantity_supply/quantity_sim-1)
error_metric <- abs(quantity_sim/quantity_demand-1)

#(3) Supply update
supply<-rbind(supply,c(pseudo_eq$meat_price,quantity_sim))
supply<-supply[order(supply$meat_price),]
##07/08 this is storing for further check by avoiding side-effects of "<<"
supply_store<<-supply


#(4) Pseudo price for next iteration
rolleq<-as.data.frame(equilibrium(supply))
pseudo_eq<-rolleq
colnames(pseudo_eq)<-c("d_in_seg","eq_q","eq_p")
pseudo_eq<-subset(pseudo_eq,d_in_seg==1,select=c(eq_p,eq_q))
colnames(pseudo_eq)<-c("meat_price","quantity_supply")
print(pseudo_eq)

###06/05/25, check if pseudo generated was explored yet
permstopit<-0
##while current pseudo is already explored, keep running across permutations
while (length(which(pseudo_eq_roll$meat_price == pseudo_eq$meat_price)) != 0) {
rolleq<-as.data.frame(permequilibrium(supply,permstopit))
pseudo_eq<-rolleq
colnames(pseudo_eq)<-c("d_in_seg","eq_q","eq_p")
pseudo_eq<-subset(pseudo_eq,d_in_seg==1,select=c(eq_p,eq_q))
colnames(pseudo_eq)<-c("meat_price","quantity_supply")
permstopit<-permstopit+1
}
stepcount<-stepcount+1
##06/06/25
pseudo_eq_roll<-rbind(pseudo_eq_roll,pseudo_eq)
##07/08 this is storing for further check by avoiding side-effects of "<<"
pseudo_eq_roll_store<<-pseudo_eq_roll
print(stepcount)
print(error_metric)
}

##End
#Plot Q x P diagram
dev.new(width=1920, height=1080)
tiff(paste(r_inp_type_sim,"_ras_sub_",r_inp_ras_sub,"_",gsub("-","_",gsub(":","_",gsub(" ","_",substring(Sys.time(),1,19)))),".tiff",sep=""), height=21, width=29.7, units="cm", res = 300,compression = 'lzw')
plot(supply[,2],supply[,1],type="l",ylim=c(0,y_intercept))
lines(dir_d[1]+dir_d[2]*seq(0,y_intercept,by=0.1),seq(0,y_intercept,by=0.1), col = "red")
points(supply[,2],supply[,1],pch=21)
#%plotting EQ
points(supply[nrow(supply),2], supply[nrow(supply),1],pch=21, col="black",cex=2.5)
dev.off()

###STOP
save(list=ls(),file=paste(gsub("'","",r_inp_output_directory),"ws_interpol_",gsub("'","",r_inp_type_sim),"_ras_sub_",gsub("'","",r_inp_ras_sub),"_",gsub("'","",r_inp_timing),".Rdata",sep=""))


##after error metric bug, 31/07/25
#quantity_supply<-mlrun(pseudo_eq$meat_price)

if (d_gp_crash == 0) {
##############################STAGE 2: RAS & wood (one-shot)##############################STAGE 2: RAS & wood (one-shot)##############################STAGE 2: RAS & wood (one-shot)##############################STAGE 2: RAS & wood (one-shot)
##############################STAGE 2: RAS & wood (one-shot)##############################STAGE 2: RAS & wood (one-shot)##############################STAGE 2: RAS & wood (one-shot)##############################STAGE 2: RAS & wood (one-shot)
##############################STAGE 2: RAS & wood (one-shot)##############################STAGE 2: RAS & wood (one-shot)##############################STAGE 2: RAS & wood (one-shot)##############################STAGE 2: RAS & wood (one-shot)
print("flag_4_stage_2_start")


########(1) Extract price, input to eng_sheet, gen price_coeffs_sheet
##OBS 06/08/25: added max(1,roll-1) for cases of convergence in the first pseudo
price_meat_EQ<-pseudo_eq_roll[max(1,(nrow(pseudo_eq_roll)-1)),]$meat_price
#Note 29/07/25: it is the penultimate price_meat_EQ, as after actual EQ sim ran, a new EQ price is 

#OBS: no need to change the coefficients_OF_constraints files as all relevant RAS quantities calculated from
#upload data


########(2) Pre-sim RAS & wood

###RAS-only reference for (i) cells opting out of wood. grant and (ii) unfunded cells
r_inp_ref_midfile<-paste("'ws_pre_",substring(gsub("'","",r_inp_type_sim),1,3),"_ras_sub_",r_inp_ras_sub,"_",round(price_meat_EQ,4),"__",gsub("'","",r_inp_timing),".mat'",sep="")

###This is the reference for opting-out of grant scheme
r_inp_rolling_aside<-list.files(gsub("'","",r_inp_wood_only_directory),pattern='set_aside_only_gis_nocalconstraint_EWCO')
r_inp_rolling_aside<-paste("'",r_inp_rolling_aside,"'",sep="")

#For test
r_inp_rolling_aside<-list.files(gsub("'","",r_inp_wood_only_directory),pattern='1ha')
r_inp_rolling_aside<-paste("'",r_inp_rolling_aside,"'",sep="")

mlrun_mid<-function(input) {

# Tell the user
  message("Running the simulator")

#timing for file name
r_inp_timing_mid<<-paste("'",gsub("[.]","p",gsub(":","_",gsub(" ","_",gsub("-","_",Sys.time())))),"'",sep="")


if (regexpr("RAS",r_inp_type_sim) == -1) {
#(1) creating rolling_out_sim_RAS/aside from ref_midfile
#matlab_command <- paste("matlab -nosplash -noFigureWindows -r \" delta_out =",r_inp_delta_out,"; alpha_out =",r_inp_alpha_out,"; irate_out =",r_inp_irate_out,"; d_SLR_RAS_out =",r_inp_d_SLR_RAS_out,"; nOW_out =",r_inp_nOW_out,"; disc_RAS_CAPEX_out =",r_inp_disc_RAS_CAPEX_out,"; type_sim =",r_inp_type_sim_mid,"; timing=",r_inp_timing_mid,"; cs_chitin=",r_inp_cs_chitin,"; cs_PLJ=",r_inp_cs_PLJ,"; cs_feed=",r_inp_cs_feed,"; cs_salt=",r_inp_cs_salt,"; ras_sub=",r_inp_ras_sub,"; price_meat =", price_meat_EQ,"; rolling_aside =", r_inp_rolling_aside, "; input_directory =", r_inp_input_directory, "; output_directory =", r_inp_output_directory," ;run('",gsub("'","",r_inp_output_directory),"mid_sim_emulation_23_07_25.m'); exit\"",sep="")
#system(matlab_command,intern = T)

#Do nothing as wood-only already has wood policy.


} else {
#(1) creating rolling_out_sim_RAS/aside from ref_midfile
matlab_command <- paste("matlab -nosplash -noFigureWindows -r \" source_ml_file =", r_inp_rolling_aside, "; type_ml_file = 'wood_only' ; ras_sub = ",r_inp_ras_sub, ";r_inp_input_directory = ",r_inp_input_directory, ";wood_only_directory = ",r_inp_wood_only_directory, ";output_directory = ",r_inp_output_directory,";run('",gsub("'","",r_inp_input_directory),"rolling_to_ASCII_emulation_24_07_25.m'); exit\"",sep="")
system(matlab_command,intern = T)

#(2) running the mid-sim simulation (with RAS)
matlab_command <- paste("matlab -nosplash -noFigureWindows -r \" source_ml_file =", r_inp_ref_midfile, "; type_ml_file = 'RAS_only' ; ras_sub = ",r_inp_ras_sub, ";r_inp_input_directory = ",r_inp_input_directory, ";output_directory = ",r_inp_output_directory, ";run('",gsub("'","",r_inp_input_directory),"rolling_to_ASCII_emulation_24_07_25.m'); exit\"",sep="")
system(matlab_command,intern = T)

matlab_command <- paste("matlab -nosplash -noFigureWindows -r \" delta_out =",r_inp_delta_out,"; alpha_out =",r_inp_alpha_out,"; irate_out =",r_inp_irate_out,"; d_SLR_RAS_out =",r_inp_d_SLR_RAS_out,"; nOW_out =",r_inp_nOW_out,"; disc_RAS_CAPEX_out =",r_inp_disc_RAS_CAPEX_out,"; type_sim =",r_inp_type_sim_mid,"; timing=",r_inp_timing_mid,"; cs_chitin=",r_inp_cs_chitin,"; cs_PLJ=",r_inp_cs_PLJ,"; cs_feed=",r_inp_cs_feed,"; cs_salt=",r_inp_cs_salt,"; ras_sub=",r_inp_ras_sub,"; price_meat =", price_meat_EQ,"; rolling_aside =", r_inp_rolling_aside,"; rolling_RAS_only =", r_inp_ref_midfile, "; input_directory =",r_inp_input_directory,"; output_directory =",r_inp_output_directory," ;run('",gsub("'","",r_inp_input_directory),"mid_sim_emulation_23_07_25.m'); exit\"",sep="")
system(matlab_command,intern = T)

while(file.exists(paste(gsub("'","",r_inp_output_directory),"out_mid_sim_23_07_25_",substring(gsub("'","",r_inp_type_sim),1,3),"_ras_sub_",r_inp_ras_sub,"__",gsub("'","",r_inp_timing_mid),".txt",sep=""))==F) {
#print("ML running")
}
###Need to wait before ML fully writes to the output file
Sys.sleep(1)
quantity_supply<<-read.delim(paste(gsub("'","",r_inp_output_directory),"out_mid_sim_23_07_25_",substring(gsub("'","",r_inp_type_sim),1,3),"_ras_sub_",r_inp_ras_sub,"__",gsub("'","",r_inp_timing_mid),".txt",sep=""),sep=",")$tree_area_tot
return(quantity_supply)
}

}


mlrun_mid(price_meat_EQ)
r_inp_midfile<-paste("'","ws_mid_",substring(gsub("'","",r_inp_type_sim_mid),1,3),"_ras_sub_",r_inp_ras_sub,"__",gsub("'","",r_inp_timing_mid),"_23_07_25.mat'",sep="")

#for test
#r_inp_midfile<-"'RAS_aside_woodquad_2grants_(EQ)_3_countries_30_06_25_TU0.mat'"
#r_inp_ref_midfile<-"'workspace_wageREP_RAS_lowres_default_ras_sub_0_2025_06_21_03_03_14_16_06_25.mat'"

r_inp_timing_mid

##############################STAGE 3: post-simulation (gov. side)##############################STAGE 3: post-simulation (gov. side)##############################STAGE 3: post-simulation (gov. side)##############################STAGE 3: post-simulation (gov. side)
##############################STAGE 3: post-simulation (gov. side)##############################STAGE 3: post-simulation (gov. side)##############################STAGE 3: post-simulation (gov. side)##############################STAGE 3: post-simulation (gov. side)
##############################STAGE 3: post-simulation (gov. side)##############################STAGE 3: post-simulation (gov. side)##############################STAGE 3: post-simulation (gov. side)##############################STAGE 3: post-simulation (gov. side)
print("flag_5_stage_3_start")

###Binary vector with funded cells
r_inp_out_postsim_out1<-paste("'gov_2050_post_",substring(gsub("'","",r_inp_type_sim),1,3),"_ras_sub_",r_inp_ras_sub,"_",substring(r_inp_timing_mid,7,11),".txt'",sep="")

r_inp_out_postsim_out2<-paste("'",gsub("'","",r_inp_output_directory),"ws_post_",substring(gsub("'","",r_inp_type_sim_mid),1,3),"_ras_sub_",r_inp_ras_sub,"_",gsub("'","",r_inp_timing_mid),".mat'",sep="")
r_inp_out_postsim_out2

#For test
#r_inp_out_postsim_out2<-paste("'",gsub("'","",r_inp_output_directory),"ws_post_",substring(gsub("'","",r_inp_type_sim_mid),1,3),"_ras_sub_",r_inp_ras_sub,"_","2025_06_21_03_03_14",".mat'",sep="")

r_inp_out_postsim_out2

matlab_command <- paste("matlab -nosplash -noFigureWindows -r \" midfile =",r_inp_midfile,"; postsim_out =",r_inp_out_postsim_out1,"; ref_midfile =",r_inp_ref_midfile,"; input_directory =",r_inp_input_directory,"; output_directory =",r_inp_output_directory,"; type_sim =",r_inp_type_sim_mid,"; ras_sub =",r_inp_ras_sub,"; timing=",r_inp_timing_mid,";run('",gsub("'","",r_inp_input_directory),"post_sim_emulation_23_07_25.m'); exit\"",sep="")

system(matlab_command,intern = T)

while(file.exists(gsub("'","",r_inp_out_postsim_out2))==F) {
}



#########Analysis
print("flag_6_analysis")

matlab_command <- paste("matlab -nosplash -noFigureWindows -r \" type_sim =",r_inp_type_sim,"; ras_sub =",r_inp_ras_sub,"; postfile =",r_inp_out_postsim_out2, "; input_directory =",r_inp_input_directory,"; output_directory =",r_inp_output_directory,"; timing =",r_inp_timing_mid,";run('",gsub("'","",r_inp_input_directory),"analysis_module_EMULATION_clean.m'); exit\"",sep="")

system(matlab_command,intern = T)


save(list=ls(),file=paste(gsub("'","",r_inp_output_directory),"Rdata_SIM_RAS_sub_0_",gsub("'","",r_inp_timing_mid),".Rdata",sep=""))

###Showing in R the outputs
end_time<<-Sys.time()

obj_output<-cbind(as.numeric(end_time - start_time),read.delim(paste(gsub("'","",r_inp_output_directory),"outputs_emulation_",gsub("'","",r_inp_type_sim_mid),"_ras_sub_",r_inp_ras_sub,"_",r_inp_timing_mid,".txt",sep=""),sep=",",header=F))
colnames(obj_output)<-c("time","prawn_meat_price","viability_rate","RAS_meat_production","cal_AL","protein_AL","carbon_agri_total","carbon_prawn_total","RAS_sub_total","index_3_carbon_effect","index_4_externality_effect")

print(obj_output)

#write running time
write.table(end_time-start_time,file=paste(gsub("'","",r_inp_output_directory),"total_running_time_",gsub("'","",r_inp_type_sim),"_ras_sub_",gsub("'","",r_inp_ras_sub),"_",gsub("'","",r_inp_timing),".txt",sep=""))

##End of d_gp_crash == 0
}

##End of function for emulation
}






