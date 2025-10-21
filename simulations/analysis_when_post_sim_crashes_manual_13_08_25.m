
%cd 'D:/Pesquisa/Pesquisa_2024/Sustainable_Prawn/Emulation_2025/simulations/'
%postfile = 'D:/Pesquisa/Pesquisa_2024/Sustainable_Prawn/Emulation_2025/simulations/stage2_rerun/ras_sub_0.5_vid_29/ws_post_RAS_ras_sub_0.5_2025_08_13_04_46_47.mat'
%output_directory = 'D:/Pesquisa/Pesquisa_2024/Sustainable_Prawn/Emulation_2025/simulations/stage2_rerun/ras_sub_0.5_vid_29/'
%listofsims = array2table(string(postfile))

%cd 'D:/Pesquisa/Pesquisa_2024/Sustainable_Prawn/Emulation_2025/simulations/'
%postfile = 'D:/Pesquisa/Pesquisa_2024/Sustainable_Prawn/Emulation_2025/simulations/stage2_rerun/ras_sub_0_vid_33/ws_post_RAS_ras_sub_0_2025_08_12_13_04_17p294184.mat'
%output_directory = 'D:/Pesquisa/Pesquisa_2024/Sustainable_Prawn/Emulation_2025/simulations/stage2_rerun/ras_sub_0_vid_33/'
%listofsims = array2table(string(postfile))

cd 'D:/Pesquisa/Pesquisa_2024/Sustainable_Prawn/Emulation_2025/simulations/'
postfile = 'D:/Pesquisa/Pesquisa_2024/Sustainable_Prawn/Emulation_2025/simulations/stage2_rerun/ras_sub_1_vid_33/ws_post_RAS_ras_sub_1_2025_08_13_13_54_46.mat'
output_directory = 'D:/Pesquisa/Pesquisa_2024/Sustainable_Prawn/Emulation_2025/simulations/stage2_rerun/ras_sub_1_vid_33/'
listofsims = array2table(string(postfile))


%%%%%Params
i_rate = 0.04
T_RAS = 10
NPV_RAS = ((1+i_rate)^T_RAS - 1)/(i_rate*(1+i_rate)^T_RAS)
%Indicator 1 (sim-inespecific): minimum number of RAS units making AD
%feasible (OBS: NPV_AD = NPV_RAS)
%minimum_lb_RAS_units_for_AD = (AD_CAPEX/NPV_RAS + AD_OPEX - AD_SEG_tariff*AD_output_elec)/(RAS_elec_consumption*(elec_retail_price - AD_SEG_tariff))
%RAS_CAPEX_annuity = RAS_CAPEX/NPV_RAS


checkcheck = []
finansingle = []
listofnames = []
agg_tab = []
GMtab = []
check_old_wood = []

%path = 'D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Data\sim_PMP_EE_woodquad_2grants\'


%%NEV forestry GHG
%cd D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\NEV_TFMRS
%ghg_wood_from_NEV_forestry
%26/07, do not run, use number below
tc_av = 189.9333


%To re-run results with labour constraint
%cd 'G:\LEEP\Sustainable_Prawn\Data\sim_RAS_CAPEX_OPTIM_onlyfor_16_02_24'
%To run results with circcap constraint
%cd 'G:\LEEP\Sustainable_Prawn\Data\sim_RAS_water_LQ_NM_Nix_2023_extern_calib_01_05_24\'
%HP
%cd 'D:\LEEP\Sustainable_Prawn\Data\sim_RAS_water_LQ_NM_Nix_2023_extern_calib_01_05_24\'
%cd 'D:\LEEP\Sustainable_Prawn\Data\sim_RAS_water_LQ_NM_Nix_2023_extern_calib_01_05_24_wood_prio_update_25_06_24\'
%cd 'D:\LEEP\Sustainable_Prawn\Data\sim_RAS_water_LQ_NM_Nix_2023_extern_calib_01_05_24_wood_prio_update_23_07_24__finalaggtab\'
%cd 'D:\LEEP\Sustainable_Prawn\Data\sim_RAS_LQ_Nix_23_ext_calib_wood_prio_a25kmcorr_30_07_24\'
%cd 'D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Data\sim_PMP_EE_AFRASTECHV_wageREP\'
%cd 'D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Data\sim_PMP_EE_woodquad\'
%cd 'D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Data\sim_PMP_EE_woodquad_2grants\'



    %%%%1.a, rolling and rolling out
        clear rolling_tab rolling_out_tab rolling_out_sim_tab
        %        listofsims=readtable("listofsims.txt")
        jj = 1
%        listofsims = array2table(string(strcat(input_directory,postfile)))
        load(postfile)
        
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
protein_calories_upload_emulation

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

            sim_monitor = [(table2array(sum(rolling_out_tab(:,2:22),'omitnan')))' (table2array(sum(rolling_out_sim_tab(:,[LU_start_pos:HE_end_pos,GM_sim_pos]),'omitnan')))']
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
            sim_monitor = [(table2array(sum(rolling_out_tab(:,2:22),'omitnan')))' (table2array(sum(rolling_out_sim_tab(:,[LU_start_pos:HE_end_pos,GM_sim_pos]),'omitnan')))']
            size(table2array(sum(rolling_out_sim_tab(:,[LU_start_pos:HE_end_pos,GM_sim_pos]),'omitnan')))
            size([sum(area_observed_crop,1) sum(area_observed_forage,1) sum(rolling_out_tab(:,20),'all')])
%            wood_AL = 0
            sub_AL = 0
        end
%calories
        %%%Output-emulation 4
        cal_BL = sum(vec_kcal_crop'*(table2array(area_observed_crop(rolling_tab.i,1:12))')) + sum(table2array(area_observed_forage(rolling_tab.i,1)).*mat_kcal_m(rolling_tab.i,1)) + sum(table2array(area_observed_forage(rolling_tab.i,2)).*mat_kcal_m(rolling_tab.i,2)) + sum(table2array(area_observed_forage(rolling_tab.i,3)).*mat_kcal_m(rolling_tab.i,3))
        cal_AL = sum(vec_kcal_crop'.*table2array(rolling_out_sim_tab(:,[LU_start_pos:LU_med_pos])),'all','omitnan') + sum(table2array(rolling_out_sim_tab(:,(LU_med_pos+1))).*mat_kcal_m(rolling_tab.i,1),'omitnan') + sum(table2array(rolling_out_sim_tab(:,(LU_med_pos+2))).*mat_kcal_m(rolling_tab.i,2),'omitnan') + sum(table2array(rolling_out_sim_tab(:,(LU_end_pos))).*mat_kcal_m(rolling_tab.i,3),'omitnan')  + vec_kcal_RAS*RAS_units*vec_size_RAS
%        cal_AL_agr = sum(vec_kcal_crop'.*table2array(rolling_out_sim_tab(:,[LU_start_pos:LU_med_pos])),'all','omitnan') + sum(table2array(rolling_out_sim_tab(:,(LU_med_pos+1))).*mat_kcal_m(rolling_tab.i,1),'omitnan') + sum(table2array(rolling_out_sim_tab(:,(LU_med_pos+2))).*mat_kcal_m(rolling_tab.i,2),'omitnan') + sum(table2array(rolling_out_sim_tab(:,(LU_end_pos))).*mat_kcal_m(rolling_tab.i,3),'omitnan')
%        cal_AL_RAS = vec_kcal_RAS*RAS_units*vec_size_RAS

%protein
        %%%Output-emulation 5
        protein_BL = sum(vec_protein_crop'*(table2array(area_observed_crop(rolling_tab.i,1:12))')) + sum(table2array(area_observed_forage(rolling_tab.i,1)).*mat_protein_m(rolling_tab.i,1)) + sum(table2array(area_observed_forage(rolling_tab.i,2)).*mat_protein_m(rolling_tab.i,2)) + sum(table2array(area_observed_forage(rolling_tab.i,3)).*mat_protein_m(rolling_tab.i,3))
        protein_AL = sum(vec_protein_crop'.*table2array(rolling_out_sim_tab(:,[LU_start_pos:LU_med_pos])),'all','omitnan') + sum(table2array(rolling_out_sim_tab(:,(LU_med_pos+1))).*mat_protein_m(rolling_tab.i,1),'omitnan') + sum(table2array(rolling_out_sim_tab(:,(LU_med_pos+2))).*mat_protein_m(rolling_tab.i,2),'omitnan') + sum(table2array(rolling_out_sim_tab(:,(LU_end_pos))).*mat_protein_m(rolling_tab.i,3),'omitnan')  + vec_protein_RAS*RAS_units*vec_size_RAS

        sim_monitor = [sim_monitor;[[0 RAS_units*6624.25];[0 RAS_units*49.68]]; [0 wood_AL]; [cal_BL cal_AL]; [0 sub_AL] ]

        sim_monitor = array2table(sim_monitor)
        sim_monitor.Properties.VariableNames = ["BL" "AL"]
        sim_monitor.delta = sim_monitor.AL ./ sim_monitor.BL  - 1
        writetable(sim_monitor,strcat(output_directory,"table_4_sim_monit_",sim_name,"_",timing,".txt"),'writemode','overwrite')

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


        ghg_coeff_matrix_out = rows2vars(readtable(strcat(input_directory,"emissions_crops_pasture_BSFP_23_04_25.txt")),'VariableNamesSource','Crop')

        ghg_coeff_matrix_out_crop = ghg_coeff_matrix_out(:,["Barley_av" "Beans" "FieldVegetables" "Fodder" "Oats" "OSR" "OtherCereals" "Peas" "Potatoes" "SugarBeet" "Topandsoftfruit" "Wheat"])
        ghg_crops = table2array(rolling_out_sim_tab(:,["Barley" "Beans" "Field vegetables" "fodder" "Oats" "OSR" "Other cereals (triticale)" "Peas" "Potatoes" "Sugar beet" "Top and soft fruit" "Wheat"])) * table2array(ghg_coeff_matrix_out_crop)'
        ghg_crops = (-1)*sum(ghg_crops,"omitnan")

        ghg_coeff_matrix_out_forage = ghg_coeff_matrix_out(:,["pgrass" "tgrass"])
        %no emission from fertilizer from rough graz as it is not
        %fertilized (according with British Fertilizer Survey)
        ghg_forage = table2array(rolling_out_sim_tab(:,["Forage: grassland over five / permanent grassland" "Forage: grassland under five / temporary grassland"])) * table2array(ghg_coeff_matrix_out_forage)'
        ghg_forage = (-1)*sum(ghg_forage,"omitnan")


% Animals  (this numbers are in kgCO2eq)
   %h1=mean(AgricultureGHG.EmissionsLivestockPerHead.dairy(:,1))
   %5.2510e+03
   %h2=mean(AgricultureGHG.EmissionsLivestockPerHead.beef(:,1))
   %2.1543e+03
   %h3=mean(AgricultureGHG.EmissionsLivestockPerHead.sheep(:,1))
   %304.1537

        ghg_coeff_matrix_out_animal = array2table([2154.3*10^-3 5251*10^-3 304.1537*10^-3])
        ghg_coeff_matrix_out_animal.Properties.VariableNames = ["beef" "dairy" "sheep"]
        ghg_animal = table2array(rolling_out_sim_tab(:,["Animal: Beef cattle" "Animal: Dairy cow" "Animal: Sheep"])) * table2array(ghg_coeff_matrix_out_animal)'
        ghg_animal = (-1)*sum(ghg_animal,"omitnan")

%Wood (including old wood)
        size(mat_area_crop)
        old_wood = [area_observed_crop area_observed_forage area_observed_tree]

        checkcensus_here = array2table([table2array(old_wood(:,[1:12]))*ones(12,1) table2array(old_wood(:,[13:15]))*ones(3,1) table2array(old_wood(:,[16:17]))*ones(2,1)])
        checkcensus_here.total = table2array(checkcensus_here)*ones(3,1)

height(find(checkcensus_here.total>2500.001))

        height(find(table2array(checkcensus(:,1:3))*ones(3,1)>2500.001))
        height(find(table2array(checkcensus_here(:,1:3))*ones(3,1)>2500.001))
    checkcensus_here.i = (1:height(checkcensus_here))'

aaacheck2 = checkcensus_here(find(table2array(checkcensus_here(:,[1:3]))*ones(3,1)>2500.00001),:)




%%%Prawn and RAS GHG
%cd D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\NEV_TFMRS
    if (isempty(strfind(type_sim,"RAS"))==1)
        ghg_prawn_and_RAS = ghg_prawn_and_RAS_and_AD_22_04_25(0,0, 0)
    else
        if (isempty(strfind(type_sim,"RAS_&_AD"))==1)
            ghg_prawn_and_RAS = ghg_prawn_and_RAS_and_AD_22_04_25(RAS_units,0, 1)
        else
            RAS_units_grid = sum(rolling_out_sim_tab.best_RAS_units(find(rolling_out_sim_tab.best_option_name==4)))
            RAS_units_AD = sum(rolling_out_sim_tab.best_RAS_units(find(rolling_out_sim_tab.best_option_name==2|rolling_out_sim_tab.best_option_name==3)))
            ghg_prawn_and_RAS = ghg_prawn_and_RAS_and_AD_22_04_25(RAS_units_grid,RAS_units_AD, 1)
        end  
    end
        
        ghg_prawn_net_imports = ghg_prawn_and_RAS.GHG_prawn_net_imports 
        ghg_prawn_domestic_grid = ghg_prawn_and_RAS.GHG_domestic_prawn_grid 
        ghg_prawn_domestic_AD = ghg_prawn_and_RAS.GHG_domestic_prawn_AD
        ghg_prawn_avoided_import_substitution = ghg_prawn_and_RAS.GHG_avoided_by_import_substitution

%%%BL GHG
        ref = rolling_out_tab(:,"i")
        ref.Properties.VariableNames
        for jhj = ["area_observed_crop" "area_observed_forage" "head_observed" "area_observed_tree"]
            eval(strcat(jhj,"_noerror = ",jhj))
            eval(strcat(jhj,"_noerror.i = (1:height(",jhj,"))'"))
            eval(strcat("size(",jhj,")"))
            eval(strcat(jhj,"_noerror = join(ref,",jhj,"_noerror,'Keys','i')"))
            eval(strcat("size(",jhj,")"))
        end

        ghg_crops_BL = table2array(area_observed_crop_noerror(:,[2:width(area_observed_crop_noerror)])) * table2array(ghg_coeff_matrix_out_crop)'
        ghg_crops_BL = (-1)*sum(ghg_crops_BL,"omitnan")

        ghg_forage_BL = table2array(area_observed_forage_noerror(:,[2:width(area_observed_forage_noerror)])) * [table2array(ghg_coeff_matrix_out_forage) 0]'
        ghg_forage_BL = (-1)*sum(ghg_forage_BL,"omitnan")

        ghg_animal_BL = table2array(rolling_out_tab(:,["Animal: Beef cattle" "Animal: Dairy cow" "Animal: Sheep"])) * table2array(ghg_coeff_matrix_out_animal)'
        ghg_animal_BL = (-1)*sum(ghg_animal_BL,"omitnan")

	    ghg_wood_BL = tc_av*sum(area_observed_tree_noerror.broadleaved + area_observed_tree_noerror.conifer)
        ghg_prawn_and_RAS_BL = ghg_prawn_and_RAS_and_AD_06_03_25(0,0, 0)


        ghg_prawn_net_imports_BL = ghg_prawn_and_RAS_BL.GHG_prawn_net_imports 
        ghg_prawn_domestic_grid_BL = ghg_prawn_and_RAS_BL.GHG_domestic_prawn_grid 
        ghg_prawn_domestic_AD_BL = ghg_prawn_and_RAS_BL.GHG_domestic_prawn_AD
        ghg_prawn_avoided_import_substitution_BL = ghg_prawn_and_RAS_BL.GHG_avoided_by_import_substitution



%%%Leakage GHG (11/04/25) (1 x 3) . (1 x 3) . (1 x 3)
%coeff_kgco2=readtable("D:/Pesquisa/Pesquisa_2024/Sustainable_Prawn/Data/supermarket_data/table_transport_emissions_leakage_11_04_25.txt")
%coeff_kgco2=readtable("D:/Pesquisa/Pesquisa_2024/Sustainable_Prawn/Data/supermarket_data/table_transport_emissions_leakage_16_04_25.txt")
coeff_kgco2=readtable(strcat(input_directory,"table_transport_emissions_leakage_with_crops_21_04_25.txt"))

%OBS 0: calories/year * head/calories * kg / head * kgCO2/kg
%OBS 1: vec_kcal_animal in calories/head
%OBS 2: milk production ~ 5,000litres/cow * 1kg/litre (density)
%OBS 3: must convert from kgCO2 to tCO2 
%Yields used in mat_kcal_m (vec_kcal_animal)
coeff_head_to_kg = [601 5316.6666*1029.866*10^-3 39.3333]

tt_ratio_beef = 1.087437051 - 1
tt_ratio_dairy = 1.428571429- 1
tt_ratio_sheep = 0.821355236- 1
%only in sheep UK emits more

tt_ratio_crops = 0.7880538 - 1
tt_ratio_fert_for = 0.7567145 - 1

%crop total tonnages (yield in tonnne/ha)
tonnage_BL_crop = sum((ones(1,height(rolling_tab))*table2array(area_observed_crop(rolling_tab.i,1:12))).*(vec_yield_crop*10^3)')
tonnage_AL_crop = sum(sum(table2array(rolling_out_sim_tab(:,LU_start_pos:LU_med_pos)),1,'omitnan').*(vec_yield_crop*10^3)')

%livestock total tonnages
tonnage_BL_livestock = ones(1,height(rolling_tab))*table2array(rolling_out_tab(:,["Animal: Beef cattle" "Animal: Dairy cow" "Animal: Sheep"])).*coeff_head_to_kg
tonnage_AL_livestock = ones(1,height(rolling_tab))*table2array(rolling_out_sim_tab(:,["Animal: Beef cattle" "Animal: Dairy cow" "Animal: Sheep"])).*coeff_head_to_kg

%ghg (vs1 = livestock from kcal correcting to get in kg; vs2 = livestock from yield directly)
%ghg_leakage_transport_vs1 = (tonnage_BL_crop - tonnage_AL_crop)*coeff_kgco2.Var3(find(coeff_kgco2.Var2=="crops")) + ((calmon_BL_forage - calmon_AL_forage).*((1./(vec_kcal_animal))').*(coeff_head_to_kg))*(coeff_kgco2.Var3(find(coeff_kgco2.Var2~="crops")))
ghg_leakage_transport_vs2 = (tonnage_BL_crop - tonnage_AL_crop)*coeff_kgco2.Var3(find(coeff_kgco2.Var2=="crops")) + (tonnage_BL_livestock - tonnage_AL_livestock)*coeff_kgco2.Var3(find(coeff_kgco2.Var2~="crops"))

%ghg_leakage_transport_vs1/ ghg_leakage_transport_vs2 - 1
%2% error may be deemed as due to rounding
ghg_leakage_transport_vs2 = (-1)*sum(ghg_leakage_transport_vs2)

%Change in the carbon trade of balance due to change in production (ghg
%animal and crops in tonnes) (reversion of NEV sign convention --> * (-1))
%ghg_deltabalance_fermentation = (-1)*[tt_ratio_beef tt_ratio_dairy tt_ratio_sheep]*(ghg_animal_BL - ghg_animal) *10^3
ghg_deltabalance_fermentation = (sum(table2array(rolling_out_tab(:,["Animal: Beef cattle" "Animal: Dairy cow" "Animal: Sheep"])),1)- sum(table2array(rolling_out_sim_tab(:,["Animal: Beef cattle" "Animal: Dairy cow" "Animal: Sheep"])),1).* table2array(ghg_coeff_matrix_out_animal))*[tt_ratio_beef tt_ratio_dairy tt_ratio_sheep]'
ghg_deltabalance_fertilisation = ((-1)*tt_ratio_crops*(ghg_crops_BL - ghg_crops) + (-1)*tt_ratio_fert_for*(ghg_forage_BL - ghg_forage)) *10^3


%Final calc: carbon from agricultural trade balance
ghg_agri_trade_balance = ghg_leakage_transport_vs2 + ghg_deltabalance_fermentation + ghg_deltabalance_fertilisation

%Calculating as in the SI formula
%rolling_out_sim_tab.Properties.VariableNames(LU_start_pos:LU_med_pos)
%rolling_out_sim_tab.Properties.VariableNames((LU_med_pos+1):LU_end_pos)
%both ok

%delta_LU_crop = sum(table2array(area_observed_crop(rolling_tab.i,:),1)) - sum(table2array(rolling_out_sim_tab(:,LU_start_pos:LU_med_pos)),1,"omitnan")
%delta_LU_forage = sum(table2array(area_observed_forage(rolling_tab.i,:),1)) - sum(table2array(rolling_out_sim_tab(:,(LU_med_pos+1):LU_end_pos)),1,"omitnan")

LU_start_pos_out = find(rolling_out_tab.Properties.VariableNames=="Barley")
LU_med_pos_out = find(rolling_out_tab.Properties.VariableNames=="Wheat")
LU_end_pos_out = find(rolling_out_tab.Properties.VariableNames=="Rough grazing")

delta_LU_crop = sum(table2array(rolling_out_tab(:,[LU_start_pos_out:LU_med_pos_out])),1,"omitnan") - sum(table2array(rolling_out_sim_tab(:,LU_start_pos:LU_med_pos)),1,"omitnan")
delta_LU_forage = sum(table2array(rolling_out_tab(:,[(LU_med_pos_out+1):LU_end_pos_out])),1,"omitnan") - sum(table2array(rolling_out_sim_tab(:,(LU_med_pos+1):LU_end_pos)),1,"omitnan")

delta_head_beef = sum(table2array(rolling_out_tab(:,["Animal: Beef cattle"])),1) - sum(table2array(rolling_out_sim_tab(:,["Animal: Beef cattle"])),1)
delta_head_dairy = sum(table2array(rolling_out_tab(:,["Animal: Dairy cow"])),1) - sum(table2array(rolling_out_sim_tab(:,["Animal: Dairy cow"])),1)
delta_head_sheep = sum(table2array(rolling_out_tab(:,["Animal: Sheep"])),1) - sum(table2array(rolling_out_sim_tab(:,["Animal: Sheep"])),1)

mean(delta_LU_crop)/mean(delta_LU_forage)

carbon_trade_crops = delta_LU_crop*(tt_ratio_crops*(table2array(ghg_coeff_matrix_out_crop)*10^3)' + coeff_kgco2.Var3(find(coeff_kgco2.Var2=="crops")).*(vec_yield_crop*10^3))
carbon_trade_forage_fertilisation = tt_ratio_fert_for*delta_LU_forage*([table2array(ghg_coeff_matrix_out_forage)*10^3 0]')
%OBS: ghg_coeff_matrix_out_crops/forage is in tons

carbon_trade_beef = (tt_ratio_beef*ghg_coeff_matrix_out_animal.beef*10^3 + coeff_kgco2.Var3(find(coeff_kgco2.Var2=="beef")).*coeff_head_to_kg(1))*delta_head_beef
carbon_trade_dairy = (tt_ratio_dairy*ghg_coeff_matrix_out_animal.dairy*10^3 + coeff_kgco2.Var3(find(coeff_kgco2.Var2=="dairy")).*coeff_head_to_kg(2))*delta_head_dairy
carbon_trade_sheep = (tt_ratio_sheep*ghg_coeff_matrix_out_animal.sheep*10^3 + coeff_kgco2.Var3(find(coeff_kgco2.Var2=="sheep")).*coeff_head_to_kg(3))*delta_head_sheep
%OBS: ghg_coeff_matrix_out_animal is in tons

%prawn
carbon_trade_prawn_prod = ghg_prawn_and_RAS.GHG_increase_prod_decrease_imports
carbon_trade_prawn_transp = ghg_prawn_and_RAS.total_GHG_transport_imported
%wood
if isempty(strfind(type_sim,"aside")) == 1
    carbon_trade_wood = 0
else
    carbon_trade_wood = (-1)*tc_av*(sum(rolling_out_sim_tab.Broadleaved + rolling_out_sim_tab.Conifer,"omitnan")- sum(area_observed_tree.broadleaved(rolling_tab.i) + area_observed_tree.conifer(rolling_tab.i),"omitnan"))
end

%balance
carbon_agri_trade_balance = carbon_trade_crops + carbon_trade_forage_fertilisation + carbon_trade_beef + carbon_trade_dairy + carbon_trade_sheep + carbon_trade_prawn_prod + carbon_trade_prawn_transp + carbon_trade_wood

%comparing two calcs
carbon_agri_trade_balance_comp = carbon_trade_crops + carbon_trade_forage_fertilisation + carbon_trade_beef + carbon_trade_dairy + carbon_trade_sheep

ratio_two_calcs_GHG = carbon_agri_trade_balance_comp / ghg_agri_trade_balance - 1

carbon_agri_trade_balance_comp
ghg_agri_trade_balance

%fertilisation
ghg_deltabalance_fertilisation
delta_LU_crop*(tt_ratio_crops*(table2array(ghg_coeff_matrix_out_crop)*10^3)') + tt_ratio_fert_for*delta_LU_forage*([table2array(ghg_coeff_matrix_out_forage)*10^3 0]')

%fermentation
ghg_deltabalance_fermentation
carbon_trade_beef + carbon_trade_dairy + carbon_trade_sheep

%transport
ghg_leakage_transport_vs2
delta_LU_crop*(coeff_kgco2.Var3(find(coeff_kgco2.Var2=="crops")).*(vec_yield_crop*10^3)) + (coeff_kgco2.Var3(find(coeff_kgco2.Var2=="beef")).*coeff_head_to_kg(1))*delta_head_beef + (coeff_kgco2.Var3(find(coeff_kgco2.Var2=="dairy")).*coeff_head_to_kg(2))*delta_head_dairy + (coeff_kgco2.Var3(find(coeff_kgco2.Var2=="sheep")).*coeff_head_to_kg(3))*delta_head_sheep

size(ghg_coeff_matrix_out_crop)



%%%28/04, leakage souces tracking

if (isempty(strfind(type_sim,"RAS")) == 0 & isempty(strfind(type_sim,"aside")) == 0)

    %(:,["i" "Barley" "Beans" "Field vegetables" "fodder" "Oats" "OSR" "Other cereals (triticale)" "Peas" "Potatoes" "Sugar beet" "Top and soft fruit" "Wheat"])
    
    %(1) Creation of copy files
    area_obs_crop_copy = rolling_out_tab(:,1:13)
    area_obs_crop_copy.Properties.VariableNames(:,2:13) = strcat("obs_",area_obs_crop_copy.Properties.VariableNames(:,2:13))
    
    area_obs_forage_copy = rolling_out_tab(:,["i" "Forage: grassland over five / permanent grassland", "Forage: grassland under five / temporary grassland", "Rough grazing"])
    area_obs_forage_copy.Properties.VariableNames(:,2:4) = strcat("obs_",area_obs_forage_copy.Properties.VariableNames(:,2:4))
    
    head_obs_copy = rolling_out_tab(:,["i" "Animal: Beef cattle", "Animal: Dairy cow", "Animal: Sheep"])
    head_obs_copy.Properties.VariableNames(:,2:4) = strcat("obs_",head_obs_copy.Properties.VariableNames(:,2:4))
    
    area_sim_crop_copy = rolling_out_sim_tab(:,["i" "best_RAS_units" "Broadleaved" "Conifer" [crops(1:3)' "fodder" crops(5:12)']])
    area_sim_crop_copy.Properties.VariableNames(:,5:16) = strcat("sim_",area_sim_crop_copy.Properties.VariableNames(:,5:16))
    
    area_sim_forage_copy = rolling_out_sim_tab(:,["i" "best_RAS_units" "Broadleaved" "Conifer" forages'])
    area_sim_forage_copy.Properties.VariableNames(:,5:7) = strcat("sim_",area_sim_forage_copy.Properties.VariableNames(:,5:7))
    
    head_sim_copy = rolling_out_sim_tab(:,["i" "best_RAS_units" "Broadleaved" "Conifer" animals'])
    head_sim_copy.Properties.VariableNames(:,5:7) = strcat("sim_",head_sim_copy.Properties.VariableNames(:,5:7))
    
size(head_sim_copy)
size(head_obs_copy)
    %(2) Joining within groups
    area_sim_crop_copy = join(area_sim_crop_copy,area_obs_crop_copy,"Keys","i")
    area_sim_forage_copy = join(area_sim_forage_copy,area_obs_forage_copy,"Keys","i")
    head_sim_copy = join(head_sim_copy,head_obs_copy,"Keys","i")
    
size(head_sim_copy)
size(head_obs_copy)
    %(3) Positions
    crop_obs_start = find(area_sim_crop_copy.Properties.VariableNames == "obs_Barley")
    crop_obs_end = find(area_sim_crop_copy.Properties.VariableNames == "obs_Wheat")
    
    crop_sim_start = find(area_sim_crop_copy.Properties.VariableNames == "sim_Barley")
    crop_sim_end = find(area_sim_crop_copy.Properties.VariableNames == "sim_Wheat")
    
    area_sim_forage_copy.Properties.VariableNames
    forage_obs_start = find(area_sim_forage_copy.Properties.VariableNames == "obs_Forage: grassland over five / permanent grassland") 
    forage_obs_end = find(area_sim_forage_copy.Properties.VariableNames == "obs_Rough grazing")
    
    forage_sim_start = find(area_sim_forage_copy.Properties.VariableNames == "sim_Forage: grassland over five / permanent grassland") 
    forage_sim_end = find(area_sim_forage_copy.Properties.VariableNames == "sim_Rough grazing")
    
%    head_sim_copy.Properties.VariableNames
    head_obs_start = find(head_sim_copy.Properties.VariableNames == "obs_Animal_BeefCattle")
    head_obs_end = find(head_sim_copy.Properties.VariableNames == "obs_Animal_Sheep")
    
    head_sim_start = find(head_sim_copy.Properties.VariableNames == "sim_Animal: Beef cattle") 
    head_sim_end = find(head_sim_copy.Properties.VariableNames == "sim_Animal: Sheep")
    
    %(4) Leakage sources
    area_observed_tree_withi = area_observed_tree
    area_observed_tree_withi.i = (1:height(area_observed_tree_withi))'
    newwoodid = join(rolling_out_sim_tab,area_observed_tree_withi,"Keys","i")

    
    %newwoodpix_i = rolling_out_sim_tab.i(find(rolling_out_sim_tab.area_set_aside_sim > 0))
    newwoodpix = find(newwoodid.Broadleaved + newwoodid.Conifer > newwoodid.broadleaved + newwoodid.conifer)
    %RASpix_i = rolling_out_sim_tab.i(find(rolling_out_sim_tab.best_RAS_units > 0))
    RASpix = find(rolling_out_sim_tab.best_RAS_units > 0);
    
    %(5) Deltas
    delta_LU_crop_newwood = sum(table2array(area_sim_crop_copy(newwoodpix,[crop_obs_start:crop_obs_end])), 'omitnan') - sum(table2array(area_sim_crop_copy(newwoodpix,[crop_sim_start:crop_sim_end])),'omitnan')
    delta_LU_forage_newwood = sum(table2array(area_sim_forage_copy(newwoodpix,[forage_obs_start:forage_obs_end])), 'omitnan') - sum(table2array(area_sim_forage_copy(newwoodpix,[forage_sim_start:forage_sim_end])),'omitnan')
%RET
    head_sim_copy.Properties.VariableNames
    delta_beef_newwood = sum(table2array(head_sim_copy(newwoodpix,["obs_Animal: Beef cattle"])),1) - sum(table2array(head_sim_copy(newwoodpix,["sim_Animal: Beef cattle"])),1,'omitnan')
    delta_dairy_newwood = sum(table2array(head_sim_copy(newwoodpix,["obs_Animal: Dairy cow"])),1) - sum(table2array(head_sim_copy(newwoodpix,["sim_Animal: Dairy cow"])),1,'omitnan')
    delta_sheep_newwood = sum(table2array(head_sim_copy(newwoodpix,["obs_Animal: Sheep"])),1) - sum(table2array(head_sim_copy(newwoodpix,["sim_Animal: Sheep"])),1,'omitnan')
    
    delta_LU_crop_RAS = sum(table2array(area_sim_crop_copy(RASpix,[crop_obs_start:crop_obs_end]))) - sum(table2array(area_sim_crop_copy(RASpix,[crop_sim_start:crop_sim_end])),'omitnan')
    delta_LU_forage_RAS = sum(table2array(area_sim_forage_copy(RASpix,[forage_obs_start:forage_obs_end]))) - sum(table2array(area_sim_forage_copy(RASpix,[forage_sim_start:forage_sim_end])),'omitnan')
    
    delta_beef_RAS = sum(table2array(head_sim_copy(RASpix,["obs_Animal: Beef cattle"])),1) - sum(table2array(head_sim_copy(RASpix,["sim_Animal: Beef cattle"])),1,'omitnan')
    delta_dairy_RAS = sum(table2array(head_sim_copy(RASpix,["obs_Animal: Dairy cow"])),1) - sum(table2array(head_sim_copy(RASpix,["sim_Animal: Dairy cow"])),1,'omitnan')
    delta_sheep_RAS = sum(table2array(head_sim_copy(RASpix,["obs_Animal: Sheep"])),1) - sum(table2array(head_sim_copy(RASpix,["sim_Animal: Sheep"])),1,'omitnan')
    
    
    carbon_trade_crops_newwood = delta_LU_crop_newwood*(tt_ratio_crops*(table2array(ghg_coeff_matrix_out_crop)*10^3)' + coeff_kgco2.Var3(find(coeff_kgco2.Var2=="crops")).*(vec_yield_crop*10^3))
    carbon_trade_crops_RAS = delta_LU_crop_RAS*(tt_ratio_crops*(table2array(ghg_coeff_matrix_out_crop)*10^3)' + coeff_kgco2.Var3(find(coeff_kgco2.Var2=="crops")).*(vec_yield_crop*10^3))
    
    carbon_trade_forage_fertilisation_newwood = tt_ratio_fert_for*delta_LU_forage_newwood*([table2array(ghg_coeff_matrix_out_forage)*10^3 0]')
    carbon_trade_forage_fertilisation_RAS = tt_ratio_fert_for*delta_LU_forage_RAS*([table2array(ghg_coeff_matrix_out_forage)*10^3 0]')
    
    %OBS: ghg_coeff_matrix_out_crops/forage is in tons
    
    carbon_trade_beef_newwood = (tt_ratio_beef*ghg_coeff_matrix_out_animal.beef*10^3 + coeff_kgco2.Var3(find(coeff_kgco2.Var2=="beef")).*coeff_head_to_kg(1))*delta_beef_newwood
    carbon_trade_dairy_newwood = (tt_ratio_dairy*ghg_coeff_matrix_out_animal.dairy*10^3 + coeff_kgco2.Var3(find(coeff_kgco2.Var2=="dairy")).*coeff_head_to_kg(2))*delta_dairy_newwood
    carbon_trade_sheep_newwood = (tt_ratio_sheep*ghg_coeff_matrix_out_animal.sheep*10^3 + coeff_kgco2.Var3(find(coeff_kgco2.Var2=="sheep")).*coeff_head_to_kg(3))*delta_sheep_newwood
    
    carbon_trade_beef_RAS = (tt_ratio_beef*ghg_coeff_matrix_out_animal.beef*10^3 + coeff_kgco2.Var3(find(coeff_kgco2.Var2=="beef")).*coeff_head_to_kg(1))*delta_beef_RAS
    carbon_trade_dairy_RAS = (tt_ratio_dairy*ghg_coeff_matrix_out_animal.dairy*10^3 + coeff_kgco2.Var3(find(coeff_kgco2.Var2=="dairy")).*coeff_head_to_kg(2))*delta_dairy_RAS
    carbon_trade_sheep_RAS = (tt_ratio_sheep*ghg_coeff_matrix_out_animal.sheep*10^3 + coeff_kgco2.Var3(find(coeff_kgco2.Var2=="sheep")).*coeff_head_to_kg(3))*delta_sheep_RAS
    
    %OBS: ghg_coeff_matrix_out_animal is in tons
    carbon_trade_balance_agri_newwood = carbon_trade_crops_newwood + carbon_trade_forage_fertilisation_newwood + carbon_trade_beef_newwood + carbon_trade_dairy_newwood + carbon_trade_sheep_newwood
    carbon_trade_balance_agri_RAS = carbon_trade_crops_RAS + carbon_trade_forage_fertilisation_RAS + carbon_trade_beef_RAS + carbon_trade_dairy_RAS + carbon_trade_sheep_RAS
else
        carbon_trade_balance_agri_newwood = 0
        carbon_trade_balance_agri_RAS = 0

end



%breakdown separating transport (added 28/07/25)
%carbon_trade_crops = delta_LU_crop*(tt_ratio_crops*(table2array(ghg_coeff_matrix_out_crop)*10^3)' + coeff_kgco2.Var3(find(coeff_kgco2.Var2=="crops")).*(vec_yield_crop*10^3))
carbon_trade_crops_prod = delta_LU_crop*(tt_ratio_crops*(table2array(ghg_coeff_matrix_out_crop)*10^3)')
carbon_trade_crops_transp = delta_LU_crop*(coeff_kgco2.Var3(find(coeff_kgco2.Var2=="crops")).*(vec_yield_crop*10^3))
carbon_trade_crops_prod + carbon_trade_crops_transp - carbon_trade_crops
%ok

%OBS: ghg_coeff_matrix_out_crops/forage is in tons
%carbon_trade_beef = (tt_ratio_livestock*ghg_coeff_matrix_out_animal.beef*10^3 + coeff_kgco2.Var3(find(coeff_kgco2.Var2=="beef")).*coeff_head_to_kg(1))*delta_head_beef
carbon_trade_beef_prod = (tt_ratio_beef*ghg_coeff_matrix_out_animal.beef*10^3)*delta_head_beef
carbon_trade_beef_transp = (coeff_kgco2.Var3(find(coeff_kgco2.Var2=="beef")).*coeff_head_to_kg(1))*delta_head_beef
carbon_trade_beef_prod + carbon_trade_beef_transp - carbon_trade_beef
%ok

%carbon_trade_dairy = (tt_ratio_livestock*ghg_coeff_matrix_out_animal.dairy*10^3 + coeff_kgco2.Var3(find(coeff_kgco2.Var2=="dairy")).*coeff_head_to_kg(2))*delta_head_dairy
carbon_trade_dairy_prod = (tt_ratio_dairy*ghg_coeff_matrix_out_animal.dairy*10^3)*delta_head_dairy
carbon_trade_dairy_transp = (coeff_kgco2.Var3(find(coeff_kgco2.Var2=="dairy")).*coeff_head_to_kg(2))*delta_head_dairy
carbon_trade_dairy_prod + carbon_trade_dairy_transp - carbon_trade_dairy
%ok

%carbon_trade_sheep = (tt_ratio_livestock*ghg_coeff_matrix_out_animal.sheep*10^3 + coeff_kgco2.Var3(find(coeff_kgco2.Var2=="sheep")).*coeff_head_to_kg(3))*delta_head_sheep
carbon_trade_sheep_prod = (tt_ratio_sheep*ghg_coeff_matrix_out_animal.sheep*10^3)*delta_head_sheep
carbon_trade_sheep_transp = (coeff_kgco2.Var3(find(coeff_kgco2.Var2=="sheep")).*coeff_head_to_kg(3))*delta_head_sheep
carbon_trade_sheep_prod + carbon_trade_sheep_transp - carbon_trade_sheep
%ok

%transp uni
carbon_trade_transp_agri = carbon_trade_crops_transp + carbon_trade_beef_transp + carbon_trade_dairy_transp + carbon_trade_sheep_transp


%%%Output-emulation 6
carbon_agri_total = carbon_trade_crops + carbon_trade_forage_fertilisation + carbon_trade_beef + carbon_trade_dairy + carbon_trade_sheep + carbon_trade_transp_agri
carbon_prawn_total = ghg_prawn_and_RAS.total_GHG_transport_imported + ghg_prawn_and_RAS.GHG_increase_prod_decrease_imports_grid

%if RAS_sub_total > 0
%%%Output-emulation 7
%index_1_calorie_effect = (cal_AL - cal_BL)/RAS_sub_total
%now RAS sub total
%%%Output-emulation 8
%index_2_protein_effect = (protein_AL - protein_BL)/RAS_sub_total
%else
%index_1_calorie_effect = 0
%index_2_protein_effect = 0
%end

syms negsign(x);
negsign(x) = piecewise(x<0,x,x>=0,0)
possign(x) = piecewise(x>0,x,x<=0,0)

help piecewise

carbon_agri_total_neg = double(negsign(carbon_trade_crops)) + double(negsign(carbon_trade_forage_fertilisation)) + double(negsign(carbon_trade_beef)) + double(negsign(carbon_trade_dairy)) + double(negsign(carbon_trade_sheep)) + double(negsign(carbon_trade_wood))
carbon_prawn_total_neg = double(negsign(ghg_prawn_and_RAS.total_GHG_transport_imported)) + double(negsign(ghg_prawn_and_RAS.GHG_increase_prod_decrease_imports_grid))

carbon_agri_total_pos = double(possign(carbon_trade_crops)) + double(possign(carbon_trade_forage_fertilisation)) + double(possign(carbon_trade_beef)) + double(possign(carbon_trade_dairy)) + double(possign(carbon_trade_sheep)) + double(possign(carbon_trade_wood))
carbon_prawn_total_pos = double(possign(ghg_prawn_and_RAS.total_GHG_transport_imported)) + double(possign(ghg_prawn_and_RAS.GHG_increase_prod_decrease_imports_grid))

%%%Output-emulation 9
if RAS_sub_total > 0
index_3_carbon_effect = (-1)*(carbon_agri_total_neg + carbon_prawn_total_neg)/RAS_sub_total
%%%Output-emulation 10
index_4_externality_effect = (-1)*(carbon_agri_total_neg + carbon_prawn_total_neg) / (carbon_agri_total_pos + carbon_prawn_total_pos)
else
index_3_carbon_effect = 0
index_4_externality_effect = 0
end
%output_analysis = [prawn_meat_price viability_rate RAS_meat_production cal_AL protein_AL carbon_agri_total carbon_prawn_total index_1_calorie_effect index_2_protein_effect index_3_carbon_effect index_4_externality_effect]
output_analysis = [prawn_meat_price viability_rate RAS_meat_production cal_AL protein_AL carbon_agri_total carbon_prawn_total RAS_sub_total index_3_carbon_effect index_4_externality_effect]

writematrix(output_analysis,strcat(output_directory,"outputs_emulation_",type_sim,"_ras_sub_",string(ras_sub),"_",timing,".txt"))

 


