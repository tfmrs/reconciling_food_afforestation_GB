    %%%(4) Simulation
 %   continue
    k = 0
%    gvec = unique([0 RASmap.units(i)])
 %%type of sim choice




    if type_sim == "RAS_all_delta_SLQ_BL_lowres"
        rolling_out_sim_RAS_by_unit = []

        for g = sort(unique([0:gres:gfeas gfeas 1:5]))
%         for g = 0:100
        %no RAS included as g = 0
%OBS 07/05: 1 to 5 units included to avoid underestimation of viability
%rate
        %            cd 'G:\LEEP\Sustainable_Prawn'
            %optim_quad_PMP_RAS_for_MRU_sim_15_11_23_no_delta
            %optim_quad_PMP_RAS_for_MRU_sim_15_11_23_no_delta__with_CAPEX_15_01_24
            %previous: did not worked, cut name to below
%Note 15/02: since sim is not activated for cropless_&_forageless, else =
%cropless_&_forage
            if pixel_class == "crop_&_forage"
                optim_quad_PMP_RAS_for_MRU_sim_CAPEX_water_lab_SLQ_BL_23_06_25
            else
                optim_quad_PMP_RAS_for_for_onl_CAPEX_water_lab_SLQ_BL_23_06_25
            end    
%            cd 'G:\LEEP\Sustainable_Prawn\Data\'
            %pixels without space for RAS in current g, exit RAS units loop
             if (string(exitflag_sim) == "NoFeasiblePointFound")
                break
            end
        end
        
        if (string(exitflag_sim) == "NoFeasiblePointFound" & g == 1)
            d_none_or_one_unit_unfeasible = 1
            rolling_out_sim_RAS = [rolling_out_sim_RAS; rolling_out_sim_RAS_by_unit(g,:) d_none_or_one_unit_unfeasible]
%here the previous line is used (last feasible optim); notice that since g starts at zero, then number of current line is g+1 and
%of previous is g+1-1 = g
        else 
%%This was introduced in 03/04, because with NM-LQ, g = 0 may be unfeasible (GM does not cover fixed cost)            
             if (string(exitflag_sim) == "NoFeasiblePointFound" & g == 0)
                d_none_or_one_unit_unfeasible = 1
%                rolling_out_sim_RAS = [rolling_out_sim_RAS; i 0 repelem(NaN,27) d_none_or_one_unit_unfeasible]
                sollives_target = [sollives_1(id_act_forage)*sol_target.area_forage(id_act_forage);sollives_2(id_act_forage)*sol_target.area_forage(id_act_forage);sollives_3(id_act_forage)*sol_target.area_forage(id_act_forage)]
            if treeless == 0 & d_cropless == 0
                rolling_out_sim_RAS = [rolling_out_sim_RAS ; [i 0 sol_target.area_crop' sol_target.area_forage' sol_target.area_tree' sollives_target' 0 0 0 fval_target fval_target 0 0 0 0 d_none_or_one_unit_unfeasible]]
            end
            if treeless == 0 & d_cropless == 1
                rolling_out_sim_RAS = [rolling_out_sim_RAS ; [i 0 repelem(0,12) sol_target.area_forage' sol_target.area_tree' sollives_target' 0 0 0 fval_target fval_target 0 0 0 0 d_none_or_one_unit_unfeasible]]
            end
            if treeless == 1 & d_cropless == 0
                rolling_out_sim_RAS = [rolling_out_sim_RAS ; [i 0 sol_target.area_crop' sol_target.area_forage' repelem(0,2) sollives_target' 0 0 0 fval_target fval_target 0 0 0 0 d_none_or_one_unit_unfeasible]]
            end
            if treeless == 1 & d_cropless == 1
                rolling_out_sim_RAS = [rolling_out_sim_RAS ; [i 0 repelem(0,12) sol_target.area_forage' repelem(0,2) sollives_target' 0 0 0 fval_target fval_target 0 0 0 0 d_none_or_one_unit_unfeasible]]
            end

            %here the BL is used
            else
                d_none_or_one_unit_unfeasible = 0
%min added to avoid more than one optimal; 23/05/25 [26/05/25: repaired, GM
%now position 23]
                rolling_out_sim_RAS = [rolling_out_sim_RAS; rolling_out_sim_RAS_by_unit(min(find(rolling_out_sim_RAS_by_unit(:,23) == max(rolling_out_sim_RAS_by_unit(:,23)))),:) d_none_or_one_unit_unfeasible]

    %this includes also cases with current g unfeasible as they have not
    %updated rolling_out_sim_RAS_unit (so will optim on g = 0 to g-1)
               %storing one unit
%               rolling_out_sim_RAS_one_unit = [rolling_out_sim_RAS_one_unit; [rolling_out_sim_RAS_by_unit(2,:)]]

        end
        end

    end

%%%%%%%%%%%%%%%%%%NEW SIMS 2025

    if type_sim == "RAS_subsidy_fixed_unit"
        rolling_out_sim_RAS_by_unit = []

        for g = sort(unique([0:gres:gfeas gfeas 1:5]))
%         for g = 0:100
        %no RAS included as g = 0
%OBS 07/05: 1 to 5 units included to avoid underestimation of viability
%rate
        %            cd 'G:\LEEP\Sustainable_Prawn'
            %optim_quad_PMP_RAS_for_MRU_sim_15_11_23_no_delta
            %optim_quad_PMP_RAS_for_MRU_sim_15_11_23_no_delta__with_CAPEX_15_01_24
            %previous: did not worked, cut name to below
%Note 15/02: since sim is not activated for cropless_&_forageless, else =
%cropless_&_forage
            if pixel_class == "crop_&_forage"
                %optim_quad_PMP_RAS_subRAS_fixunit_SLQ_BL_08_01_25
                optim_quad_PMP_RAS_subRAS_fixunit_SLQ_BL_05_06_25
            else
                %optim_quad_PMP_RAS_for_onl_subRAS_fixunit_SLQ_BL_08_01_25
                optim_quad_PMP_RAS_for_onl_subRAS_fixunit_SLQ_BL_05_06_25
            end    
%            cd 'G:\LEEP\Sustainable_Prawn\Data\'
            %pixels without space for RAS in current g, exit RAS units loop
             if (string(exitflag_sim) == "NoFeasiblePointFound")
                break
            end
        end
        
        if (string(exitflag_sim) == "NoFeasiblePointFound" & g == 1)
            d_none_or_one_unit_unfeasible = 1
            rolling_out_sim_RAS = [rolling_out_sim_RAS; rolling_out_sim_RAS_by_unit(g,:) d_none_or_one_unit_unfeasible]
%here the previous line is used (last feasible optim); notice that since g starts at zero, then number of current line is g+1 and
%of previous is g+1-1 = g
        else 
%%This was introduced in 03/04, because with NM-LQ, g = 0 may be unfeasible (GM does not cover fixed cost)            
             if (string(exitflag_sim) == "NoFeasiblePointFound" & g == 0)
                d_none_or_one_unit_unfeasible = 1
%                rolling_out_sim_RAS = [rolling_out_sim_RAS; i 0 repelem(NaN,27) d_none_or_one_unit_unfeasible]
                sollives_target = [sollives_1(id_act_forage)*sol_target.area_forage(id_act_forage);sollives_2(id_act_forage)*sol_target.area_forage(id_act_forage);sollives_3(id_act_forage)*sol_target.area_forage(id_act_forage)]
            if treeless == 0 & d_cropless == 0
                rolling_out_sim_RAS = [rolling_out_sim_RAS ; [i sol_target.area_crop' sol_target.area_forage' sol_target.area_tree' sollives_target' 0 0 0 fval_target fval_target 0 0 0 0 d_none_or_one_unit_unfeasible]]
            end
            if treeless == 0 & d_cropless == 1
                rolling_out_sim_RAS = [rolling_out_sim_RAS ; [i repelem(0,12) sol_target.area_forage' sol_target.area_tree' sollives_target' 0 0 0 fval_target fval_target 0 0 0 0 d_none_or_one_unit_unfeasible]]
            end
            if treeless == 1 & d_cropless == 1
                rolling_out_sim_RAS = [rolling_out_sim_RAS ; [i repelem(0,12) sol_target.area_forage' repelem(0,2) sollives_target' 0 0 0 fval_target fval_target 0 0 0 0 d_none_or_one_unit_unfeasible]]
            end
                %here the BL is used
            else
                d_none_or_one_unit_unfeasible = 0
%min added to avoid more than one optimal; 23/05/25 [26/05/25: repaired, GM
%now position 23]
                rolling_out_sim_RAS = [rolling_out_sim_RAS; rolling_out_sim_RAS_by_unit(min(find(rolling_out_sim_RAS_by_unit(:,23) == max(rolling_out_sim_RAS_by_unit(:,23)))),:) d_none_or_one_unit_unfeasible]

    %this includes also cases with current g unfeasible as they have not
    %updated rolling_out_sim_RAS_unit (so will optim on g = 0 to g-1)
               %storing one unit
%               rolling_out_sim_RAS_one_unit = [rolling_out_sim_RAS_one_unit; [rolling_out_sim_RAS_by_unit(2,:)]]

        end
        end

    end

%06/05/2025
    if type_sim == "RAS_subsidy_fixed_unit_two"
        rolling_out_sim_RAS_by_unit = []

        for g = sort(unique([0:gres:gfeas gfeas 1:5]))
%         for g = 0:100
        %no RAS included as g = 0
%OBS 07/05: 1 to 5 units included to avoid underestimation of viability
%rate
        %            cd 'G:\LEEP\Sustainable_Prawn'
            %optim_quad_PMP_RAS_for_MRU_sim_15_11_23_no_delta
            %optim_quad_PMP_RAS_for_MRU_sim_15_11_23_no_delta__with_CAPEX_15_01_24
            %previous: did not worked, cut name to below
%Note 15/02: since sim is not activated for cropless_&_forageless, else =
%cropless_&_forage
            if pixel_class == "crop_&_forage"
                %optim_quad_PMP_RAS_subRAS_fixunit_SLQ_BL_08_01_25
%                optim_quad_PMP_RAS_subRAS_fixutwo_SLQ_BL_05_06_25
                optim_quad_PMP_RAS_subRAS_fixutwo_SLQ_BL_16_07_25

            else
                %optim_quad_PMP_RAS_for_onl_subRAS_fixunit_SLQ_BL_08_01_25
%                optim_quad_PMP_RAS_for_onl_subRAS_fixutwo_SLQ_BL_05_06_25
                optim_quad_PMP_RAS_for_onl_subRAS_fixutwo_SLQ_BL_16_07_25

            end    
%            cd 'G:\LEEP\Sustainable_Prawn\Data\'
            %pixels without space for RAS in current g, exit RAS units loop
             if (string(exitflag_sim) == "NoFeasiblePointFound")
                break
            end
        end
        
        if (string(exitflag_sim) == "NoFeasiblePointFound" & g == 1)
            d_none_or_one_unit_unfeasible = 1
            rolling_out_sim_RAS = [rolling_out_sim_RAS; rolling_out_sim_RAS_by_unit(g,:) d_none_or_one_unit_unfeasible]
%here the previous line is used (last feasible optim); notice that since g starts at zero, then number of current line is g+1 and
%of previous is g+1-1 = g
        else 
%%This was introduced in 03/04, because with NM-LQ, g = 0 may be unfeasible (GM does not cover fixed cost)            
             if (string(exitflag_sim) == "NoFeasiblePointFound" & g == 0)
                d_none_or_one_unit_unfeasible = 1
%                rolling_out_sim_RAS = [rolling_out_sim_RAS; i 0 repelem(NaN,27) d_none_or_one_unit_unfeasible]
                sollives_target = [sollives_1(id_act_forage)*sol_target.area_forage(id_act_forage);sollives_2(id_act_forage)*sol_target.area_forage(id_act_forage);sollives_3(id_act_forage)*sol_target.area_forage(id_act_forage)]
            if treeless == 0 & d_cropless == 0
                rolling_out_sim_RAS = [rolling_out_sim_RAS ; [i sol_target.area_crop' sol_target.area_forage' sol_target.area_tree' sollives_target' 0 0 0 fval_target fval_target 0 0 0 0 d_none_or_one_unit_unfeasible]]
            end
            if treeless == 0 & d_cropless == 1
                rolling_out_sim_RAS = [rolling_out_sim_RAS ; [i repelem(0,12) sol_target.area_forage' sol_target.area_tree' sollives_target' 0 0 0 fval_target fval_target 0 0 0 0 d_none_or_one_unit_unfeasible]]
            end
            if treeless == 1 & d_cropless == 1
                rolling_out_sim_RAS = [rolling_out_sim_RAS ; [i repelem(0,12) sol_target.area_forage' repelem(0,2) sollives_target' 0 0 0 fval_target fval_target 0 0 0 0 d_none_or_one_unit_unfeasible]]
            end
                %here the BL is used
            if treeless == 1 & d_cropless == 0
                rolling_out_sim_RAS = [rolling_out_sim_RAS ; [i sol_target.area_crop' sol_target.area_forage' repelem(0,2) sollives_target' 0 0 0 fval_target fval_target 0 0 0 0 d_none_or_one_unit_unfeasible]]
            end

             else
                d_none_or_one_unit_unfeasible = 0
%min added to avoid more than one optimal; 23/05/25 [26/05/25: repaired, GM
%now position 23]
                rolling_out_sim_RAS = [rolling_out_sim_RAS; rolling_out_sim_RAS_by_unit(min(find(rolling_out_sim_RAS_by_unit(:,23) == max(rolling_out_sim_RAS_by_unit(:,23)))),:) d_none_or_one_unit_unfeasible]

    %this includes also cases with current g unfeasible as they have not
    %updated rolling_out_sim_RAS_unit (so will optim on g = 0 to g-1)
               %storing one unit
%               rolling_out_sim_RAS_one_unit = [rolling_out_sim_RAS_one_unit; [rolling_out_sim_RAS_by_unit(2,:)]]

        end
        end

    end




%14/01/25
    if type_sim == "RAS_aside_nocalconst_sub_fix_unit"
        rolling_out_sim_RAS_by_unit = []
        topup_set_aside = tab_ewco_ac.value(find(tab_ewco_ac.i==i))
        for g = sort(unique([0:gres:gfeas gfeas 1:5]))
            %no RAS included as g = 0
%        cd 'D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\'
         %Note 15/02: since sim is not activated for cropless_&_forageless, else =
    %cropless_&_forage
            if pixel_class == "crop_&_forage"
               optim_quad_PMP_RAS_for_MRU_05_06_25_aside_subRAS_fixunit
            else
                optim_quad_PMP_RAS_for_MRU_05_06_25_aside_nfo_subRAS_fixu
            end    
%            cd 'G:\LEEP\Sustainable_Prawn\Data\'
%pixels without space for RAS in current g, exit RAS units loop
             if (string(exitflag_sim) == "NoFeasiblePointFound")
                break
            end
        end

        %negation of (string(exitflag_sim) == "NoFeasiblePointFound" & g == 0)
        if (string(exitflag_sim) ~= "NoFeasiblePointFound" | g ~= 0)
            fval_sim_maxx = rolling_out_sim_RAS_by_unit(find(rolling_out_sim_RAS_by_unit(:,23)==max(rolling_out_sim_RAS_by_unit(:,23))),26) 
        end
        %importing RAS-only info
        %load("D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Data\sim_PMP_EE_woodquad_2grants\workspace_wageREP_RAS_lowres_default_20.2822__2025_05_30_12_33_14_23_05_25")
        if ras_sub == 0.5
            rolling_ras_only = readmatrix(strcat(output_directory,"rolling_out_sim_RAS_only_ras_sub_0.5_emulation.txt"))
        else
            rolling_ras_only = readmatrix(strcat(output_directory,"rolling_out_sim_RAS_only_ras_sub_1_emulation.txt"))
        end    
        rolling_ras_only = array2table(rolling_ras_only)
        rolling_ras_only.Properties.VariableNames = ["i" "best_RAS_units" [crops(1:3)' "fodder" crops(5:12)'] forages' trees' animals' "GM_gain_RAS_net" "GM_agr_change" "GM_RAS" "fval_sim" "obj_fun_sim_val" "share_land_RAS" "share_labour_RAS" "share_water_RAS" "area_RAS" "d_none_or_one_unit_unfeasible"]

        rolling_aside = readmatrix(strcat(output_directory,"rolling_out_sim_wood_only_emulation.txt"))
        rolling_aside = array2table(rolling_aside)
        rolling_aside.Properties.VariableNames = ["i" [crops(1:3)' "fodder" crops(5:12)'] forages' trees' animals' "GM_gain_aside_net" "fval_sim" "obj_fun_sim_val" "GM_agric_no_aside" "sub_aside" "kcal_sim" "kcal_BL" "share_land_set_aside" "share_labour_set_aside" "share_water_set_aside"]

        if (string(exitflag_sim) == "NoFeasiblePointFound" & g == 1)
            d_none_or_one_unit_unfeasible = 1
            if (fval_sim_maxx - rolling_aside.fval_sim(find(rolling_aside.i==i))) < 0
            %without RAS [impose the decision in the simulation without RAS, which may be or not leaving wood program]        
                rolling_out_sim_RAS = [rolling_out_sim_RAS; [i 0 table2array(rolling_aside(find(rolling_aside.i==i),2:22)) NaN NaN rolling_aside.fval_sim(find(rolling_aside.i==i)) rolling_aside.obj_fun_sim_val(find(rolling_aside.i==i)) repelem(0,4) rolling_aside.kcal_sim(find(rolling_aside.i==i)) rolling_aside.kcal_BL(find(rolling_aside.i==i)) rolling_aside.share_land_set_aside(find(rolling_aside.i==i)) rolling_aside.share_labour_set_aside(find(rolling_aside.i==i)) rolling_aside.share_water_set_aside(find(rolling_aside.i==i)) 0 rolling_aside.sub_aside(find(rolling_aside.i==i)) d_none_or_one_unit_unfeasible]]
            else
            %with RAS       
                rolling_out_sim_RAS = [rolling_out_sim_RAS; rolling_out_sim_RAS_by_unit(g,:) d_none_or_one_unit_unfeasible]
            end
            %here the previous line is used (last feasible optim); notice that since g starts at zero, then number of current line is g+1 and
%of previous is g+1-1 = g
        else 
%%This was introduced in 03/04, because with NM-LQ, g = 0 may be unfeasible (GM does not cover fixed cost)            
             if (string(exitflag_sim) == "NoFeasiblePointFound" & g == 0)
                d_none_or_one_unit_unfeasible = 1
%                rolling_out_sim_RAS = [rolling_out_sim_RAS; i 0 repelem(NaN,27) d_none_or_one_unit_unfeasible]
                rolling_out_sim_RAS = [rolling_out_sim_RAS; [i 0 table2array(rolling_aside(find(rolling_aside.i==i),2:22)) NaN NaN rolling_aside.fval_sim(find(rolling_aside.i==i)) rolling_aside.obj_fun_sim_val(find(rolling_aside.i==i)) repelem(0,4) rolling_aside.kcal_sim(find(rolling_aside.i==i)) rolling_aside.kcal_BL(find(rolling_aside.i==i)) rolling_aside.share_land_set_aside(find(rolling_aside.i==i)) rolling_aside.share_labour_set_aside(find(rolling_aside.i==i)) rolling_aside.share_water_set_aside(find(rolling_aside.i==i)) 0 rolling_aside.sub_aside(find(rolling_aside.i==i)) d_none_or_one_unit_unfeasible]]
                %here aside is imposed (as it already contains decision of
                %aside program uptake)
            
             else
                d_none_or_one_unit_unfeasible = 0
                %this includes also cases with current g unfeasible as they have not
    %updated rolling_out_sim_RAS_unit (so will optim on g = 0 to g-1)
               %storing one unit
               rolling_out_sim_RAS_one_unit = [rolling_out_sim_RAS_one_unit; [rolling_out_sim_RAS_by_unit(2,:)]]

               fval_sim_raso = rolling_ras_only.fval_sim(find(rolling_ras_only.i==i)) 
                GM_gain_aside_net = fval_sim_maxx - fval_sim_raso   
                if GM_gain_aside_net < 0
            %without woodland program        
                    rolling_out_sim_RAS = [rolling_out_sim_RAS ; [table2array(rolling_ras_only(find(rolling_ras_only.i==i),1:31)) repelem(0,6) sub_aside d_none_or_one_unit_unfeasible]]
                else
            %with woodland program        
                    rolling_out_sim_RAS = [rolling_out_sim_RAS; rolling_out_sim_RAS_by_unit(find(rolling_out_sim_RAS_by_unit(:,23) == max(rolling_out_sim_RAS_by_unit(:,23))),:) d_none_or_one_unit_unfeasible]
                end
                end

    end
    end



%09/01, 16/01, 22/04/24, 06/06/2024
%09/01, 16/01, 22/04/24, 06/06/2024
%09/01, 16/01, 22/04/24, 06/06/2024, 04/11/24, 23/05/25
    if type_sim == "RAS_all_delta_set_aside_nocalconstraint_wq"
        rolling_out_sim_RAS_by_unit = []
        topup_set_aside = tab_ewco_ac.value(find(tab_ewco_ac.i==i))
        for g = sort(unique([0:gres:gfeas gfeas 1:5]))
            %no RAS included as g = 0
%        cd 'D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\'
         %Note 15/02: since sim is not activated for cropless_&_forageless, else =
    %cropless_&_forage
            if pixel_class == "crop_&_forage"
               optim_quad_PMP_RAS_for_MRU_24_06_25_aside_CAPEX_SLQ_BL_nocalcon
            else
                optim_quad_PMP_RAS_for_MRU_24_06_25_aside_C_nfo_SLQ_BL_nocalcon
            end    
%            cd 'G:\LEEP\Sustainable_Prawn\Data\'
%pixels without space for RAS in current g, exit RAS units loop
             if (string(exitflag_sim) == "NoFeasiblePointFound")
                break
            end
        end
        if (string(exitflag_sim) ~= "NoFeasiblePointFound" | g ~= 0)
            fval_sim_maxx = rolling_out_sim_RAS_by_unit(find(rolling_out_sim_RAS_by_unit(:,23)==max(rolling_out_sim_RAS_by_unit(:,23))),26) 
        end
        %importing RAS-only info
        %load("D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Data\sim_PMP_EE_woodquad_2grants\workspace_wageREP_RAS_lowres_default_20.2822__2025_05_30_12_33_14_23_05_25")
        rolling_ras_only = readmatrix(strcat(output_directory,"rolling_out_sim_RAS_only_ras_sub_0_emulation.txt"))
        rolling_ras_only = array2table(rolling_ras_only)
        rolling_ras_only.Properties.VariableNames = ["i" "best_RAS_units" [crops(1:3)' "fodder" crops(5:12)'] forages' trees' animals' "GM_gain_RAS_net" "GM_agr_change" "GM_RAS" "fval_sim" "obj_fun_sim_val" "share_land_RAS" "share_labour_RAS" "share_water_RAS" "area_RAS" "d_none_or_one_unit_unfeasible"]

        rolling_aside = readmatrix(strcat(output_directory,"rolling_out_sim_wood_only_emulation"))
        rolling_aside = array2table(rolling_aside)
        rolling_aside.Properties.VariableNames = ["i" [crops(1:3)' "fodder" crops(5:12)'] forages' trees' animals' "GM_gain_aside_net" "fval_sim" "obj_fun_sim_val" "GM_agric_no_aside" "sub_aside" "kcal_sim" "kcal_BL" "share_land_set_aside" "share_labour_set_aside" "share_water_set_aside"]

        if (string(exitflag_sim) == "NoFeasiblePointFound" & g == 1)
            d_none_or_one_unit_unfeasible = 1
            if (fval_sim_maxx - rolling_aside.fval_sim(find(rolling_aside.i==i))) < 0
            %without RAS [impose the decision in the simulation without RAS, which may be or not leaving wood program]        
                    rolling_out_sim_RAS = [rolling_out_sim_RAS; [i 0 table2array(rolling_aside(find(rolling_aside.i==i),2:22)) NaN NaN rolling_aside.fval_sim(find(rolling_aside.i==i)) rolling_aside.obj_fun_sim_val(find(rolling_aside.i==i)) repelem(0,4) rolling_aside.kcal_sim(find(rolling_aside.i==i)) rolling_aside.kcal_BL(find(rolling_aside.i==i)) rolling_aside.share_land_set_aside(find(rolling_aside.i==i)) rolling_aside.share_labour_set_aside(find(rolling_aside.i==i)) rolling_aside.share_water_set_aside(find(rolling_aside.i==i)) 0 rolling_aside.sub_aside(find(rolling_aside.i==i)) d_none_or_one_unit_unfeasible]]
            else
            %with RAS        
                rolling_out_sim_RAS = [rolling_out_sim_RAS; rolling_out_sim_RAS_by_unit(g,:) d_none_or_one_unit_unfeasible]
            end
            %here the previous line is used (last feasible optim); notice that since g starts at zero, then number of current line is g+1 and
%of previous is g+1-1 = g
        else 
%%This was introduced in 03/04, because with NM-LQ, g = 0 may be unfeasible (GM does not cover fixed cost)            
             if (string(exitflag_sim) == "NoFeasiblePointFound" & g == 0)
                d_none_or_one_unit_unfeasible = 1
%                rolling_out_sim_RAS = [rolling_out_sim_RAS; i 0 repelem(NaN,27) d_none_or_one_unit_unfeasible]
                    rolling_out_sim_RAS = [rolling_out_sim_RAS; [i 0 table2array(rolling_aside(find(rolling_aside.i==i),2:22)) NaN NaN rolling_aside.fval_sim(find(rolling_aside.i==i)) rolling_aside.obj_fun_sim_val(find(rolling_aside.i==i)) repelem(0,4) rolling_aside.kcal_sim(find(rolling_aside.i==i)) rolling_aside.kcal_BL(find(rolling_aside.i==i)) rolling_aside.share_land_set_aside(find(rolling_aside.i==i)) rolling_aside.share_labour_set_aside(find(rolling_aside.i==i)) rolling_aside.share_water_set_aside(find(rolling_aside.i==i)) 0 rolling_aside.sub_aside(find(rolling_aside.i==i)) d_none_or_one_unit_unfeasible]]
                %here aside only imposed
             else
                d_none_or_one_unit_unfeasible = 0
                %this includes also cases with current g unfeasible as they have not
    %updated rolling_out_sim_RAS_unit (so will optim on g = 0 to g-1)
               %storing one unit
               rolling_out_sim_RAS_one_unit = [rolling_out_sim_RAS_one_unit; [rolling_out_sim_RAS_by_unit(2,:)]]

               fval_sim_raso = rolling_ras_only.fval_sim(find(rolling_ras_only.i==i)) 
                GM_gain_aside_net = fval_sim_maxx - fval_sim_raso   
                if GM_gain_aside_net < 0
            %without woodland program        
                    rolling_out_sim_RAS = [rolling_out_sim_RAS ; [table2array(rolling_ras_only(find(rolling_ras_only.i==i),1:31)) repelem(0,6) sub_aside d_none_or_one_unit_unfeasible]]
                else
            %with woodland program        
                    rolling_out_sim_RAS = [rolling_out_sim_RAS; rolling_out_sim_RAS_by_unit(find(rolling_out_sim_RAS_by_unit(:,23) == max(rolling_out_sim_RAS_by_unit(:,23))),:) d_none_or_one_unit_unfeasible]
                end
                end

    end
    end


%set-aside only WITH constraint, GIS subsidy
    if type_sim == "set_aside_only_gis_nocalconstraint_EWCO"
%        cd 'D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\'
%%%Running NPV forestry, broadleaved, with zero subsidy
        topup_set_aside = tab_ewco_ac.value(find(tab_ewco_ac.i==i))

        if pixel_class == "crop_&_forage"
                optim_quad_PMP_no_delta__with_CAPEX_aside_only_ncalc_22_05_25
        else
                optim_quad_PMP_no_delta_CAPEX_aside_only_foron_ncalc_22_05_25
        end
        sollives_target = [sollives_1(id_act_forage)*sol_target.area_forage(id_act_forage);sollives_2(id_act_forage)*sol_target.area_forage(id_act_forage);sollives_3(id_act_forage)*sol_target.area_forage(id_act_forage)]

        if string(exitflag_sim) == "NoFeasiblePointFound"
            kcal_BL = table2array(area_observed_crop(i,id_act_crop))*vec_kcal_crop(id_act_crop) + table2array(area_observed_forage(i,id_act_forage))*mat_kcal_m(i,id_act_forage)'
            rolling_out_sim_aside = [rolling_out_sim_aside; i sol_target.area_crop' sol_target.area_forage' sol_target.area_tree' sollives_target' 0 fval_target fval_target fval_target 0 kcal_BL kcal_BL 0 0 0]
        else           
        %included 08/07: opt-out of scheme if losing profit
            if GM_gain_aside_net < 0
                %rolling_out_sim_aside = [rolling_out_sim_aside ; [i sol_sim.area_crop' sol_sim.area_forage' sollives' GM_gain_aside_net fval_sim obj_fun_sim_val GM_agric_no_aside sub_aside area_set_aside_sim kcal_sim kcal_BL share_land_set_aside share_labour_set_aside share_water_set_aside]]

            if treeless == 0 & d_cropless == 0
                rolling_out_sim_aside(height(rolling_out_sim_aside),:) = [i sol_target.area_crop' sol_target.area_forage' sol_target.area_tree' sollives_target' 0 fval_target fval_target fval_target 0 kcal_BL kcal_BL 0 0 0]
            end
            if treeless == 0 & d_cropless == 1
                rolling_out_sim_aside(height(rolling_out_sim_aside),:) = [i repelem(0,12) sol_target.area_forage' sol_target.area_tree' sollives_target' 0 fval_target fval_target fval_target 0 kcal_BL kcal_BL 0 0 0]
            end
            if treeless == 1 & d_cropless == 0
                rolling_out_sim_aside(height(rolling_out_sim_aside),:) = [i sol_target.area_crop' sol_target.area_forage' repelem(0,2) sollives_target' 0 fval_target fval_target fval_target 0 kcal_BL kcal_BL 0 0 0]
            end
            if treeless == 1 & d_cropless == 1
                rolling_out_sim_aside(height(rolling_out_sim_aside),:) = [i repelem(0,12) sol_target.area_forage' repelem(0,2) sollives_target' 0 fval_target fval_target fval_target 0 kcal_BL kcal_BL 0 0 0]
            end
            

            
            end
        end
        %cd 'G:\LEEP\Sustainable_Prawn\Data\'
    end



    if type_sim == "RAS_aside_nocalconst_sub_fix_unit_two_wq"
        topup_set_aside = tab_ewco_ac.value(find(tab_ewco_ac.i==i))
        rolling_out_sim_RAS_by_unit = []
        for g = sort(unique([0:gres:gfeas gfeas 1:5]))
            %no RAS included as g = 0
%        cd 'D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\'
         %Note 15/02: since sim is not activated for cropless_&_forageless, else =
    %cropless_&_forage
            if pixel_class == "crop_&_forage"
               optim_quad_PMP_RAS_for_MRU_04_06_25_aside_subRAS_fixtwo
            else
                optim_quad_PMP_RAS_for_MRU_04_06_25_aside_nfo_subR_fixtwo
            end    
%            cd 'G:\LEEP\Sustainable_Prawn\Data\'
%pixels without space for RAS in current g, exit RAS units loop
             if (string(exitflag_sim) == "NoFeasiblePointFound")
                break
            end
        end
        if (string(exitflag_sim) ~= "NoFeasiblePointFound" | g ~= 0)
            fval_sim_maxx = rolling_out_sim_RAS_by_unit(find(rolling_out_sim_RAS_by_unit(:,23)==max(rolling_out_sim_RAS_by_unit(:,23))),26) 
        end
        %importing RAS-only info
        %load("D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Data\sim_PMP_EE_woodquad_2grants\workspace_wageREP_RAS_lowres_default_20.2822__2025_05_30_12_33_14_23_05_25")
        switch ras_sub
            case 2
            rolling_ras_only = readmatrix(strcat(output_directory,"rolling_out_sim_RAS_only_ras_sub_2_emulation.txt"))
            case 1.5
            rolling_ras_only = readmatrix(strcat(output_directory,"rolling_out_sim_RAS_only_ras_sub_1.5_emulation.txt"))
        end
                rolling_ras_only = array2table(rolling_ras_only)
        rolling_ras_only.Properties.VariableNames = ["i" "best_RAS_units" [crops(1:3)' "fodder" crops(5:12)'] forages' trees' animals' "GM_gain_RAS_net" "GM_agr_change" "GM_RAS" "fval_sim" "obj_fun_sim_val" "share_land_RAS" "share_labour_RAS" "share_water_RAS" "area_RAS" "d_none_or_one_unit_unfeasible"]

        rolling_aside = readmatrix(strcat(output_directory,"rolling_out_sim_wood_only_emulation.txt"))
        rolling_aside = array2table(rolling_aside)
        rolling_aside.Properties.VariableNames = ["i" [crops(1:3)' "fodder" crops(5:12)'] forages' trees' animals' "GM_gain_aside_net" "fval_sim" "obj_fun_sim_val" "GM_agric_no_aside" "sub_aside" "kcal_sim" "kcal_BL" "share_land_set_aside" "share_labour_set_aside" "share_water_set_aside"]

        if (string(exitflag_sim) == "NoFeasiblePointFound" & g == 1)
            d_none_or_one_unit_unfeasible = 1
            if (fval_sim_maxx - rolling_aside.fval_sim(find(rolling_aside.i==i))) < 0
            %without RAS [impose the decision in the simulation without RAS, which may be or not leaving wood program]        
                rolling_out_sim_RAS = [rolling_out_sim_RAS; [i 0 table2array(rolling_aside(find(rolling_aside.i==i),2:22)) NaN NaN rolling_aside.fval_sim(find(rolling_aside.i==i)) rolling_aside.obj_fun_sim_val(find(rolling_aside.i==i)) repelem(0,4) rolling_aside.kcal_sim(find(rolling_aside.i==i)) rolling_aside.kcal_BL(find(rolling_aside.i==i)) rolling_aside.share_land_set_aside(find(rolling_aside.i==i)) rolling_aside.share_labour_set_aside(find(rolling_aside.i==i)) rolling_aside.share_water_set_aside(find(rolling_aside.i==i)) 0 rolling_aside.sub_aside(find(rolling_aside.i==i)) d_none_or_one_unit_unfeasible]]
            else
            %with RAS       
                rolling_out_sim_RAS = [rolling_out_sim_RAS; rolling_out_sim_RAS_by_unit(g,:) d_none_or_one_unit_unfeasible]
            end
            %here the previous line is used (last feasible optim); notice that since g starts at zero, then number of current line is g+1 and
%of previous is g+1-1 = g
        else 
%%This was introduced in 03/04, because with NM-LQ, g = 0 may be unfeasible (GM does not cover fixed cost)            
             if (string(exitflag_sim) == "NoFeasiblePointFound" & g == 0)
                d_none_or_one_unit_unfeasible = 1
%                rolling_out_sim_RAS = [rolling_out_sim_RAS; i 0 repelem(NaN,27) d_none_or_one_unit_unfeasible]
                rolling_out_sim_RAS = [rolling_out_sim_RAS; [i 0 table2array(rolling_aside(find(rolling_aside.i==i),2:22)) NaN NaN rolling_aside.fval_sim(find(rolling_aside.i==i)) rolling_aside.obj_fun_sim_val(find(rolling_aside.i==i)) repelem(0,4) rolling_aside.kcal_sim(find(rolling_aside.i==i)) rolling_aside.kcal_BL(find(rolling_aside.i==i)) rolling_aside.share_land_set_aside(find(rolling_aside.i==i)) rolling_aside.share_labour_set_aside(find(rolling_aside.i==i)) rolling_aside.share_water_set_aside(find(rolling_aside.i==i)) 0 rolling_aside.sub_aside(find(rolling_aside.i==i)) d_none_or_one_unit_unfeasible]]
                %here the BL is used
             else
                d_none_or_one_unit_unfeasible = 0
                %this includes also cases with current g unfeasible as they have not
    %updated rolling_out_sim_RAS_unit (so will optim on g = 0 to g-1)
               %storing one unit
               rolling_out_sim_RAS_one_unit = [rolling_out_sim_RAS_one_unit; [rolling_out_sim_RAS_by_unit(2,:)]]

               fval_sim_raso = rolling_ras_only.fval_sim(find(rolling_ras_only.i==i)) 
                GM_gain_aside_net = fval_sim_maxx - fval_sim_raso   
                if GM_gain_aside_net < 0
            %without woodland program        
                    rolling_out_sim_RAS = [rolling_out_sim_RAS ; [table2array(rolling_ras_only(find(rolling_ras_only.i==i),1:31)) repelem(0,6) sub_aside d_none_or_one_unit_unfeasible]]
                else
            %with woodland program        
                    rolling_out_sim_RAS = [rolling_out_sim_RAS; rolling_out_sim_RAS_by_unit(find(rolling_out_sim_RAS_by_unit(:,23) == max(rolling_out_sim_RAS_by_unit(:,23))),:) d_none_or_one_unit_unfeasible]
                end
                end

    end
    end

