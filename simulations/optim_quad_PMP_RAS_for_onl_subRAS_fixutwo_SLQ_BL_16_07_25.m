%%09/01/25, Dummy preventing RAS subsidy with zero unit (already used before in
%%constraints)
d_turn_RAS_on = 1
if g == 0
    d_turn_RAS_on = 0
end

d_turn_RAS_on_two_units = 0
if g >= 2
    d_turn_RAS_on_two_units = 1
end

i_rate = i_rate_out

NPV_RAS = ((1+i_rate)^RAS_lifetime - 1)/(i_rate*(1+i_rate)^RAS_lifetime)

RAS_CAPEX_annuity = RAS_CAPEX*(g-d_turn_RAS_on-d_turn_RAS_on_two_units*(ras_sub-1))/NPV_RAS


labcost_RAS_step = mat_wage_PAYE.ratio_final(i)*12*1*(floor((g-1)/5)+1) + mat_wage_PAYE.ratio_final(i)*12*(1.4)*(floor((g-1)/10)+1)

%NM_BL_LQ = table2array(area_observed_forage(i,id_act_forage))*mat_GM_forage_m(i,id_act_forage)' - activity_shares.total_fixed_cost_ex_lab_pix(i)
if treeless == 0
    NM_BL_LQ = (mat_GM_forage_m(i,id_act_forage))*sol_target.area_forage(id_act_forage) + sol_target.area_tree(id_act_tree)*vec_GM_tree' - activity_shares.total_fixed_cost_ex_lab_pix(i)
else
    NM_BL_LQ = (mat_GM_forage_m(i,id_act_forage))*sol_target.area_forage(id_act_forage) - activity_shares.total_fixed_cost_ex_lab_pix(i)
end

if  RAS_CAPEX*(g-d_turn_RAS_on-d_turn_RAS_on_two_units*(ras_sub-1))*(1-alpha)/(NPV_RAS*delta) <= NM_BL_LQ*d_turn_RAS_on
    %%(4)Simulation

    farmProblem_sim = optimproblem('ObjectiveSense','maximize');

    area_forage = optimvar('area_forage',forages,'LowerBound',0);

    if treeless == 0
        area_tree = optimvar('area_tree',trees,'LowerBound',0);
    end

    area_RAS = g*vec_size_RAS

    if treeless == 0
       obj_fun_sim = mat_GM_nofor_forage_m(i,id_act_forage)*area_forage(id_act_forage) - 1/2*calib_forage(:,1)'*area_forage(id_act_forage).^2 + vec_REV_tree(id_act_tree)'*area_tree(id_act_tree) - 1/2*calib_tree(:,1)'*area_tree(id_act_tree).^2
     else
       obj_fun_sim = mat_GM_nofor_forage_m(i,id_act_forage)*area_forage(id_act_forage) - 1/2*calib_forage(:,1)'*area_forage(id_act_forage).^2
     end

    show(obj_fun_sim)

    %%%%constraints
    
    if treeless == 0
    %%%%constraints, with trees

        %%Area
        %area_const_arable = ones(10,1)'*area <= table2array(area_observed(i,:))*ones(10,1)
        area_const = ones(n_act_forage,1)'*area_forage(id_act_forage) + ones(n_act_tree,1)'*area_tree(id_act_tree) + area_RAS <= table2array(area_observed_forage(i,id_act_forage))*ones(n_act_forage,1) + table2array(area_observed_tree(i,id_act_tree))*ones(n_act_tree,1)
    
        %%Labour
        %labour_const = sum(vec_SLR(1:10)*area) <= sum(vec_SLR(1:10).*table2array(area_observed(i,:)))
        labour_const = mat_SLR_forage_m(i,id_act_forage)*area_forage(id_act_forage) + mat_SLR_tree(id_act_tree)'*area_tree(id_act_tree) + vec_SLR_RAS*g*vec_size_RAS <= table2array(area_observed_forage(i,id_act_forage))*mat_SLR_forage_m(i,id_act_forage)' + table2array(area_observed_tree(i,id_act_tree))*mat_SLR_tree(id_act_tree)
    
        %%%Water
        water_const = mat_water_forage_m(i,id_act_forage)*area_forage(id_act_forage) + mat_water_tree(id_act_tree)'*area_tree(id_act_tree) + vec_water_RAS*area_RAS <= table2array(area_observed_forage(i,id_act_forage))*mat_water_forage_m(i,id_act_forage)' + table2array(area_observed_tree(i,id_act_tree))*mat_water_tree(id_act_tree)
    else
    %%%%constraints, without trees
        %%Area
        %area_const_arable = ones(10,1)'*area <= table2array(area_observed(i,:))*ones(10,1)
        area_const = ones(n_act_forage,1)'*area_forage(id_act_forage) + area_RAS <= table2array(area_observed_forage(i,id_act_forage))*ones(n_act_forage,1)
    
        %%Labour
        %labour_const = sum(vec_SLR(1:10)*area) <= sum(vec_SLR(1:10).*table2array(area_observed(i,:)))
        labour_const = mat_SLR_forage_m(i,id_act_forage)*area_forage(id_act_forage) + vec_SLR_RAS*g*vec_size_RAS <= table2array(area_observed_forage(i,id_act_forage))*mat_SLR_forage_m(i,id_act_forage)'
    
        %%%Water
        water_const = mat_water_forage_m(i,id_act_forage)*area_forage(id_act_forage) + vec_water_RAS*area_RAS <= table2array(area_observed_forage(i,id_act_forage))*mat_water_forage_m(i,id_act_forage)'
    end    


    %%%LQ

    %1.BL,GM
%    NM_BL_LQ = table2array(area_observed_forage(i,id_act_forage))*mat_GM_forage_m(i,id_act_forage)' - activity_shares.total_fixed_cost_ex_lab_pix(i)

if treeless == 0
    NM_AL_LQ = mat_GM_forage_m(i,id_act_forage)*area_forage(id_act_forage) + vec_GM_tree(id_act_tree)'*area_tree(id_act_tree) + area_RAS*vec_GM_RAS_ex_lab - (labcost_RAS_step + RAS_CAPEX_annuity) - activity_shares.total_fixed_cost_ex_lab_pix(i)
else
    NM_AL_LQ = mat_GM_forage_m(i,id_act_forage)*area_forage(id_act_forage) + area_RAS*vec_GM_RAS_ex_lab - (labcost_RAS_step + RAS_CAPEX_annuity) - activity_shares.total_fixed_cost_ex_lab_pix(i)
end 

%3.LQ COND
%    LQ_const = (RAS_CAPEX*g - GM_AL_LQ)/NPV_RAS <= GM_BL_LQ
    LQ_const = RAS_CAPEX*(g-d_turn_RAS_on-d_turn_RAS_on_two_units*(ras_sub-1))*((1-alpha)/NPV_RAS + alpha) <= (NM_AL_LQ + NM_BL_LQ)*d_turn_RAS_on

    %2nd digi
    %    LQ_const = CAPEX_RAS*g*(1-(1-alpha)*(1-1/NPV_RAS)) <= GM_AL + GM_BL

%    DF_const = (RAS_CAPEX*g*(1-alpha)/NPV_RAS)/GM_AL_LQ <= delta 
     %2nd digi
    %    DF_const = (CAPEX_RAS*g*(1-alpha)/NPV_RAS)/GM_AL <= delta

    %one ML likes
%    DF_const = RAS_CAPEX*g*(1-alpha)/(NPV_RAS*delta) <= NM_AL_LQ*d_turn_RAS_on
    %BL on
%    DF_const = RAS_CAPEX*g*(1-alpha)/(NPV_RAS*delta) <= NM_BL_LQ*d_turn_RAS_on


    farmProblem_sim.Objective = obj_fun_sim;
    farmProblem_sim.Constraints.area = area_const;
    farmProblem_sim.Constraints.labour = labour_const;
    farmProblem_sim.Constraints.water = water_const;
    farmProblem_sim.Constraints.LQ = LQ_const;
%    farmProblem_sim.Constraints.DF = DF_const;

    show(farmProblem_sim)

    [sol_sim,fval_sim,exitflag_sim,output_sim,lambda_sim] = solve(farmProblem_sim)
else 
    exitflag_sim = "NoFeasiblePointFound"
end
    
    %only for pixels with space for RAS
    if (string(exitflag_sim) ~= "NoFeasiblePointFound")
 
        sollives = [sollives_1(id_act_forage)*sol_sim.area_forage(id_act_forage);sollives_2(id_act_forage)*sol_sim.area_forage(id_act_forage);sollives_3(id_act_forage)*sol_sim.area_forage(id_act_forage)]
    
    %%GM calculation for integer RAS units (obj_fun_sim - obj_fun_RAS +
    %%obj_fun_RAS)
    %%OBS: tolerating 5% error in area_RAS (due to way lambda_RAS is
    %%calculated)
    
if treeless  ==0
    obj_fun_sim_val = mat_GM_nofor_forage_m(i,id_act_forage)*sol_sim.area_forage(id_act_forage) - 1/2*calib_forage(:,1)'*sol_sim.area_forage(id_act_forage).^2 + vec_REV_tree(id_act_tree)'*sol_sim.area_tree(id_act_tree) - 1/2*calib_tree(:,1)'*sol_sim.area_tree(id_act_tree).^2
    landtot = table2array(area_observed_forage(i,id_act_forage))*ones(n_act_forage,1) + table2array(area_observed_tree(i,id_act_tree))*ones(n_act_tree,1)
else
    obj_fun_sim_val = mat_GM_nofor_forage_m(i,id_act_forage)*sol_sim.area_forage(id_act_forage) - 1/2*calib_forage(:,1)'*sol_sim.area_forage(id_act_forage).^2
    landtot = table2array(area_observed_forage(i,id_act_forage))*ones(n_act_forage,1)
end

        labourtot = table2array(area_observed_forage(i,id_act_forage))*mat_SLR_forage_m(i,id_act_forage)'
        watertot = table2array(area_observed_forage(i,id_act_forage))*mat_water_forage_m(i,id_act_forage)'

        share_land = area_RAS/landtot
        share_labour = area_RAS*vec_SLR_RAS/labourtot
        share_water = area_RAS*vec_water_RAS/watertot
   
%        GM_gain_RAS_net = -(fval_target - fval_sim) + area_RAS *vec_GM_RAS - RAS_CAPEX_annuity

%        GM_gain_RAS_net = -(fval_target - fval_sim) + area_RAS *vec_GM_RAS_ex_lab - (vec_size_RAS*vec_VARCOS_RAS_oplab*(floor((g-1)/5)+1) + vec_size_RAS*vec_VARCOS_RAS_mglab*(floor((g-1)/10)+1) + RAS_CAPEX_annuity)

        GM_gain_RAS_net = -(fval_target - fval_sim) + area_RAS *vec_GM_RAS_ex_lab - (labcost_RAS_step + RAS_CAPEX_annuity)
%OBS: montlhy wage vs 12    

if treeless == 0
    rolling_out_sim_RAS_by_unit = [rolling_out_sim_RAS_by_unit ; [i g repelem(NaN,12) sol_sim.area_forage' sol_sim.area_tree' sollives' GM_gain_RAS_net (fval_target - fval_sim) (area_RAS*vec_GM_RAS) fval_sim obj_fun_sim_val share_land share_labour share_water area_RAS]]
else
    rolling_out_sim_RAS_by_unit = [rolling_out_sim_RAS_by_unit ; [i g repelem(NaN,12) sol_sim.area_forage' repelem(NaN,2) sollives' GM_gain_RAS_net (fval_target - fval_sim) (area_RAS*vec_GM_RAS) fval_sim obj_fun_sim_val share_land share_labour share_water area_RAS]]
end    
        %   else
 %       rolling_out_sim_RAS_by_unit = [rolling_out_sim_RAS_by_unit ; [i g repelem(0,24)]]

    end




