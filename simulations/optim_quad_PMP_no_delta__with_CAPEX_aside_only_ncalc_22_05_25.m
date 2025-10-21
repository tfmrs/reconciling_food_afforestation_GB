
    %%(4)Simulation

    farmProblem_sim = optimproblem('ObjectiveSense','maximize');

    area_crop = optimvar('area_crop',crops,'LowerBound',0);
    area_forage = optimvar('area_forage',forages,'LowerBound',0);

    if treeless == 0
        area_tree = optimvar('area_tree',trees,'LowerBound',0);
    end
    %head = optimvar('head',animals,'LowerBound',0);
    
    if treeless == 0
%        obj_fun_sim = vec_REV_crop(id_act_crop)'*area_crop(id_act_crop) - 1/2*calib_crop(:,1)'*area_crop(id_act_crop).^2 + mat_GM_nofor_forage_m(i,id_act_forage)*area_forage(id_act_forage) - 1/2*calib_forage(:,1)'*area_forage(id_act_forage).^2 + (vec_REV_tree(id_act_tree)+sub_set_aside+topup_set_aside)'*area_tree(id_act_tree) - 1/2*calib_tree(:,1)'*(area_tree(id_act_tree).*z0_vec) - 1/2*calib_tree(:,1)'*area_tree(id_act_tree).^2
%no z0_vec
%        obj_fun_sim = vec_REV_crop(id_act_crop)'*area_crop(id_act_crop) - 1/2*calib_crop(:,1)'*area_crop(id_act_crop).^2 + mat_GM_nofor_forage_m(i,id_act_forage)*area_forage(id_act_forage) - 1/2*calib_forage(:,1)'*area_forage(id_act_forage).^2 + (vec_REV_tree(id_act_tree)+sub_set_aside+topup_set_aside)'*area_tree(id_act_tree) - 1/2*calib_tree(:,1)'*area_tree(id_act_tree).^2
%with incremental subsidy
        obj_fun_sim = vec_REV_crop(id_act_crop)'*area_crop(id_act_crop) - 1/2*calib_crop(:,1)'*area_crop(id_act_crop).^2 + mat_GM_nofor_forage_m(i,id_act_forage)*area_forage(id_act_forage) - 1/2*calib_forage(:,1)'*area_forage(id_act_forage).^2 + vec_REV_tree(id_act_tree)'*area_tree(id_act_tree) + (sub_set_aside+topup_set_aside)'*(ones(1,n_act_tree)*area_tree(id_act_tree) - table2array(area_observed_tree(i,id_act_tree))*ones(n_act_tree,1)) - 1/2*calib_tree(:,1)'*area_tree(id_act_tree).^2

    else
        obj_fun_sim = vec_REV_crop(id_act_crop)'*area_crop(id_act_crop) - 1/2*calib_crop(:,1)'*area_crop(id_act_crop).^2 + mat_GM_nofor_forage_m(i,id_act_forage)*area_forage(id_act_forage) - 1/2*calib_forage(:,1)'*area_forage(id_act_forage).^2
    end

    show(obj_fun_sim)

    if treeless == 0
        %%%%constraints, with trees
        
        %%Area
        %area_const_arable = ones(10,1)'*area <= table2array(area_observed(i,:))*ones(10,1)
%        area_const = ones(n_act_crop,1)'*area_crop(id_act_crop) + ones(n_act_forage,1)'*area_forage(id_act_forage) + ones(n_act_tree,1)'*area_tree(id_act_tree) <= table2array(area_observed_crop(i,id_act_crop))*ones(n_act_crop,1) + table2array(area_observed_forage(i,id_act_forage))*ones(n_act_forage,1) + table2array(area_observed_tree(i,id_act_tree))*ones(n_act_tree,1)
        area_const = ones(n_act_crop,1)'*area_crop(id_act_crop) + ones(n_act_forage,1)'*area_forage(id_act_forage) + ones(n_act_tree,1)'*area_tree(id_act_tree) <= table2array(area_observed_crop(i,id_act_crop))*ones(n_act_crop,1) + table2array(area_observed_forage(i,id_act_forage))*ones(n_act_forage,1) + table2array(area_observed_tree(i,id_act_tree))*ones(n_act_tree,1)
    
        %%Labour
        labour_const = vec_SLR_crop(id_act_crop)'*area_crop(id_act_crop) + mat_SLR_forage_m(i,id_act_forage)*area_forage(id_act_forage) + mat_SLR_tree(id_act_tree)'*area_tree(id_act_tree) <= table2array(area_observed_crop(i,id_act_crop))*vec_SLR_crop(id_act_crop) + table2array(area_observed_forage(i,id_act_forage))*mat_SLR_forage_m(i,id_act_forage)' + table2array(area_observed_tree(i,id_act_tree))*mat_SLR_tree(id_act_tree)

        %%Water
        water_const = vec_water_crop(id_act_crop)'*area_crop(id_act_crop) + mat_water_forage_m(i,id_act_forage)*area_forage(id_act_forage) + mat_water_tree(id_act_tree)'*area_tree(id_act_tree) <= table2array(area_observed_crop(i,id_act_crop))*vec_water_crop(id_act_crop) + table2array(area_observed_forage(i,id_act_forage))*mat_water_forage_m(i,id_act_forage)' + table2array(area_observed_tree(i,id_act_tree))*mat_water_tree(id_act_tree)

        %%EWCO constraint: final woodland area > initial woodland area
        EWCO_const = ones(1,n_act_tree)*area_tree(id_act_tree) >= table2array(area_observed_tree(i,id_act_tree))*ones(n_act_tree,1) + minimum_wood_ha

    else 
        %%%%constraints, without trees
        
        %%Area
        %area_const_arable = ones(10,1)'*area <= table2array(area_observed(i,:))*ones(10,1)
        area_const = ones(n_act_crop,1)'*area_crop(id_act_crop) + ones(n_act_forage,1)'*area_forage(id_act_forage) <= table2array(area_observed_crop(i,id_act_crop))*ones(n_act_crop,1) + table2array(area_observed_forage(i,id_act_forage))*ones(n_act_forage,1)
    
        %%Labour
        labour_const = vec_SLR_crop(id_act_crop)'*area_crop(id_act_crop) + mat_SLR_forage_m(i,id_act_forage)*area_forage(id_act_forage) <= table2array(area_observed_crop(i,id_act_crop))*vec_SLR_crop(id_act_crop) + table2array(area_observed_forage(i,id_act_forage))*mat_SLR_forage_m(i,id_act_forage)'
    
        %%Water
        water_const = vec_water_crop(id_act_crop)'*area_crop(id_act_crop) + mat_water_forage_m(i,id_act_forage)*area_forage(id_act_forage) <= table2array(area_observed_crop(i,id_act_crop))*vec_water_crop(id_act_crop) + table2array(area_observed_forage(i,id_act_forage))*mat_water_forage_m(i,id_act_forage)'
    end


    farmProblem_sim.Objective = obj_fun_sim;
    farmProblem_sim.Constraints.area = area_const;
    farmProblem_sim.Constraints.labour = labour_const;
    farmProblem_sim.Constraints.water = water_const;

    if treeless == 0
        farmProblem_sim.Constraints.EWCO = EWCO_const
    end

    show(farmProblem_sim)



    [sol_sim,fval_sim,exitflag_sim,output_sim,lambda_sim] = solve(farmProblem_sim)
 
   %only for pixels with space for RAS
    if (string(exitflag_sim) ~= "NoFeasiblePointFound")
 
        sollives = [sollives_1(id_act_forage)*sol_sim.area_forage(id_act_forage);sollives_2(id_act_forage)*sol_sim.area_forage(id_act_forage);sollives_3(id_act_forage)*sol_sim.area_forage(id_act_forage)]
    
    %%GM calculation for integer RAS units (obj_fun_sim - obj_fun_RAS +
    %%obj_fun_RAS)
    %%OBS: tolerating 5% error in area_RAS (due to way lambda_RAS is
    %%calculated)


    
        if treeless == 0
%        obj_fun_sim_val = vec_REV_crop(id_act_crop)'*sol_sim.area_crop(id_act_crop) - 1/2*calib_crop(:,1)'*sol_sim.area_crop(id_act_crop).^2 + mat_GM_nofor_forage_m(i,id_act_forage)*sol_sim.area_forage(id_act_forage) - 1/2*calib_forage(:,1)'*sol_sim.area_forage(id_act_forage).^2 + (vec_REV_tree(id_act_tree)+sub_set_aside+topup_set_aside)'*area_tree(id_act_tree) - 1/2*calib_tree(:,1)'*(area_tree(id_act_tree).*z0_vec) - 1/2*calib_tree(:,1)'*area_tree(id_act_tree).^2
%no z0_vec
        obj_fun_sim_val = vec_REV_crop(id_act_crop)'*sol_sim.area_crop(id_act_crop) - 1/2*calib_crop(:,1)'*sol_sim.area_crop(id_act_crop).^2 + mat_GM_nofor_forage_m(i,id_act_forage)*sol_sim.area_forage(id_act_forage) - 1/2*calib_forage(:,1)'*sol_sim.area_forage(id_act_forage).^2 + (vec_REV_tree(id_act_tree)+sub_set_aside+topup_set_aside)'*sol_sim.area_tree(id_act_tree)  - 1/2*calib_tree(:,1)'*sol_sim.area_tree(id_act_tree).^2
    
        else
        obj_fun_sim_val = vec_REV_crop(id_act_crop)'*sol_sim.area_crop(id_act_crop) - 1/2*calib_crop(:,1)'*sol_sim.area_crop(id_act_crop).^2 + mat_GM_nofor_forage_m(i,id_act_forage)*sol_sim.area_forage(id_act_forage) - 1/2*calib_forage(:,1)'*sol_sim.area_forage(id_act_forage).^2 
        end

        if treeless == 0
        landtot = table2array(area_observed_crop(i,id_act_crop))*ones(n_act_crop,1) + table2array(area_observed_forage(i,id_act_forage))*ones(n_act_forage,1) + table2array(area_observed_tree(i,id_act_tree))*ones(n_act_tree,1)
        SLRtot = table2array(area_observed_crop(i,id_act_crop))*vec_SLR_crop(id_act_crop) + table2array(area_observed_forage(i,id_act_forage))*mat_SLR_forage_m(i,id_act_forage)' + table2array(area_observed_tree(i,id_act_tree))*mat_SLR_tree(id_act_tree)
        watertot = table2array(area_observed_crop(i,id_act_crop))*vec_water_crop(id_act_crop) + table2array(area_observed_forage(i,id_act_forage))*mat_water_forage_m(i,id_act_forage)' + table2array(area_observed_tree(i,id_act_tree))*mat_water_tree(id_act_tree)

        share_land_set_aside = (ones(1,n_act_tree)*sol_sim.area_tree(id_act_tree))/landtot
        share_labour_set_aside = (ones(1,n_act_tree)*sol_sim.area_tree(id_act_tree))/SLRtot
        share_water_set_aside = (ones(1,n_act_tree)*sol_sim.area_tree(id_act_tree))/watertot

        else
        landtot = table2array(area_observed_crop(i,id_act_crop))*ones(n_act_crop,1) + table2array(area_observed_forage(i,id_act_forage))*ones(n_act_forage,1)
        SLRtot = table2array(area_observed_crop(i,id_act_crop))*vec_SLR_crop(id_act_crop) + table2array(area_observed_forage(i,id_act_forage))*mat_SLR_forage_m(i,id_act_forage)'
        watertot = table2array(area_observed_crop(i,id_act_crop))*vec_water_crop(id_act_crop) + table2array(area_observed_forage(i,id_act_forage))*mat_water_forage_m(i,id_act_forage)'

        share_land_set_aside = 0
        share_labour_set_aside = 0
        share_water_set_aside = 0

        end

        GM_gain_aside_net = -(fval_target - fval_sim)

        GM_agric_no_aside = vec_REV_crop(id_act_crop)'*sol_sim.area_crop(id_act_crop) - 1/2*calib_crop(:,1)'*sol_sim.area_crop(id_act_crop).^2 + mat_GM_nofor_forage_m(i,id_act_forage)*sol_sim.area_forage(id_act_forage) - 1/2*calib_forage(:,1)'*sol_sim.area_forage(id_act_forage).^2

        if treeless == 0
        sub_aside = (sub_set_aside+topup_set_aside)'*(ones(1,n_act_tree)*sol_sim.area_tree(id_act_tree) - table2array(area_observed_tree(i,id_act_tree))*ones(n_act_tree,1))
        else
        sub_aside = 0
        end    

        kcal_sim = vec_kcal_crop(id_act_crop)'*sol_sim.area_crop(id_act_crop) + mat_kcal_m(i,id_act_forage)*sol_sim.area_forage(id_act_forage)
        kcal_BL = table2array(area_observed_crop(i,id_act_crop))*vec_kcal_crop(id_act_crop) + table2array(area_observed_forage(i,id_act_forage))*mat_kcal_m(i,id_act_forage)'
        
        if treeless == 0
        rolling_out_sim_aside = [rolling_out_sim_aside ; [i sol_sim.area_crop' sol_sim.area_forage' sol_sim.area_tree' sollives' GM_gain_aside_net fval_sim obj_fun_sim_val GM_agric_no_aside sub_aside kcal_sim kcal_BL share_land_set_aside share_labour_set_aside share_water_set_aside]]
        else
        rolling_out_sim_aside = [rolling_out_sim_aside ; [i sol_sim.area_crop' sol_sim.area_forage' repelem(NaN,2) sollives' GM_gain_aside_net fval_sim obj_fun_sim_val GM_agric_no_aside sub_aside kcal_sim kcal_BL share_land_set_aside share_labour_set_aside share_water_set_aside]]
        end
        %rolling_out_sim_RAS_by_unit = [rolling_out_sim_RAS_by_unit ; [i g sol_sim.area_crop' sol_sim.area_forage' sollives' GM_gain_RAS_net (fval_target - fval_sim) (area_RAS*vec_GM_RAS) fval_sim obj_fun_sim_val share_land share_labour area_RAS]]

        %   else
 %       rolling_out_sim_RAS_by_unit = [rolling_out_sim_RAS_by_unit ; [i g repelem(0,24)]]

    end





