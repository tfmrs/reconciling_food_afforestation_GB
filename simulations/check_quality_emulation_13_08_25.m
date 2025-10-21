
%path to files
%path = 'D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Emulation_2025\outputs\post_sim_files\'
path = 'F:\Emulation_2025\single_folder\'

%general dump
cd(path)
listofsims = dir('*.mat*')
listofsims = struct2table(listofsims)
listofsims = listofsims(:,1)


output_analysis = []
listerror = []

for jj = 1:height(listofsims)
%    clear rolling_tab rolling_out_tab rolling_out_sim_tab
    clearvars -except jj path listofsims output_analysis listerror
        %        listofsims=readtable("listofsims.txt")

        load(string(table2array(listofsims(jj,:))))

%%%%%Params
i_rate = 0.04
T_RAS = 10
NPV_RAS = ((1+i_rate)^T_RAS - 1)/(i_rate*(1+i_rate)^T_RAS)
%Indicator 1 (sim-inespecific): minimum number of RAS units making AD
%feasible (OBS: NPV_AD = NPV_RAS)
%minimum_lb_RAS_units_for_AD = (AD_CAPEX/NPV_RAS + AD_OPEX - AD_SEG_tariff*AD_output_elec)/(RAS_elec_consumption*(elec_retail_price - AD_SEG_tariff))
%RAS_CAPEX_annuity = RAS_CAPEX/NPV_RAS
input_directory = 'D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Emulation_2025\simulations\'
        
%        path = pathdurable
         %01/05, introducing rolling, rolling_out
          load(strcat(input_directory,"workspace_rolling_rolling_out_calibration_woodquad_2woodgrants_17_06_25.mat"))

%         clear RAS_CAPEX_annuity
         RAS_CAPEX_annuity = RAS_CAPEX/NPV_RAS
%HP
%         cd 'G:\LEEP\Sustainable_Prawn\'
%cd 'D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Data\' 
         %%%%13/03 kcal fix
try
         vec_GM_RAS_store = vec_GM_RAS   
catch
        "no vec_GM_RAS"
end
%        cd 'D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Data\sim_PMP_EE_woodquad_2grants\'

        %prioupdate
        display(jj)
        rolling_tab = array2table(rolling)
        height(rolling_tab)
        rolling_out_tab = array2table(rolling_out)
        height(rolling_out_tab)
        
        rolling_tab.Properties.VariableNames = ["i" "d_cropless" "maxerror_crop" "maxerror_forage" "maxerror_animal" "maxerror_tree" "bind_const"]
        rolling_out_tab.Properties.VariableNames = ["i" [crops(1:3)' "fodder" crops(5:12)'] forages' trees' animals' "GM_BL" "lambda_land_target" "lambda_labour_target" "lambda_water_target" "lambda_land_LP" "lambda_labour_LP" "lambda_water_LP"]


        rolling_tab.noerror_pix = repelem(0,height(rolling_tab))'
        rolling_tab.noerror_pix(find((rolling_tab.d_cropless ==0 & (rolling_tab.maxerror_crop<10^-5 & rolling_tab.maxerror_forage<10^-5 & rolling_tab.maxerror_animal<10^-5 & (rolling_tab.maxerror_tree<10^-5 | isnan(rolling_tab.maxerror_tree)==1)))|(rolling_tab.d_cropless ==1 & (isnan(rolling_tab.maxerror_crop) == 1 & rolling_tab.maxerror_forage<10^-5 & rolling_tab.maxerror_animal<10^-5 & (rolling_tab.maxerror_tree<10^-5 | isnan(rolling_tab.maxerror_tree)==1))))) = 1
        %tabulate(rolling_tab.noerror_pix)
%        rolling_tab.Properties.VariableNames
        rolling_tab2 = rolling_tab(:,["i","noerror_pix"])

        rolling_out_tab = join(rolling_out_tab,rolling_tab2,"Keys","i")       
        rolling_tab = rolling_tab(find(rolling_tab.noerror_pix == 1),:)
        rolling_out_tab = rolling_out_tab(find(rolling_out_tab.noerror_pix == 1),:)
        
        %%%%1.b, rolling_out_sim_RAS
        
        rolling_out_sim_tab = array2table(rolling_out_sim_RAS)
   %Attention: empty = 1 
   switch type_sim 
       case {"RAS_all_delta", "RAS_all_delta_SLQ_BL", "RAS_all_delta_SLQ_BL_risebound", "RAS_all_delta_SLQ_BL_lowres", "RAS_subsidy_fixed_unit", "RAS_subsidy_fixed_unit_two"}
                %orig: rolling_out_sim_RAS_by_unit = [rolling_out_sim_RAS_by_unit ; [i g sol_sim.area_crop' sol_sim.area_forage' sollives' GM_gain_RAS_net (fval_target - fval_sim) (area_RAS*vec_GM_RAS) fval_sim obj_fun_sim_val share_land share_labour area_RAS d_one_unit_unfeasible]]
%                rolling_out_sim_tab.Properties.VariableNames = ["i" "best_RAS_units" [crops(1:3)' "fodder" crops(5:12)'] forages' animals' "GM_gain_RAS_net" "GM_agr_change" "GM_RAS" "fval_sim" "obj_fun_sim_val" "share_land_RAS" "share_labour_RAS" "area_RAS" "d_one_unit_unfeasible"]
                rolling_out_sim_tab.Properties.VariableNames = ["i" "best_RAS_units" [crops(1:3)' "fodder" crops(5:12)'] forages' trees' animals' "GM_gain_RAS_net" "GM_agr_change" "GM_RAS" "fval_sim" "obj_fun_sim_val" "share_land_RAS" "share_labour_RAS" "share_water_RAS" "area_RAS" "d_none_or_one_unit_unfeasible"]

%After BEP prices, 19/04/24
    simnamevec = strcat(string(isempty(strfind(string(string(table2cell(listofsims(jj,:)))),"meat"))),"_",string(isempty(strfind(string(string(table2cell(listofsims(jj,:)))),"chitin"))))     
              switch simnamevec
                  case "true_true" 
                       sim_name = strcat(type_sim,"_double_REF")
                       if string(isempty(strfind(string(string(table2cell(listofsims(jj,:)))),"risebound"))) == "false"
                        sim_name = strcat(type_sim,extractBetween(string(table2array(listofsims(jj,:))),"risebound","_at"))
                       end 
                       case "false_true" 
%                       sim_name = strcat(type_sim,"_meat_BEP")
                       sim_name = strcat(type_sim,"_meat",extractBetween(string(table2array(listofsims(jj,:))),"meat",")"))
                  case "true_false"
%                       sim_name = strcat(type_sim,"_chitin_BEP")
                       sim_name = strcat(type_sim,"_chitin",extractBetween(string(table2array(listofsims(jj,:))),"chitin",")"))
              end
                if (type_sim == "RAS_subsidy_fixed_unit" | type_sim == "RAS_subsidy_fixed_unit_two")
                    switch ras_sub 
                        case 0.5
                            sim_name = strcat(sim_name,"_sub_half") 
                        case 1
                            sim_name = strcat(sim_name,"_sub_one") 
                        case 1.5
                            sim_name = strcat(sim_name,"_sub_onehalf") 
                        case 2
                            sim_name = strcat(sim_name,"_sub_two") 
                    end
               end
                 if contains(string(table2array(listofsims(jj,:))),"IR002")==1
                                sim_name = strcat(type_sim,"_IR002")
               
                end
              case {"set_aside_only","set_aside_only_gis","set_aside_only_gis_nocalconstraint","set_aside_only_gis_nocalconstraint_EWCO"}
                %orig: rolling_out_sim_aside = [rolling_out_sim_aside ; [i sol_sim.area_crop' sol_sim.area_forage' sollives' GM_gain_aside_net fval_sim obj_fun_sim_val GM_agric_no_aside sub_aside area_set_aside_sim kcal_sim kcal_BL share_land_set_aside share_labour_set_aside]]
                rolling_out_sim_tab = array2table(rolling_out_sim_aside)
                rolling_out_sim_tab.Properties.VariableNames = ["i" [crops(1:3)' "fodder" crops(5:12)'] forages' trees' animals' "GM_gain_aside_net" "fval_sim" "obj_fun_sim_val" "GM_agric_no_aside" "sub_aside" "kcal_sim" "kcal_BL" "share_land_set_aside" "share_labour_set_aside" "share_water_set_aside"]
%G2050 budget, 26/06; 25/05/2025 (removed cell2mat enveloping strfind, as a number was showing up)
                if isempty(cell2mat(strfind(table2array(listofsims(jj,:)),"G2050"))) == 1
                    sim_name = strcat(type_sim,"_TU_",string(topup_set_aside))
                else
                    sim_name = strcat(type_sim,"_TU_",string(topup_set_aside),"_G2050")
                end
       case {"RAS_&_AD", "RAS_&_AD_heat", "RAS_&_AD_heat_zero"} 
                %orig: rolling_out_sim_RAS = [rolling_out_sim_RAS ; [i best_option_g best_option_LU best_option_name best_option_value option_val_list_tab.Option_1_NCF(1) option_val_list_tab.Option_2_NCF(1) option_val_list_tab.Option_3_NCF(1) option_val_list_tab.Option_4_NCF(1) share_land share_labour]]
                rolling_out_sim_tab.Properties.VariableNames = ["i" "best_RAS_units" [crops(1:3)' "fodder" crops(5:12)'] forages' animals' "best_option_name" "best_option_value" "Option_1_NCF" "Option_2_NCF" "Option_3_NCF" "Option_4_NCF" "share_land_RAS" "share_labour_RAS" "share_water_RAS"]
   %             sim_name = type_sim
                simnamevec = strcat(string(isempty(strfind(string(string(table2cell(listofsims(jj,:)))),"meat"))),"_",string(isempty(strfind(string(string(table2cell(listofsims(jj,:)))),"chitin"))))     
                          switch simnamevec
                              case "true_true" 
                                   sim_name = strcat(type_sim,"_double_REF")
                              case "false_true" 
                                   sim_name = strcat(type_sim,"_meat",extractBetween(string(table2array(listofsims(jj,:))),"meat",")"))
                              case "true_false"
                                   sim_name = strcat(type_sim,"_chitin",extractBetween(string(table2array(listofsims(jj,:))),"chitin",")"))
                          end
                
                %19/03, take off after
       case {"RAS_all_delta_set_aside","RAS_all_delta_set_aside_nocalconstraint", "RAS_all_delta_set_aside_nocalconstraint_v_irate","RAS_all_delta_set_aside_nocalconstraint_irate_2p", "RAS_aside_nocalconst_sub_fix_unit", "RAS_aside_nocalconst_sub_fix_unit_two","RAS_all_delta_set_aside_nocalconstraint_wq","RAS_aside_nocalconst_sub_fix_unit_two_wq"}
                %orig: rolling_out_sim_RAS_by_unit = [rolling_out_sim_RAS_by_unit ; [i g sol_sim.area_crop' sol_sim.area_forage' sollives' GM_gain_RAS_net (fval_target - fval_sim) (area_RAS*vec_GM_RAS) fval_sim obj_fun_sim_val share_land_RAS share_labour_RAS area_RAS area_set_aside_sim kcal_sim kcal_BL share_land_set_aside share_labour_set_aside share_kcal_RAS d_one_unit_unfeasible]]
                rolling_out_sim_tab.Properties.VariableNames = ["i" "best_RAS_units" [crops(1:3)' "fodder" crops(5:12)'] forages' trees' animals' "GM_gain_RAS_net" "GM_agr_change" "GM_RAS" "fval_sim" "obj_fun_sim_val" "share_land_RAS" "share_labour_RAS" "share_water_RAS" "area_RAS" "kcal_sim" "kcal_BL" "share_land_set_aside" "share_labour_set_aside" "share_water_set_aside" "share_kcal_RAS" "sub_aside" "d_one_unit_unfeasible"]
                %sim_name = strcat(type_sim,"_TU_",string(topup_set_aside))
                sim_name = type_sim
             %G2050 budget, 26/06
                if isempty(cell2mat(strfind(table2array(listofsims(jj,:)),"G2050"))) ~=1
%                                sim_name = strcat(type_sim,"_TU_",string(topup_set_aside),"_G2050")
                                sim_name = strcat(type_sim,"_G2050")
                    if isempty(cell2mat(strfind(table2array(listofsims(jj,:)),"Rex"))) ~=1
                                    sim_name = strcat(type_sim,string(topup_set_aside),"_G2050_Rex")
                    end

                end
%big name issue 12/07/24

%                if type_sim == "RAS_all_delta_set_aside_nocalconstraint_v_irate"
%                                sim_name = strcat("RAS_aside_ncalc_ir_TU_",string(topup_set_aside),"_G2050_Rex")
%                end

%                if type_sim == "RAS_all_delta_set_aside_nocalconstraint_irate_2p"
%                                sim_name = strcat("RAS_aside_ncalc_ir_TU_",string(topup_set_aside),"_G2050_Rex")
%                end

                if (contains(string(table2array(listofsims(jj,:))),"IR002")==1 & contains(string(table2array(listofsims(jj,:))),"G2050")==1)
                                sim_name = strcat(type_sim,"_IR002_G2050")
                end


                if string(table2array(listofsims(jj,:))) == "workspace_RAS_all_delta_set_aside_nocalconstraint_TU_0_update_budget_prio_G2050_alpha10%_Rex_14_01_24"
                                sim_name = strcat("RAS_aside_ncalc_alpha_TU_",string(topup_set_aside),"_G2050_Rex")
                end
%                if string(table2array(listofsims(jj,:))) == "workspace_RAS_all_delta_set_aside_(meat_6th_pseudo_EQ)_30_07_24.mat"
%                    rolling_out_sim_tab = join(rolling_out_sim_tab_ref,rolling_out_sim_tab,"Keys", "i")
%                end
%16/01/25
                if (type_sim == "RAS_aside_nocalconst_sub_fix_unit" | type_sim == "RAS_aside_nocalconst_sub_fix_unit_two_wq")
                    switch ras_sub 
                        case 0.5
                            sim_name = strcat(sim_name,"_sub_half") 
                        case 1
                            sim_name = strcat(sim_name,"_sub_one") 
                        case 1.5
                            sim_name = strcat(sim_name,"_sub_onehalf") 
                        case 2
                            sim_name = strcat(sim_name,"_sub_two") 
                    end
                end



       case {"RAS_&_AD_set_aside", "RAS_&_AD_set_aside_heat","RAS_&_AD_set_aside_nocalconstraint"}
                %orig: rolling_out_sim_RAS = [rolling_out_sim_RAS ; [i best_option_g best_option_LU best_option_name best_option_value option_val_list_tab.Option_1_NCF(1) option_val_list_tab.Option_2_NCF(1) option_val_list_tab.Option_3_NCF(1) option_val_list_tab.Option_4_NCF(1) share_land_RAS share_labour_RAS area_set_aside_sim kcal_BL share_land_set_aside share_labour_set_aside share_kcal_RAS]]
                %OBS: kcal_sim eliminated as must equal kcal_BL since it is an
                %equality constraint (the two were in the previous merely for
                %checking)
                rolling_out_sim_tab.Properties.VariableNames = ["i" "best_RAS_units" [crops(1:3)' "fodder" crops(5:12)'] forages' animals' "best_option_name" "best_option_value" "Option_1_NCF" "Option_2_NCF" "Option_3_NCF" "Option_4_NCF" "share_land_RAS" "share_labour_RAS" "share_water_RAS" "area_set_aside_sim" "kcal_BL" "share_land_aside" "share_labour_aside" "share_water_aside" "share_kcal_RAS"]
                sim_name = strcat(type_sim,"_TU_",string(topup_set_aside))
%G2050 budget, 26/06
                if isempty(cell2mat(strfind(table2array(listofsims(jj,:)),"G2050"))) ~=1
                                sim_name = strcat(type_sim,"_TU_",string(topup_set_aside),"_G2050")
                end
            end

            %%%RETTT
    
 %%%Output-emulation 1
 if (contains(sim_name,"RAS") == 1)
        prawn_meat_price = price_meat
%%%Output-emulation 2
        viability_rate = length(find(rolling_out_sim_tab.best_RAS_units > 0)) / height(rolling_out_sim_tab)
 else
     prawn_meat_price = 0
     viability_rate = 0
 end


%%%%Protein data, 04/07/25
%cd 'D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn'
%protein_upload_04_07_25
%%18/07: make sure all simulations calcs based on updated cal/prot

%table
        LU_start_pos = find(rolling_out_sim_tab.Properties.VariableNames =="Barley")
        LU_med_pos = find(rolling_out_sim_tab.Properties.VariableNames =="Wheat")
        LU_end_pos = find(rolling_out_sim_tab.Properties.VariableNames =="Rough grazing")
        HE_end_pos = find(rolling_out_sim_tab.Properties.VariableNames =="Animal: Sheep")
        GM_sim_pos = find(rolling_out_sim_tab.Properties.VariableNames =="fval_sim" | rolling_out_sim_tab.Properties.VariableNames =="best_option_value")
        RAS_units = sum(table2array(rolling_out_sim_tab(:,find(rolling_out_sim_tab.Properties.VariableNames =="best_RAS_units"))))
        if isempty(RAS_units) == 1
                    RAS_units = 0
                end
%        sim_monitor = [(ones(1,height(noerror_pix))*rolling_out_ne(:,2:20))' (ones(1,height(noerror_pix))*rolling_out_sim_RAS_ne(:,[LU_start_pos:LU_end_pos,GM_sim_pos]))']

       
        %10/02/25, do not do as below, it is not compatible with postfix
        %        sim_monitor = [table2array([sum(area_observed_crop(rolling_tab.i,:),1) sum(area_observed_forage(rolling_tab.i,:),1) sum(head_observed(rolling_tab.i,:),1) sum(rolling_out_tab(:,20),'all')])' (table2array(sum(rolling_out_sim_tab(:,[LU_start_pos:HE_end_pos,GM_sim_pos]),'omitnan')))']

%18/06/25: only created, all sims
            wood_AL = sum(rolling_out_sim_tab.Broadleaved + rolling_out_sim_tab.Conifer,"omitnan") - sum(area_observed_tree.broadleaved(rolling_tab.i) + area_observed_tree.conifer(rolling_tab.i),"omitnan")

        %Aggregates: (prod, wood, cal, sub)
        if (type_sim == "set_aside_only" | type_sim == "set_aside_only_nocalconstraint" | type_sim == "RAS_all_delta_set_aside" | type_sim == "RAS_all_delta_set_aside_nocalconstraint" | type_sim == "RAS_&_AD_set_aside" | type_sim == "set_aside_only_gis" | type_sim == "RAS_&_AD_set_aside_nocalconstraint" | type_sim == "RAS_all_delta_set_aside_nocalconstraint_v_irate" | type_sim == "set_aside_only_nocalconstraint_Eng" | type_sim == "set_aside_only_gis_nocalconstraint" | type_sim == "RAS_all_delta_set_aside_nocalconstraint_irate_2p" | type_sim == "RAS_aside_nocalconst_sub_fix_unit" | type_sim == "RAS_aside_nocalconst_sub_fix_unit_two" | type_sim == "set_aside_only_gis_nocalconstraint_EWCO" | type_sim == "RAS_all_delta_set_aside_nocalconstraint_wq" | type_sim == "RAS_aside_nocalconst_sub_fix_unit_two_wq")

            size(table2array(sum(rolling_out_sim_tab(:,[LU_start_pos:HE_end_pos,GM_sim_pos]),'omitnan')))
            size([sum(area_observed_crop,1) sum(area_observed_forage,1) sum(rolling_out_tab(:,21),'all')])

            if (type_sim ~= "set_aside_only_gis")
%                sub_AL = sum((400 + EMcost)*rolling_out_sim_tab.area_set_aside_sim)
%                sub_AL_bro = sum((500 + EMcost_bro)*rolling_out_sim_tab.Broadleaved,"omitnan")
 %               sub_AL_con = sum((500 + EMcost_con)*rolling_out_sim_tab.Conifer,"omitnan")
%                sub_AL = sub_AL_bro + sub_AL_con
                sub_AL = sum(rolling_out_sim_tab.sub_aside)
            else
%RET Here and adapt to the new GIS-based sim (19/05/25)
                sub_AL_bro = sum((tab_ewco_ac.value(rolling_out_sim_tab.i) + EMcost_bro).*rolling_out_sim_tab.Broadleaved,"omitnan")
                sub_AL_con = sum((tab_ewco_ac.value(rolling_out_sim_tab.i) + EMcost_con).*rolling_out_sim_tab.Conifer,"omitnan")
                sub_AL = sub_AL_bro + sub_AL_con
            end
        else
%delete
            size(table2array(sum(rolling_out_sim_tab(:,[LU_start_pos:HE_end_pos,GM_sim_pos]),'omitnan')))
            size([sum(area_observed_crop,1) sum(area_observed_forage,1) sum(rolling_out_tab(:,20),'all')])
%            wood_AL = 0
            sub_AL = 0
        end
%calories


    %%%Output-emulation 3
    RAS_meat_production = RAS_units * 6624

%%%14/01/25, calculation of RAS subsidy
        RAS_sub_total = 0      
   if (type_sim == "RAS_subsidy_fixed_unit" | type_sim == "RAS_aside_nocalconst_sub_fix_unit" | type_sim == "RAS_aside_nocalconst_sub_fix_unit_two"| type_sim == "RAS_all_delta_set_aside_nocalconstraint_irate_2p" | type_sim == "RAS_subsidy_fixed_unit_two" | type_sim == "RAS_aside_nocalconst_sub_fix_unit_two_wq" | (type_sim == "RAS_all_delta_set_aside_nocalconstraint_wq" & contains(sim_name,"IR002") == 1))
        if contains(sim_name,"IR002") == 0
            if ras_sub == 2
            RAS_sub_total_1unit = height(find(rolling_out_sim_tab.best_RAS_units==1))*RAS_CAPEX*1
            else
            RAS_sub_total_1unit = height(find(rolling_out_sim_tab.best_RAS_units==1))*RAS_CAPEX*ras_sub
            end
            RAS_sub_total_2units = height(find(rolling_out_sim_tab.best_RAS_units>1))*RAS_CAPEX*ras_sub
            RAS_sub_total = RAS_sub_total_1unit + RAS_sub_total_2units

        else
            i_rate_nsub = 0.04
            i_rate_sub = 0.02
            NPV_RAS_nsubirate = ((1+i_rate_nsub)^T_RAS - 1)/(i_rate_nsub*(1+i_rate_nsub)^T_RAS)
            NPV_RAS_subirate = ((1+i_rate_sub)^T_RAS - 1)/(i_rate_sub*(1+i_rate_sub)^T_RAS)
            RAS_sub_total = T_RAS*sum(rolling_out_sim_tab.best_RAS_units)*RAS_CAPEX*(1/NPV_RAS_nsubirate - 1/NPV_RAS_subirate)
            %OBS: mult for T_RAS = 10 in order to account for the 10 instalments
        end
   end

RAS_units_average = sum(rolling_out_sim_tab.best_RAS_units)/height(find(rolling_out_sim_tab.best_RAS_units > 0))
wood_created = (sum(rolling_out_sim_tab.Conifer,"omitnan") + sum(rolling_out_sim_tab.Broadleaved,"omitnan")) - (sum(rolling_out_tab.Conifer,"omitnan") + sum(rolling_out_tab.Broadleaved,"omitnan"))

%get vec from internal param vector 
   dna = readtable("D:/Pesquisa/Pesquisa_2024/Sustainable_Prawn/Emulation_2025/dna_initial_design_DW_06_08.txt","Delimiter","#")
   dna.Var3 = repelem("",height(dna))'
   for j = 1:height(dna) 
   dna.Var3(j) = string(dna.Var2(j))
   end    
   dna.vec = (1:height(dna))'

   dna_own = strcat(string(round(delta,4)),"_",string(round(alpha,4)),"_",string(round(irate_out,4)),"_",string(round(12*(1+cs_chitin),4)),"_",string(round(50*(1+cs_PLJ),4)),"_",string(round(2.4*(1+cs_feed),4)),"_",string(round(0.984*(1+cs_salt),4)))
   dna_own = array2table(dna_own)
   %RET
   dna_own.Properties.VariableNames = "Var3"

   %to deal with mistaken 2nd stages
   try
       dna = join(dna_own,dna,"Keys","Var3")
       vid = dna.vec 
       output_analysis = [output_analysis ; [ras_sub vid height(rolling_out_sim_tab) prawn_meat_price viability_rate RAS_units_average RAS_meat_production RAS_sub_total wood_created delta_out alpha_out irate_out 12*(1+cs_chitin) 50*(1+cs_PLJ) 2.4*(1+cs_feed) 0.984*(1+cs_salt)]]
   catch 
    listerror = [listerror; listofsims(jj,:)]
    warning(strcat("2nd stage mistaken = ", string(table2array(listofsims(jj,:)))));

   end        



end

writematrix(output_analysis,strcat(path,"check_quality_emulation_",type_sim,"_ras_sub_",string(ras_sub),"_",timing,".txt"))

listofsims(jj,:)
