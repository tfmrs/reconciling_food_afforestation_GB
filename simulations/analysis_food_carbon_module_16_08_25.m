%%NEV forestry GHG
%cd D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\NEV_TFMRS
%ghg_wood_from_NEV_forestry
%26/07, do not run, use number below
tc_av = 189.9333

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
%        writetable(sim_monitor,strcat(output_directory,"table_4_sim_monit_",sim_name,"_",timing,".txt"),'writemode','overwrite')

%%%14/01/25, calculation of RAS subsidy
    rolling_out_sim_tab.RAS_sub_recalc = repelem(0,height(rolling_out_sim_tab))'
       if (type_sim == "set_aside_only_gis_nocalconstraint_EWCO")
           RAS_sub_total = 0
           RAS_units_average = NaN
	  else
            if (ras_sub >= 1)
                rolling_out_sim_tab.RAS_sub_recalc(find(rolling_out_sim_tab.best_RAS_units>=2)) = repelem(ras_sub*RAS_CAPEX,height(find(rolling_out_sim_tab.best_RAS_units>=2)))'
                rolling_out_sim_tab.RAS_sub_recalc(find(rolling_out_sim_tab.best_RAS_units==1)) = repelem(RAS_CAPEX,height(find(rolling_out_sim_tab.best_RAS_units==1)))'
            else
                rolling_out_sim_tab.RAS_sub_recalc(find(rolling_out_sim_tab.best_RAS_units>=2)) = repelem(ras_sub*RAS_CAPEX,height(find(rolling_out_sim_tab.best_RAS_units>=2)))'
                rolling_out_sim_tab.RAS_sub_recalc(find(rolling_out_sim_tab.best_RAS_units==1)) = repelem(ras_sub*RAS_CAPEX,height(find(rolling_out_sim_tab.best_RAS_units==1)))'
            end
                rolling_out_sim_tab.RAS_sub_recalc(find(rolling_out_sim_tab.best_RAS_units==0)) = 0
                RAS_sub_total = sum(rolling_out_sim_tab.RAS_sub_recalc)
                RAS_units_average = sum(rolling_out_sim_tab.best_RAS_units)/height(find(rolling_out_sim_tab.best_RAS_units > 0))
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


        ghg_coeff_matrix_out = rows2vars(readtable(strcat(input_directory,"emissions_crops_pasture_BSFP_23_04_25.txt")),'VariableNamesSource','Crop')

        ghg_coeff_matrix_out_crop = ghg_coeff_matrix_out(:,["Barley_av" "Beans" "FieldVegetables" "Fodder" "Oats" "OSR" "OtherCereals" "Peas" "Potatoes" "SugarBeet" "Topandsoftfruit" "Wheat"])

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


%%%BL GHG

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

LU_start_pos_out = find(rolling_out_tab.Properties.VariableNames=="Barley")
LU_med_pos_out = find(rolling_out_tab.Properties.VariableNames=="Wheat")
LU_end_pos_out = find(rolling_out_tab.Properties.VariableNames=="Rough grazing")

delta_LU_crop = sum(table2array(rolling_out_tab(:,[LU_start_pos_out:LU_med_pos_out])),1,"omitnan") - sum(table2array(rolling_out_sim_tab(:,LU_start_pos:LU_med_pos)),1,"omitnan")
delta_LU_forage = sum(table2array(rolling_out_tab(:,[(LU_med_pos_out+1):LU_end_pos_out])),1,"omitnan") - sum(table2array(rolling_out_sim_tab(:,(LU_med_pos+1):LU_end_pos)),1,"omitnan")

delta_head_beef = sum(table2array(rolling_out_tab(:,["Animal: Beef cattle"])),1) - sum(table2array(rolling_out_sim_tab(:,["Animal: Beef cattle"])),1)
delta_head_dairy = sum(table2array(rolling_out_tab(:,["Animal: Dairy cow"])),1) - sum(table2array(rolling_out_sim_tab(:,["Animal: Dairy cow"])),1)
delta_head_sheep = sum(table2array(rolling_out_tab(:,["Animal: Sheep"])),1) - sum(table2array(rolling_out_sim_tab(:,["Animal: Sheep"])),1)

carbon_trade_crops_transp = delta_LU_crop*(coeff_kgco2.Var3(find(coeff_kgco2.Var2=="crops")).*(vec_yield_crop*10^3))
carbon_trade_beef_transp = (coeff_kgco2.Var3(find(coeff_kgco2.Var2=="beef")).*coeff_head_to_kg(1))*delta_head_beef
carbon_trade_dairy_transp = (coeff_kgco2.Var3(find(coeff_kgco2.Var2=="dairy")).*coeff_head_to_kg(2))*delta_head_dairy
carbon_trade_sheep_transp = (coeff_kgco2.Var3(find(coeff_kgco2.Var2=="sheep")).*coeff_head_to_kg(3))*delta_head_sheep

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
index_3_carbon_effect = NaN
index_4_externality_effect = NaN
end

%%%%output 10
carbon_total = carbon_agri_total + carbon_prawn_total + carbon_trade_wood

