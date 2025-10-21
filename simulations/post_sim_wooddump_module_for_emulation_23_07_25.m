
function [keymat] = post_sim_wooddump(name_ml_file,output_directory)

%jj = 1
    load(name_ml_file)
    load("workspace_rolling_rolling_out_calibration_woodquad_2woodgrants_17_06_25.mat")
    
    rolling_tab = array2table(rolling)
    rolling_tab.Properties.VariableNames = ["i" "d_cropless" "maxerror_crop" "maxerror_forage" "maxerror_animal" "maxerror_tree" "bind_const"]

    rolling_out_tab = array2table(rolling_out)
    rolling_out_tab.Properties.VariableNames = ["i" [crops(1:3)' "fodder" crops(5:12)'] forages' trees' animals' "GM_BL" "lambda_land_target" "lambda_labour_target" "lambda_water_target" "lambda_land_LP" "lambda_labour_LP" "lambda_water_LP"]
    
    rolling_tab.noerror_pix = repelem(0,height(rolling_tab))'
    rolling_tab.noerror_pix(find((rolling_tab.d_cropless ==0 & (rolling_tab.maxerror_crop<10^-5 & rolling_tab.maxerror_forage<10^-5 & rolling_tab.maxerror_animal<10^-5 & (rolling_tab.maxerror_tree<10^-5 | isnan(rolling_tab.maxerror_tree)==1)))|(rolling_tab.d_cropless ==1 & (isnan(rolling_tab.maxerror_crop) == 1 & rolling_tab.maxerror_forage<10^-5 & rolling_tab.maxerror_animal<10^-5 & (rolling_tab.maxerror_tree<10^-5 | isnan(rolling_tab.maxerror_tree)==1))))) = 1

    rolling_tab2 = rolling_tab(:,["i","noerror_pix"])
    rolling_out_tab = join(rolling_out_tab,rolling_tab,"Keys","i")
    size(rolling_out_tab)
    rolling_out_tab = rolling_out_tab(find(rolling_out_tab.noerror_pix==1),:)
    size(rolling_out_tab)

    rolling_out_sim_tab = array2table(rolling_out_sim_RAS)

    switch type_sim

        case {"set_aside_only","set_aside_only_gis","set_aside_only_gis_nocalconstraint","set_aside_only_gis_nocalconstraint_EWCO"}
                rolling_out_sim_tab = array2table(rolling_out_sim_aside)
                rolling_out_sim_tab.Properties.VariableNames = ["i" [crops(1:3)' "fodder" crops(5:12)'] forages' trees' animals' "GM_gain_aside_net" "fval_sim" "obj_fun_sim_val" "GM_agric_no_aside" "sub_aside" "kcal_sim" "kcal_BL" "share_land_set_aside" "share_labour_set_aside" "share_water_set_aside"]

              case {"RAS_all_delta_set_aside","RAS_all_delta_set_aside_nocalconstraint", "RAS_all_delta_set_aside_nocalconstraint_v_irate","RAS_all_delta_set_aside_nocalconstraint_irate_2p", "RAS_aside_nocalconst_sub_fix_unit", "RAS_aside_nocalconst_sub_fix_unit_two","RAS_all_delta_set_aside_nocalconstraint_wq","RAS_aside_nocalconst_sub_fix_unit_two_wq"}
                rolling_out_sim_tab.Properties.VariableNames = ["i" "best_RAS_units" [crops(1:3)' "fodder" crops(5:12)'] forages' trees' animals' "GM_gain_RAS_net" "GM_agr_change" "GM_RAS" "fval_sim" "obj_fun_sim_val" "share_land_RAS" "share_labour_RAS" "share_water_RAS" "area_RAS" "kcal_sim" "kcal_BL" "share_land_set_aside" "share_labour_set_aside" "share_water_set_aside" "share_kcal_RAS" "sub_aside" "d_one_unit_unfeasible"]
    end   

    activity_shares_c = activity_shares        
%        activity_shares_c.GMdelta = activity_shares_c.GM_AL - activity_shares_c.GM_BL
            area_observed_tree.i = (1:height(area_observed_tree))'            
            rolling_out_sim_tab = join(rolling_out_sim_tab,area_observed_tree,"Keys","i")
reduxsimtab1 = rolling_out_sim_tab(:,["i" "broadleaved" "conifer" "Broadleaved" "Conifer"])
%            reduxsimtab1.Properties.VariableNames = ["i" "broadleaved" "conifer"]
            reduxsimtab1.Properties.VariableNames = ["i" "broadleaved_BL" "conifer_BL" "broadleaved_AL" "conifer_AL"]
%22/05/25: this is incremental, created, woodland 
            reduxsimtab1.broadleaved_new = reduxsimtab1.broadleaved_AL - reduxsimtab1.broadleaved_BL
            reduxsimtab1.conifer_new = reduxsimtab1.conifer_AL - reduxsimtab1.conifer_BL
            reduxsimtab1 = reduxsimtab1(:,["i" "broadleaved_new" "conifer_new"])
            reduxsimtab1.Properties.VariableNames = ["i" "broadleaved" "conifer"]
            activity_shares_c.i = (1:height(activity_shares))'
            activity_shares_c = join(reduxsimtab1,activity_shares_c,"Keys","i")
        mattab6 = [activity_shares_c.i string(activity_shares_c.key) activity_shares_c.broadleaved activity_shares_c.conifer];
                if contains(name_ml_file,"IR002") == 1
                writematrix(mattab6,strcat(output_directory,"table_6_GM_change_BL_AL_",type_sim,"_IR002.txt"),'writemode','overwrite')
                else
                writematrix(mattab6,strcat(output_directory,"table_6_GM_change_BL_AL_",type_sim,"_ras_sub_",string(ras_sub),".txt"),'writemode','overwrite')
                end
end
