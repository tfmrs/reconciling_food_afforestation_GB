if type_ml_file =="wood_only"
    load(strcat(wood_only_directory,source_ml_file))
    rolling_out_sim_tab = array2table(rolling_out_sim_aside)
    rolling_out_sim_tab.Properties.VariableNames = ["i" [crops(1:3)' "fodder" crops(5:12)'] forages' trees' animals' "GM_gain_aside_net" "fval_sim" "obj_fun_sim_val" "GM_agric_no_aside" "sub_aside" "kcal_sim" "kcal_BL" "share_land_set_aside" "share_labour_set_aside" "share_water_set_aside"]
    writetable(rolling_out_sim_tab,strcat(output_directory,"rolling_out_sim_wood_only_emulation.txt"))

end

if type_ml_file =="RAS_only"
    load(strcat(output_directory,source_ml_file))
    rolling_out_sim_tab = array2table(rolling_out_sim_RAS)
    rolling_out_sim_tab.Properties.VariableNames = ["i" "best_RAS_units" [crops(1:3)' "fodder" crops(5:12)'] forages' trees' animals' "GM_gain_RAS_net" "GM_agr_change" "GM_RAS" "fval_sim" "obj_fun_sim_val" "share_land_RAS" "share_labour_RAS" "share_water_RAS" "area_RAS" "d_none_or_one_unit_unfeasible"]
    writetable(rolling_out_sim_tab,strcat(output_directory,"rolling_out_sim_RAS_only_ras_sub_",string(ras_sub),"_emulation.txt"))

end

