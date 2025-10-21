
%path to files
%path = 'D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Emulation_2025\outputs\post_sim_files\'
%path = 'F:\Emulation_2025\single_folder\'
path = 'D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Data\sim_PMP_EE_woodquad_2grants\'

%general dump
cd(path)
listofsims = dir('*G2050*.mat*')
listofsims = struct2table(listofsims)
listofsims = listofsims(:,1)
listofsims = listofsims(2:6,1)

output_analysis = []

%%%%%%START OF LOOP
%for jj = [1:116 118:height(listofsims3)]
for jj = [1:height(listofsims)]
    cd(path)
    %    clear rolling_tab rolling_out_tab rolling_out_sim_tab
    clearvars -except jj path listofsims output_analysis listerror listofsims3
        %        listofsims=readtable("listofsims.txt")
    
    load(string(table2array(listofsims(jj,1))));


    %%%%%Params
    %i_rate = 0.04
    %T_RAS = 10
    %NPV_RAS = ((1+i_rate)^T_RAS - 1)/(i_rate*(1+i_rate)^T_RAS)
    %Indicator 1 (sim-inespecific): minimum number of RAS units making AD
    %feasible (OBS: NPV_AD = NPV_RAS)
    %minimum_lb_RAS_units_for_AD = (AD_CAPEX/NPV_RAS + AD_OPEX - AD_SEG_tariff*AD_output_elec)/(RAS_elec_consumption*(elec_retail_price - AD_SEG_tariff))
    %RAS_CAPEX_annuity = RAS_CAPEX/NPV_RAS
    input_directory = 'D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Emulation_2025\simulations\'
            

   
    %        path = pathdurable
             %01/05, introducing rolling, rolling_out
              load(strcat(input_directory,"workspace_rolling_rolling_out_calibration_woodquad_2woodgrants_17_06_25.mat"));
    
    %         clear RAS_CAPEX_annuity
    %         RAS_CAPEX_annuity = RAS_CAPEX/NPV_RAS
    
            %prioupdate
            display(jj)
            rolling_tab = array2table(rolling);
            height(rolling_tab);
            rolling_out_tab = array2table(rolling_out);
            height(rolling_out_tab);
            
            rolling_tab.Properties.VariableNames = ["i" "d_cropless" "maxerror_crop" "maxerror_forage" "maxerror_animal" "maxerror_tree" "bind_const"];
            rolling_out_tab.Properties.VariableNames = ["i" [crops(1:3)' "fodder" crops(5:12)'] forages' trees' animals' "GM_BL" "lambda_land_target" "lambda_labour_target" "lambda_water_target" "lambda_land_LP" "lambda_labour_LP" "lambda_water_LP"];
    
    
            rolling_tab.noerror_pix = repelem(0,height(rolling_tab))';
            rolling_tab.noerror_pix(find((rolling_tab.d_cropless ==0 & (rolling_tab.maxerror_crop<10^-5 & rolling_tab.maxerror_forage<10^-5 & rolling_tab.maxerror_animal<10^-5 & (rolling_tab.maxerror_tree<10^-5 | isnan(rolling_tab.maxerror_tree)==1)))|(rolling_tab.d_cropless ==1 & (isnan(rolling_tab.maxerror_crop) == 1 & rolling_tab.maxerror_forage<10^-5 & rolling_tab.maxerror_animal<10^-5 & (rolling_tab.maxerror_tree<10^-5 | isnan(rolling_tab.maxerror_tree)==1))))) = 1;
            %tabulate(rolling_tab.noerror_pix)
    %        rolling_tab.Properties.VariableNames
            rolling_tab2 = rolling_tab(:,["i","noerror_pix"]);
    
            rolling_out_tab = join(rolling_out_tab,rolling_tab2,"Keys","i");       
            rolling_tab = rolling_tab(find(rolling_tab.noerror_pix == 1),:);
            rolling_out_tab = rolling_out_tab(find(rolling_out_tab.noerror_pix == 1),:);
            
            %%%%1.b, rolling_out_sim_RAS
            
            rolling_out_sim_tab = array2table(rolling_out_sim_RAS);
       %Attention: empty = 1 
       switch type_sim 
                  case {"set_aside_only","set_aside_only_gis","set_aside_only_gis_nocalconstraint","set_aside_only_gis_nocalconstraint_EWCO"}
                    %orig: rolling_out_sim_aside = [rolling_out_sim_aside ; [i sol_sim.area_crop' sol_sim.area_forage' sollives' GM_gain_aside_net fval_sim obj_fun_sim_val GM_agric_no_aside sub_aside area_set_aside_sim kcal_sim kcal_BL share_land_set_aside share_labour_set_aside]]
                    rolling_out_sim_tab = array2table(rolling_out_sim_aside);
                    rolling_out_sim_tab.Properties.VariableNames = ["i" [crops(1:3)' "fodder" crops(5:12)'] forages' trees' animals' "GM_gain_aside_net" "fval_sim" "obj_fun_sim_val" "GM_agric_no_aside" "sub_aside" "kcal_sim" "kcal_BL" "share_land_set_aside" "share_labour_set_aside" "share_water_set_aside"];
    %G2050 budget, 26/06; 25/05/2025 (removed cell2mat enveloping strfind, as a number was showing up)
                        sim_name = strcat(type_sim,"_TU_",string(topup_set_aside))
                   
                    %19/03, take off after
           case {"RAS_all_delta_set_aside","RAS_all_delta_set_aside_nocalconstraint", "RAS_all_delta_set_aside_nocalconstraint_v_irate","RAS_all_delta_set_aside_nocalconstraint_irate_2p", "RAS_aside_nocalconst_sub_fix_unit", "RAS_aside_nocalconst_sub_fix_unit_two","RAS_all_delta_set_aside_nocalconstraint_wq","RAS_aside_nocalconst_sub_fix_unit_two_wq"}
                    %orig: rolling_out_sim_RAS_by_unit = [rolling_out_sim_RAS_by_unit ; [i g sol_sim.area_crop' sol_sim.area_forage' sollives' GM_gain_RAS_net (fval_target - fval_sim) (area_RAS*vec_GM_RAS) fval_sim obj_fun_sim_val share_land_RAS share_labour_RAS area_RAS area_set_aside_sim kcal_sim kcal_BL share_land_set_aside share_labour_set_aside share_kcal_RAS d_one_unit_unfeasible]]
                    rolling_out_sim_tab.Properties.VariableNames = ["i" "best_RAS_units" [crops(1:3)' "fodder" crops(5:12)'] forages' trees' animals' "GM_gain_RAS_net" "GM_agr_change" "GM_RAS" "fval_sim" "obj_fun_sim_val" "share_land_RAS" "share_labour_RAS" "share_water_RAS" "area_RAS" "kcal_sim" "kcal_BL" "share_land_set_aside" "share_labour_set_aside" "share_water_set_aside" "share_kcal_RAS" "sub_aside" "d_one_unit_unfeasible"];
                    %sim_name = strcat(type_sim,"_TU_",string(topup_set_aside))
                    sim_name = type_sim;
    
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
       end
    
       
        
     %%%Output-emulation 1
     if (contains(sim_name,"RAS") == 1)
            prawn_meat_price = price_meat;
    %%%Output-emulation 2
            viability_rate = length(find(rolling_out_sim_tab.best_RAS_units > 0)) / height(rolling_out_sim_tab);
     else
         prawn_meat_price = NaN
         viability_rate = 0
     end
    
    %table
            LU_start_pos = find(rolling_out_sim_tab.Properties.VariableNames =="Barley");
            LU_med_pos = find(rolling_out_sim_tab.Properties.VariableNames =="Wheat");
            LU_end_pos = find(rolling_out_sim_tab.Properties.VariableNames =="Rough grazing");
            HE_end_pos = find(rolling_out_sim_tab.Properties.VariableNames =="Animal: Sheep");
            GM_sim_pos = find(rolling_out_sim_tab.Properties.VariableNames =="fval_sim" | rolling_out_sim_tab.Properties.VariableNames =="best_option_value");
            RAS_units = sum(table2array(rolling_out_sim_tab(:,find(rolling_out_sim_tab.Properties.VariableNames =="best_RAS_units"))));
            if isempty(RAS_units) == 1
                        RAS_units = 0
                    end
    %        sim_monitor = [(ones(1,height(noerror_pix))*rolling_out_ne(:,2:20))' (ones(1,height(noerror_pix))*rolling_out_sim_RAS_ne(:,[LU_start_pos:LU_end_pos,GM_sim_pos]))']
    
           
            %10/02/25, do not do as below, it is not compatible with postfix
            %        sim_monitor = [table2array([sum(area_observed_crop(rolling_tab.i,:),1) sum(area_observed_forage(rolling_tab.i,:),1) sum(head_observed(rolling_tab.i,:),1) sum(rolling_out_tab(:,20),'all')])' (table2array(sum(rolling_out_sim_tab(:,[LU_start_pos:HE_end_pos,GM_sim_pos]),'omitnan')))']
    
    %18/06/25: only created, all sims
                wood_AL = sum(rolling_out_sim_tab.Broadleaved + rolling_out_sim_tab.Conifer,"omitnan") - sum(area_observed_tree.broadleaved(rolling_tab.i) + area_observed_tree.conifer(rolling_tab.i),"omitnan");
    
            %Aggregates: (prod, wood, cal, sub)
            if (type_sim == "set_aside_only" | type_sim == "set_aside_only_nocalconstraint" | type_sim == "RAS_all_delta_set_aside" | type_sim == "RAS_all_delta_set_aside_nocalconstraint" | type_sim == "RAS_&_AD_set_aside" | type_sim == "set_aside_only_gis" | type_sim == "RAS_&_AD_set_aside_nocalconstraint" | type_sim == "RAS_all_delta_set_aside_nocalconstraint_v_irate" | type_sim == "set_aside_only_nocalconstraint_Eng" | type_sim == "set_aside_only_gis_nocalconstraint" | type_sim == "RAS_all_delta_set_aside_nocalconstraint_irate_2p" | type_sim == "RAS_aside_nocalconst_sub_fix_unit" | type_sim == "RAS_aside_nocalconst_sub_fix_unit_two" | type_sim == "set_aside_only_gis_nocalconstraint_EWCO" | type_sim == "RAS_all_delta_set_aside_nocalconstraint_wq" | type_sim == "RAS_aside_nocalconst_sub_fix_unit_two_wq")
    
                size(table2array(sum(rolling_out_sim_tab(:,[LU_start_pos:HE_end_pos,GM_sim_pos]),'omitnan')));
                size([sum(area_observed_crop,1) sum(area_observed_forage,1) sum(rolling_out_tab(:,21),'all')]);
    
                if (type_sim ~= "set_aside_only_gis")
    %                sub_AL = sum((400 + EMcost)*rolling_out_sim_tab.area_set_aside_sim)
    %                sub_AL_bro = sum((500 + EMcost_bro)*rolling_out_sim_tab.Broadleaved,"omitnan")
     %               sub_AL_con = sum((500 + EMcost_con)*rolling_out_sim_tab.Conifer,"omitnan")
    %                sub_AL = sub_AL_bro + sub_AL_con
                    sub_AL = sum(rolling_out_sim_tab.sub_aside)
                else
    %RET Here and adapt to the new GIS-based sim (19/05/25)
                    sub_AL_bro = sum((tab_ewco_ac.value(rolling_out_sim_tab.i) + EMcost_bro).*rolling_out_sim_tab.Broadleaved,"omitnan");
                    sub_AL_con = sum((tab_ewco_ac.value(rolling_out_sim_tab.i) + EMcost_con).*rolling_out_sim_tab.Conifer,"omitnan");
                    sub_AL = sub_AL_bro + sub_AL_con;
                end
            else
    %delete
                size(table2array(sum(rolling_out_sim_tab(:,[LU_start_pos:HE_end_pos,GM_sim_pos]),'omitnan')));
                size([sum(area_observed_crop,1) sum(area_observed_forage,1) sum(rolling_out_tab(:,20),'all')]);
    %            wood_AL = 0
                sub_AL = 0
            end
    %calories
    
    
        %%%Output-emulation 3
        RAS_meat_production = RAS_units * 6624;
    
    
    
    %before 14/08 vs
    %wood_created = (sum(rolling_out_sim_tab.Conifer,"omitnan") + sum(rolling_out_sim_tab.Broadleaved,"omitnan")) - (sum(rolling_out_tab.Conifer,"omitnan") + sum(rolling_out_tab.Broadleaved,"omitnan"))
    %vs in the original analysis made for emulation
    % 18/06/25: only created, all sims
    wood_created = sum(rolling_out_sim_tab.Broadleaved + rolling_out_sim_tab.Conifer,"omitnan") - sum(area_observed_tree.broadleaved(rolling_tab.i) + area_observed_tree.conifer(rolling_tab.i),"omitnan");

      %Run food carbon      
           cd('D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Emulation_2025\simulations\')
           analysis_food_carbon_module_08_09_25;

    %store outputs
    output_analysis = [output_analysis ; [ras_sub height(rolling_out_sim_tab) prawn_meat_price viability_rate RAS_units_average RAS_meat_production RAS_sub_total cal_AL protein_AL carbon_avoided_total carbon_released_total wood_created delta alpha irate_out 12 50 2.4 0.984]];

end

%writematrix(output_analysis,strcat(path,"check_quality_emulation_14_08_25",strrep(strrep(strrep(string(datetime),":","_")," ","_"),"-","_")))
%writematrix(output_analysis,strcat(path,"check_quality_emulation_",strrep(strrep(strrep(string(datetime),":","_")," ","_"),"-","_")))
writematrix(output_analysis,strcat("D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Data\","check_quality_default_",strrep(strrep(strrep(string(datetime),":","_")," ","_"),"-","_"),".txt"))

height(output_analysis)

