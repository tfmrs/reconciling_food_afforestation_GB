
%View(roll)
TS = datetime
TS.Format = 'yyyy/MM/dd HH:mm:ss.SSS'

datetime

%%%%%%%%%%%%%%%%Emul
clear 
load("D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Emulation_2025\simulations\RAS_all_delta_SLQ_BL_lowres_ras_sub_0_vid_1\ws_mid_RAS_ras_sub_0__2025_08_07_22_21_45p920397_23_07_25")
size(rolling_out_sim_RAS)
gfeas
size(area_observed_crop)
rolling_out_sim_tab = array2table(rolling_out_sim_RAS)
rolling_out_sim_tab.Properties.VariableNames = ["i" "best_RAS_units" [crops(1:3)' "fodder" crops(5:12)'] forages' trees' animals' "GM_gain_RAS_net" "GM_agr_change" "GM_RAS" "fval_sim" "obj_fun_sim_val" "share_land_RAS" "share_labour_RAS" "share_water_RAS" "area_RAS" "kcal_sim" "kcal_BL" "share_land_set_aside" "share_labour_set_aside" "share_water_set_aside" "share_kcal_RAS" "sub_aside" "d_one_unit_unfeasible"]

stat_emu = [mean(rolling_out_sim_tab.best_RAS_units) sum(rolling_out_sim_tab.Conifer,"omitnan") + sum(rolling_out_sim_tab.Broadleaved,"omitnan") sum(rolling_out_sim_tab.sub_aside)]


sum(rolling_out_sim_RAS(:,2))



%%%%%%%%%%%%%%%%Default
clearvars -except stat_emu
load("D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Data\sim_PMP_EE_woodquad_2grants\wooddump\RAS_aside_woodquad_2grants_(EQ)_3_countries_30_06_25_TU0")
size(rolling_out_sim_RAS)
gfeas
size(area_observed_crop)
rolling_out_sim_tab = array2table(rolling_out_sim_RAS)
rolling_out_sim_tab.Properties.VariableNames = ["i" "best_RAS_units" [crops(1:3)' "fodder" crops(5:12)'] forages' trees' animals' "GM_gain_RAS_net" "GM_agr_change" "GM_RAS" "fval_sim" "obj_fun_sim_val" "share_land_RAS" "share_labour_RAS" "share_water_RAS" "area_RAS" "kcal_sim" "kcal_BL" "share_land_set_aside" "share_labour_set_aside" "share_water_set_aside" "share_kcal_RAS" "sub_aside" "d_one_unit_unfeasible"]

stat_def = [mean(rolling_out_sim_tab.best_RAS_units) sum(rolling_out_sim_tab.Conifer,"omitnan") + sum(rolling_out_sim_tab.Broadleaved,"omitnan") sum(rolling_out_sim_tab.sub_aside)]

check2 = [stat_emu; stat_def]


%%%%%%%%%%%%checking gfeas and treeless across all pix
epilson = 0.001
sim_RAS_units = 12
res_dem_thres = 0.50

sub_set_aside = 0
%topup_set_aside = 500
%res_dem_thres = 0.20
minimum_wood_ha = 1

frolling = []
frolling_wide = []

rolling = []
rolling_out = []
rolling_out_sim_RAS = []
rolling_out_sim_RAS_one_unit = []
rolling_out_sim_RAS_by_unit = []
rolling_out_sim_aside = []
rolling_out_LP = []
rolling_det = []
rolling_out_LP_1 = []
rolling_out_LP_2 = []
pix_type = []
rollcheck = []
d_cropless = NaN
runningalg = []

report_collect = []
rollfeas = []


%%%%START OF LOOP
%date_started = datetime
tic
for i = 1:(size(area_observed_crop,1))
%for  i = randsampcheckslow'

    %%(1) Pixel classification
    if (table2array(area_observed_crop(i,:))*ones(length(vec_GM_crop),1) == 0 & table2array(area_observed_forage(i,:))*ones(length(vec_COS_forage),1) == 0)
        pixel_class = "cropless_&_forageless"
        rollcheckd = 1
        d_cropless = NaN
    end

    if (table2array(area_observed_crop(i,:))*ones(length(vec_GM_crop),1) == 0 & table2array(area_observed_forage(i,:))*ones(length(vec_COS_forage),1) > 0)
        pixel_class = "cropless_&_forage"
        rollcheckd = 2
        d_cropless = 1
    end
    if (table2array(area_observed_crop(i,:))*ones(length(vec_GM_crop),1) > 0 & table2array(area_observed_forage(i,:))*ones(length(vec_COS_forage),1) > 0)
        pixel_class = "crop_&_forage"
        rollcheckd = 3
        d_cropless = 0
    end

    treeless = 0 
    if table2array(area_observed_tree(i,1)) + table2array(area_observed_tree(i,2)) == 0
        treeless = 1 
    end
    %%(2) Pixel-specific calibration & simulation
%cd 'D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\'
if pixel_class ~= "cropless_&_forageless"
		    display(pixel_class)
    %%(2.a)recover calibration outputs
                try 
                    eval(strcat("i_",string(i),"= getfield(inputdata,'i_",string(i),"')"))
                    report_collect = [report_collect; [i "success"]]
                        for var = 1:length(variable_list)
                        eval(strcat(variable_list(var) ,"= getfield(inputdata.i_",string(i),",'",variable_list(var),"')"))
                        end
                    eval(strcat("clear('i_",string(i),"')"))
                catch
                    warning(strcat("pixel ", string(i), " not calibrated"))
                    report_collect = [report_collect; [i "failure"]]
                end
%simulation only for well-calib
                if ((d_cropless ==0 & maxerror_crop<10^-5 & maxerror_forage<10^-5 & maxerror_animal<10^-5 & (maxerror_tree<10^-5 | isnan(maxerror_tree) == 1)) | (d_cropless ==1 & isnan(maxerror_crop) == 1 & maxerror_forage<10^-5 & maxerror_animal<10^-5 & (maxerror_tree<10^-5 | isnan(maxerror_tree) == 1)))
if pixel_class == "crop_&_forage" 
                    SLRtot = table2array(area_observed_crop(i,id_act_crop))*vec_SLR_crop(id_act_crop) + table2array(area_observed_forage(i,id_act_forage))*mat_SLR_forage_m(i,id_act_forage)'
else
                    SLRtot = table2array(area_observed_forage(i,id_act_forage))*mat_SLR_forage_m(i,id_act_forage)'
end

                    feasible_RAS_calc__i_rate_sensitivity_16_06_25
                    rollfeas = [rollfeas; [i gfeas treeless]]
                
                end
    end 
end


writematrix(rollfeas,"D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Emulation_2025\feas_RAS_treeless_all_pix_08_07_25.txt")

tabulate(rollfeas(:,2))
tabulate(rollfeas(:,3))

height(find(rollfeas(:,2) == 0 & rollfeas(:,3) == 0))/height(rollfeas)

height(find(rollfeas(:,2) == 0))/height(rollfeas)

