
clearvars -except price_meat delta_out alpha_out irate_out d_SLR_RAS_out nOW_out disc_RAS_CAPEX_out type_sim name_sim timing cs_chitin cs_PLJ cs_feed cs_salt ras_sub input_directory output_directory
cd(input_directory);

%%%from pre_simulation_module_MLbased_AFRASTECHV_afCAPEXerr_08_01_25
%%%17/04/25: this is identical copy of pre_simulation_module_MLbased_AFRASTECHV_afCAPEXerr_06_02_25
%%%just changed output directory and feasible_RAS_calc to i_rate spec

variable_list = ["d_cropless" "calib_crop" "calib_forage" "calib_tree" "id_act_crop" "id_act_forage" "id_act_tree" "n_act_crop" "n_act_forage" "n_act_tree" "sol_target" "fval_target" "sollives_1" "sollives_2" "sollives_3" "maxerror_crop" "maxerror_forage" "maxerror_animal" "maxerror_tree"]
%%%UPLOAD PRICE DATA
externalfile_coeffs = readtable("coefficients_OF_constraints_RAS_only_rassub_onehalf_EQ_17_07_25.txt");

%%%UPLOAD BASIC DATA
%cd 'D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\'
%upload_data_04_11_24_DGP_ACER
%upload_data_11_06_25_DGP_ACER
upload_data_DGP_ACER_emulation

%cd 'D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Data\sim_PMP_EE_woodquad_2grants\calibration\'
%load("input_data_calibration_woodquad_16_05_2025")
%load("input_data_calibration_woodquad_20_05_2025")
%load("input_data_calibration_woodquad_26_05_2025_2woodgrants")
load("input_data_calibration_woodquad_16_06_2025_2woodgrants");

%%%%%%%%%%%%%OPTIM-PMP Judez, 29/09 [03/10: jumps all activity areas = 0]
%%cd 'D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\'
%%start loop PMP

%select type of sim here ("RAS" or "activities")
%type_sim = "off"

%%%(1) SIM BLOCK 1: RAS
%type_sim = "RAS_all_delta_SLQ_BL_lowres"
%type_sim = "RAS_&_AD"
%type_sim = "RAS_&_AD"

%%%(2) SIM BLOCK 2: WOODLAND
%type_sim = "set_aside_only_nocalconstraint"
%type_sim = "RAS_all_delta_set_aside_nocalconstraint"
%type_sim = "RAS_&_AD_set_aside_nocalconstraint"
%type_sim = "set_aside_only_gis_nocalconstraint"
%type_sim = "set_aside_only_gis_nocalconstraint_EWCO"

%type_sim = "RAS_all_delta_set_aside_nocalconstraint_wq"
%type_sim = "RAS_aside_nocalconst_sub_fix_unit_two_wq"

%%%(3) SIM BLOCK 3: PRICE SHOCKS
%type_sim = "activities"
%ras_sub = 1.5


%LQ const
delta = delta_out
alpha = alpha_out

%%%Control of labour hiring out of pixel (27/03)
%with hire out of pixel
d_lab_out = 1
%without hire out
%d_lab_out = 0

%Make active REPAIR 16/05
%irate_out = 0.04
i_rate_out = irate_out

%remove woodonly REPAIR 16/05
%i_rate_out = 0.04

%%%Woodland (set-aside) SLR and water: scenario 1 = 0 (negligible)
SLR_set_aside = 0
vec_water_wood = 0

%%%running on nocroppix only
area_observed_crop_c = area_observed_crop;
area_observed_crop_c.total = table2array(area_observed_crop)*ones(12,1);
nocroppix = find(area_observed_crop_c.total ==0);
%extended for crop-pix
nocroppix = [(1:10)'; find(area_observed_crop_c.total ==0)];

%low res
gres = 5
gmax = 100

%
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


%list of Eng-only pix
%list_pix_Eng = mat_area_crop
%list_pix_Eng.i = (1:height(list_pix_Eng))'
%list_pix_Eng = list_pix_Eng(find(extractBefore(list_pix_Eng.key,4)=="Eng"),:)
%list_pix_Eng.Properties.VariableNames
%list_pix_Eng = list_pix_Eng.i
%size(list_pix_Eng)

%list of Eng & Sco-only pix
list_pix_Eng_Sco = mat_area_crop;
list_pix_Eng_Sco.i = (1:height(list_pix_Eng_Sco))';
list_pix_Eng_Sco = list_pix_Eng_Sco(find(extractBefore(list_pix_Eng_Sco.key,4)=="Eng"|extractBefore(list_pix_Eng_Sco.key,4)=="Sco"),:);
list_pix_Eng_Sco.Properties.VariableNames;
list_pix_Eng_Sco = list_pix_Eng_Sco.i;
size(list_pix_Eng_Sco);


%representative_pixel_list = table2array(readtable("D:\LEEP\Sustainable_Prawn\Data\rep_pix_list_27_03_24.txt"))'
%random_samp_1000_26_03_24 = table2array(readtable("D:\LEEP\Sustainable_Prawn\random_samp_1000_26_03_24.txt"))

%rand_2_centile = readmatrix("random_2per_centile_07_05_2024.txt")
%listpix = [130 960 1396 1997 4980 6095 6830 7235 7429 8531 8876]

%prio wood pix RAS&aside no calconst
%pwoodrw = readtable("D:\LEEP\Sustainable_Prawn\Data\gov_2025_wood_results_pix_10_07_2024.txt")
%pwoodrw_list = pwoodrw.i(find(pwoodrw.RAS_all_delta_set_aside_nocalconstraint_TU_0==1),:)

randsampcheckslow = readmatrix("D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Emulation_2025\simulations\RAS_all_delta_SLQ_BL_lowres_ras_sub_0_vid_1\rand_samp_N20_09_08_2025.txt";)


%%%%START OF LOOP
%date_started = datetime
tic
%for i = 1:1000
%for i = [1:10,5530:5540]
%for i = 1:10
%for i = 5:6
%for i = trialpix
%for i = 1:(size(area_observed_crop,1))
%for i = list_pix_Eng'
%for i = list_pix_Eng_Sco'
%for i = [5915:max(list_pix_Eng_Sco)]
%for i = [5915:max(list_pix_Eng_Sco)]
%    find(list_pix_Eng_Sco == 5532)
%for i = 5532:length(list_pix_Eng_Sco)
%for i = 5574:length(list_pix_Eng_Sco)
%for i = 8416:length(list_pix_Eng_Sco)
%for i = 5645:length(list_pix_Eng_Sco)

for  i = randsampcheckslow'
start_time = datetime
    start_time.Format = 'yyyy/MM/dd HH:mm:ss.SSS'


    %for i = 5533:(5533+10)
%for i = 5533:(size(area_observed_crop,1))
%for i = 5534:(size(area_observed_crop,1))
%for j = 1:height(representative_pixel_list)
%    i = representative_pixel_list(j)
%for j = 1:height(random_samp_1000_26_03_24)
%    i = random_samp_1000_26_03_24(j)
%for j = 1:length(listpix)
%    i = listpix(j)
%for j = 1:height(rand_2_centile)
%    i = rand_2_centile(j)

%for jij = 1:height(pwoodrw_list)
%    i = pwoodrw_list(jij)

%rolltest = []
%for j = (height(list_pix_Eng)-100):height(list_pix_Eng)
%    i = list_pix_Eng(j)
%rolltest = [rolltest; [i i^2]]
%end

%for j = 1:height(list_pix_Eng)
%for j = [1:50,(height(list_pix_Eng)-50):height(list_pix_Eng)]

%    i = list_pix_Eng(j)

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
                        eval(strcat(variable_list(var) ,"= getfield(inputdata.i_",string(i),",'",variable_list(var),"')"));
                        end
                    eval(strcat("clear('i_",string(i),"')"));
                catch
                    warning(strcat("pixel ", string(i), " not calibrated"));
                    report_collect = [report_collect; [i "failure"]];
                end
%simulation only for well-calib
                if ((d_cropless ==0 & maxerror_crop<10^-5 & maxerror_forage<10^-5 & maxerror_animal<10^-5 & (maxerror_tree<10^-5 | isnan(maxerror_tree) == 1)) | (d_cropless ==1 & isnan(maxerror_crop) == 1 & maxerror_forage<10^-5 & maxerror_animal<10^-5 & (maxerror_tree<10^-5 | isnan(maxerror_tree) == 1)))
                    feasible_RAS_calc__i_rate_sensitivity_16_06_25;
                    rollfeas = [rollfeas; [i gfeas]];
                    simulation_module_water_labour_EMULATION_new_sims_speed_try;
                end
    end 

end_time = datetime
end_time.Format = 'yyyy/MM/dd HH:mm:ss.SSS'

total_time = end_time - start_time
total_time.Format = 'hh:mm:ss.SSS'

gvec = sort(unique([0:gres:gfeas gfeas 1:5]))

total_time = end_time - start_time
writematrix([i string(start_time) string(end_time) string(total_time) length(gvec)],strcat(output_directory,"speed_col_",string(i),".txt"));

end

toc 

%%%%%%END OF LOOP
%save(strcat(output_directory,"ws_mid_",extractBefore(type_sim,4),"_ras_sub_",string(ras_sub),"__",timing,"_23_07_25.mat"))

%if contains(type_sim,"RAS") == 1
%taboutR = array2table([price_meat sum(rolling_out_sim_RAS(:,[18:19]),"all","omitnan")])
%else
%taboutR = array2table([price_meat sum(rolling_out_sim_aside(:,[17:18]),"all","omitnan")])
%end

%taboutR.Properties.VariableNames = ["price_meat" "tree_area_tot"]

%writetable(taboutR,strcat(output_directory,"out_mid_sim_23_07_25_",extractBefore(type_sim,4),"_ras_sub_",string(ras_sub),"__",timing,".txt"))




