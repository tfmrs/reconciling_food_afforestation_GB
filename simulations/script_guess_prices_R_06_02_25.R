#clear
#format long
#########################################flip sign of change to minus if plus

#locked for emulation 28/07/25 as depends on r_inp_name_sim
#if (unlist(gregexpr("plus",r_inp_name_sim)) == -1) {
here_cs_chitin<-r_inp_cs_chitin
here_cs_PLJ<-r_inp_cs_PLJ
here_cs_feed<-r_inp_cs_feed
here_cs_salt<-r_inp_cs_salt
#} else {
#here_cs_chitin<-(-1)*r_inp_cs_chitin
#here_cs_PLJ<-(-1)*r_inp_cs_PLJ
#here_cs_feed<-(-1)*r_inp_cs_feed
#here_cs_salt<-(-1)*r_inp_cs_salt
#}



#########################################Inputs

setwd(gsub("'","",r_inp_input_directory))
externalfile_coeffs<-read.delim("coefficients_OF_constraints_(meat_pseudo_BEP1)_RAS_all_delta_Nix_2023_AFRASTECHV_29_10_24.txt",sep="#")
tab_coeffs<-externalfile_coeffs
vec_size_RAS<-0.03
tab_param_ene <- read.delim("Parameters_energy_AD_RAS_29_10_24.txt",sep="#")
RAS_CAPEX <- tab_param_ene$value[which(tab_param_ene$type=="RAS CAPEX")]
RAS_lifetime <- tab_param_ene$value[which(tab_param_ene$type=="RAS lifetime")]

#mat_wage_PAYE <- read.delim("wage_PAYE_03_04_24.txt",sep="#")
mat_wage_PAYE <- read.delim("wage_PAYE_06_02_25.txt",sep="#")


vec_VARCOS_RAS<-tab_coeffs$final_value[which(tab_coeffs$parameter=="Variable cost" & tab_coeffs$group=="RAS" & tab_coeffs$type=="RAS")]
vec_VARCOS_RAS_oplab<-tab_coeffs$final_value[which(tab_coeffs$parameter=="Variable cost" & tab_coeffs$group=="RAS" & tab_coeffs$type=="RAS_oplab")]
vec_VARCOS_RAS_mglab<-tab_coeffs$final_value[which(tab_coeffs$parameter=="Variable cost"  & tab_coeffs$group=="RAS" & tab_coeffs$type=="RAS_mglab")]

RAS_yield_meat<-6624
RAS_yield_chitin<-0.015*0.5*RAS_yield_meat

price_chitin<-12*(1+r_inp_cs_chitin)


#########################################BEP calculation
cost_adj_extra_sensitivity <- 26496 - 26496*(1+r_inp_cs_PLJ) + (794.88 + 26231.04) - (794.88 + 26231.04)*(1+r_inp_cs_feed) + 20581.34 - 20581.34*(1+r_inp_cs_salt)

#Pmeat <- 1/qmeat[(OPEX_ex_lab+ CAPEX_ann) + cost_lab(g)/g - pchitin.qchitin]
#02/01: converting to £/unit (only OPEX_ex_lab, am using division by 33
#(round 1/vec_size_RAS)
#here to make equal to Excel sheet GM_fun_step)
#inverting for subtracting BL values and adding non-BL values)

vec_VARCOS_RAS <- round(1/vec_size_RAS)*(155549.9129 + (-1)*cost_adj_extra_sensitivity)
OPEX_ex_lab <- (vec_VARCOS_RAS - vec_VARCOS_RAS_oplab - vec_VARCOS_RAS_mglab)/round(1/vec_size_RAS)
NPV_RAS <- ((1+r_inp_irate_out)^RAS_lifetime - 1)/(r_inp_irate_out*(1+r_inp_irate_out)^RAS_lifetime)
RAS_CAPEX_annuity_one_unit <- RAS_CAPEX/NPV_RAS


#labcost_RAS_step <- @(g) mean(mat_wage_PAYE.ratio_final)*12*1*(floor((g-1)/5)+1) + mean(mat_wage_PAYE.ratio_final)*12*(1.4)*(floor((g-1)/10)+1);

labcost_RAS_step <-function(g) {
return(mean(mat_wage_PAYE$ratio_final)*12*1*(floor((g-1)/5)+1) + mean(mat_wage_PAYE$ratio_final)*12*(1.4)*(floor((g-1)/10)+1))
}

labcost_RAS_step(1)

#tested, works, check for g <- 1 and g <- 6

#BEP <- 1/RAS_yield_meat*((OPEX_ex_lab+ RAS_CAPEX_annuity) + labcost_RAS_step(g)/g - price_chitin*RAS_yield_chitin)

OPEX_ex_lab
RAS_CAPEX_annuity_one_unit
BEP_1 <- 1/RAS_yield_meat*((OPEX_ex_lab+ RAS_CAPEX_annuity_one_unit) + labcost_RAS_step(1)/1 - price_chitin*RAS_yield_chitin)
BEP_2 <- 1/RAS_yield_meat*((OPEX_ex_lab+ RAS_CAPEX_annuity_one_unit) + labcost_RAS_step(2)/2 - price_chitin*RAS_yield_chitin)
BEP_3 <- 1/RAS_yield_meat*((OPEX_ex_lab+ RAS_CAPEX_annuity_one_unit) + labcost_RAS_step(3)/3 - price_chitin*RAS_yield_chitin)
BEP_4 <- 1/RAS_yield_meat*((OPEX_ex_lab+ RAS_CAPEX_annuity_one_unit) + labcost_RAS_step(4)/4 - price_chitin*RAS_yield_chitin)

##########################################################################################################################################

BEP_1
BEP_2
BEP_3
BEP_4
##Ok, checked, 02/01/25, 13:19
##03/01/25: replacing mean for min wage (after demand not crossed)
##03/01/25: using always the minus
cost_adj_extra_sensitivity_for_AVC <- 26496 - 26496*(1+here_cs_PLJ) + (794.88 + 26231.04) - (794.88 + 26231.04)*(1+here_cs_feed) + 20581.34 - 20581.34*(1+here_cs_salt)
vec_VARCOS_RAS_for_AVC <- round(1/vec_size_RAS)*(155549.9129 + (-1)*cost_adj_extra_sensitivity_for_AVC)
OPEX_ex_lab_for_AVC <- (vec_VARCOS_RAS_for_AVC - vec_VARCOS_RAS_oplab - vec_VARCOS_RAS_mglab)/round(1/vec_size_RAS)

AVC_10_units<-(OPEX_ex_lab_for_AVC*10 + labcost_RAS_step(10) * min(mat_wage_PAYE$ratio_final)/mean(mat_wage_PAYE$ratio_final) + RAS_CAPEX_annuity_one_unit*10)/(6624*10)

AVC_10_units_mean<-(OPEX_ex_lab_for_AVC*10 + labcost_RAS_step(10) + RAS_CAPEX_annuity_one_unit*10)/(6624*10)



#checking that wage is factorable
#g<-2
#mean(mat_wage_PAYE$ratio_final)*12*1*(floor((g-1)/5)+1) + mean(mat_wage_PAYE$ratio_final)*12*(1.4)*(floor((g-1)/10)+1)
#mean(mat_wage_PAYE$ratio_final)*(12*1*(floor((g-1)/5)+1) + 12*(1.4)*(floor((g-1)/10)+1))


