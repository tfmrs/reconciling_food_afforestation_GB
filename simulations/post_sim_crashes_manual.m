clear
% 
% type_sim = "RAS_all_delta_set_aside_nocalconstraint_wq"
% ras_sub = 0
% vec = 33
% price_meat_EQ = 14.5661
% alpha = 0.45116
% delta = 0.37589
% irate_out = 0.045156
% cs_chitin = 9.9402/12-1
% cs_feed = 1.7068/2.4 -1
% cs_PLJ = 14.0337/50-1
% cs_salt = 0.36443/0.984-1
% midfile = 'ws_mid_RAS_ras_sub_0__2025_08_12_13_04_17p294184_23_07_25.mat'
% postsim_out = strcat("gov_2050_post_RAS_ras_sub_",string(ras_sub),"_2025_08_12_13_04_17.txt")
% ref_midfile = 'ws_pre_RAS_ras_sub_0_14.5661__2025_08_08_12_38_26.mat'
% input_directory = 'D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Emulation_2025\simulations\'
% output_directory = 'D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Emulation_2025\simulations\stage2_rerun\ras_sub_0_vid_33\'
% r_inp_output_directory_1 = output_directory

data = readtable("D:/Pesquisa/Pesquisa_2024/Sustainable_Prawn/Emulation_2025/parameter_values_initial_design_DW_06_08_25.txt","Delimiter","#")
data.Properties.VariableNames = ["rownames" "vec" "param_irate" "param_psalt" "param_pfeed" "param_pplj" "param_pchitin" "param_alpha" "param_delta" "param_root_directory"]

%%%sub_0_vid_1
type_sim = "RAS_all_delta_set_aside_nocalconstraint_wq"
ras_sub = 0
vec = 1
price_meat_EQ = 17.3678152418905
alpha = data.param_alpha(1)
delta = data.param_delta(1)
irate_out = data.param_irate(1)
cs_chitin = data.param_pchitin(1)/12-1
cs_feed = data.param_pfeed(1)/2.4 -1
cs_PLJ =  data.param_pplj(1)/50-1
cs_salt = data.param_psalt(1)/0.984-1

timing_here = "2025_08_16_12_24"
midfile = 'ws_mid_RAS_ras_sub_0__2025_08_09_10_09_40_23_07_25.mat'
postsim_out = strcat("gov_2050_post_RAS_ras_sub_",string(ras_sub),"_",timing_here,".txt")
ref_midfile = 'ws_pre_RAS_ras_sub_0_17.3678__2025_08_07_20_11_35p411468.mat'
input_directory = 'D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Emulation_2025\simulations\'
output_directory = 'D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Emulation_2025\simulations\RAS_all_delta_SLQ_BL_lowres_ras_sub_0_vid_1\'
r_inp_output_directory_1 = output_directory
r_inp_input_directory_1 = input_directory


%%%sub_0_vid_25
clear 
data = readtable("D:/Pesquisa/Pesquisa_2024/Sustainable_Prawn/Emulation_2025/parameter_values_initial_design_DW_06_08_25.txt","Delimiter","#")
data.Properties.VariableNames = ["rownames" "vec" "param_irate" "param_psalt" "param_pfeed" "param_pplj" "param_pchitin" "param_alpha" "param_delta" "param_root_directory"]
type_sim = "RAS_all_delta_set_aside_nocalconstraint_wq"
ras_sub = 0
vec = 25
price_meat_EQ = 18.1612104160402
alpha = data.param_alpha(25)
delta = data.param_delta(25)
irate_out = data.param_irate(25)
cs_chitin = data.param_pchitin(25)/12-1
cs_feed = data.param_pfeed(25)/2.4 -1
cs_PLJ =  data.param_pplj(25)/50-1
cs_salt = data.param_psalt(25)/0.984-1


timing_here = "2025_08_16_09_36"
midfile = 'ws_mid_RAS_ras_sub_0__2025_08_13_11_42_40_23_07_25.mat'
postsim_out = strcat("gov_2050_post_RAS_ras_sub_",string(ras_sub),"_08_16_09_36.txt")
ref_midfile = 'ws_pre_RAS_ras_sub_0_18.1612__2025_08_08_12_17_07.mat'
input_directory = 'D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Emulation_2025\simulations\'
output_directory = 'D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Emulation_2025\simulations\stage2_rerun\ras_sub_0_vid_25\'
r_inp_output_directory_1 = output_directory
r_inp_input_directory_1 = input_directory



%%%sub_0_vid_33
clear 
data = readtable("D:/Pesquisa/Pesquisa_2024/Sustainable_Prawn/Emulation_2025/parameter_values_initial_design_DW_06_08_25.txt","Delimiter","#")
data.Properties.VariableNames = ["rownames" "vec" "param_irate" "param_psalt" "param_pfeed" "param_pplj" "param_pchitin" "param_alpha" "param_delta" "param_root_directory"]
type_sim = "RAS_all_delta_set_aside_nocalconstraint_wq"
ras_sub = 0
vec = 33
price_meat_EQ = 14.5661005695262
alpha = data.param_alpha(33)
delta = data.param_delta(33)
irate_out = data.param_irate(33)
cs_chitin = data.param_pchitin(33)/12-1
cs_feed = data.param_pfeed(33)/2.4 -1
cs_PLJ =  data.param_pplj(33)/50-1
cs_salt = data.param_psalt(33)/0.984-1


timing_here = "2025_08_16_09_52"
midfile = 'ws_mid_RAS_ras_sub_0__2025_08_12_13_04_17p294184_23_07_25.mat'
postsim_out = strcat("gov_2050_post_RAS_ras_sub_",string(ras_sub),"_",timing_here,".txt")
ref_midfile = 'ws_pre_RAS_ras_sub_0_14.5661__2025_08_08_12_38_26.mat'
input_directory = 'D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Emulation_2025\simulations\'
output_directory = 'D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Emulation_2025\simulations\stage2_rerun\ras_sub_0_vid_33\'
r_inp_output_directory_1 = output_directory
r_inp_input_directory_1 = input_directory


%%%sub_2_vid_17
clear 
data = readtable("D:/Pesquisa/Pesquisa_2024/Sustainable_Prawn/Emulation_2025/parameter_values_initial_design_DW_06_08_25.txt","Delimiter","#")
data.Properties.VariableNames = ["rownames" "vec" "param_irate" "param_psalt" "param_pfeed" "param_pplj" "param_pchitin" "param_alpha" "param_delta" "param_root_directory"]
type_sim = "RAS_aside_nocalconst_sub_fix_unit_two_wq"
ras_sub = 2
vec = 17
price_meat_EQ = 18.5227274222313
alpha = data.param_alpha(17)
delta = data.param_delta(17)
irate_out = data.param_irate(17)
cs_chitin = data.param_pchitin(17)/12-1
cs_feed = data.param_pfeed(17)/2.4 -1
cs_PLJ =  data.param_pplj(17)/50-1
cs_salt = data.param_psalt(17)/0.984-1


timing_here = "2025_08_16_09_59"
midfile = 'ws_mid_RAS_ras_sub_2__2025_08_13_21_12_18_23_07_25.mat'
postsim_out = strcat("gov_2050_post_RAS_ras_sub_",string(ras_sub),"_",timing_here,".txt")
ref_midfile = 'ws_pre_RAS_ras_sub_2_18.5227__2025_08_08_02_46_27p686972.mat'
input_directory = 'D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Emulation_2025\simulations\'
output_directory = 'D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Emulation_2025\simulations\stage2_rerun\ras_sub_2_vid_17\'
r_inp_output_directory_1 = output_directory
r_inp_input_directory_1 = input_directory

%Step 0: running the table 6 via wooddump
clearvars -except price_meat delta_out alpha_out irate_out d_SLR_RAS_out nOW_out disc_RAS_CAPEX_out type_sim name_sim timing cs_chitin cs_PLJ cs_feed cs_salt ras_sub input_directory output_directory midfile postsim_out ref_midfile timing r_inp_output_directory_1 timing_here r_inp_input_directory_1
cd(input_directory)
%cd 'D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\'
%post_sim_wooddump_module_19_06_25
%post_sim_wooddump_module_25_06_25
%post_sim_wooddump_module_03_07_25
post_sim_wooddump_module_for_emulation_23_07_25_fixbreak(strcat(output_directory,midfile),output_directory,r_inp_output_directory_1)


clearvars -except price_meat delta_out alpha_out irate_out d_SLR_RAS_out nOW_out disc_RAS_CAPEX_out type_sim name_sim timing cs_chitin cs_PLJ cs_feed cs_salt ras_sub input_directory output_directory midfile postsim_out ref_midfile timing r_inp_output_directory_1 timing_here r_inp_input_directory_1
cd(input_directory)
%cd 'D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Data\sim_RAS_general_dump\'
%cd 'D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Data\sim_PMP_EE_AFRASTECHV_wageREP_wooddump\'
%cd 'D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Data\sim_PMP_EE_woodquad_2grants\'

aggsolroll = [];        
pixsolroll = []
goal_GB = 30000
goal_Eng = 7500
goal_Sco = 7500

%load("workspace_set_aside_only_GIS_(DR)_TU0_09_07_24_optoutwood_09h45.mat")
%load("workspace_aside_only_nocalconst_GIS_TU0_(DR)_30_07_24.mat")


%EMcost = sum(woodland_financial_tab.Bro_cost_1_estab) + sum(woodland_financial_tab.Bro_cost_2_maint)

%NPV woodland (21/05)
%cd 'D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\'
%[NPV_wood,woodland_financial_tab] = NPV_EWCO_20_05(0)
[C0_bro,REV_Bro,C0_con,REV_Con,woodland_financial_tab] = NPV_EWCO_26_05_25(0)
%cd 'D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Data\sim_PMP_EE_woodquad_2grants\wooddump\'


EMcost_bro = 2560 + 3000
EMcost_con = 4000 + 3000
%updated 30/05: now gov covers partially

%since the smallest the TU, the largest the area enrolled, and the first
%simulation demonstrated that it is possible to achieve a total area
%compatible with UK woodland creation goals, then the smallest TU, zero,
%will be used in the 2050 simulation

%if stage == "generate_list"
simulation = "GIS"
%%%%%%%%%%%[1] GENERATING LIST OF SELECTED PIXELS UNDER BUDGET CONSTRAINT
        goal = goal_Eng
%        listoftabs = dir('*table_6_GM_change*')
%        listoftabs = struct2table(listoftabs)
%        listoftabs = listoftabs(:,1)
 
        listoftabs = array2table(strcat(output_directory,"table_6_GM_change_BL_AL_",type_sim,"_ras_sub_",string(ras_sub),".txt"))    
        
        clearvars -except woodland_financial_tab listoftabs aggsolroll pixsolroll goal simulation EMcost_bro EMcost_con REV_bro REV_con C0_bro C0_con goal_Eng C0_bro ras_sub input_directory output_directory midfile postsim_out ref_midfile timing r_inp_output_directory_1 timing_here r_inp_input_directory_1
        %to get indexes (i)
%        load("workspace_set_aside_only_(DR)_TU0_09_07_24_optoutwood_09h45.mat")
%        load("workspace_aside_only_nocalconst_TU0_(DR)_30_07_24.mat")
%        load("workspace_set_aside_only_woodquad_20_05_25_20h35_repairs_TU0.mat")
%         load("workspace_set_aside_only_gis_Eng_woodquad_1hamin_2woodgrants_subcalccorr_3countries_11_06_25_TU0.mat")
%         load("D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Data\sim_PMP_EE_woodquad_2grants\wooddump\workspace_set_aside_only_gis_Eng_woodquad_1hamin_2woodgrants_subcalccorr_3countries_repareal1_repwood_16_06_25_TU0.mat")
        load(strcat(output_directory,midfile))
        output_directory = r_inp_output_directory_1

%payment_av_Eng = mean(tab_ewco_ac.value(find(extractBefore(tab_ewco_ac.key_mat_area_crop,4)=="Eng")))
%payment_av_Sco = mean(tab_ewco_ac.value(find(extractBefore(tab_ewco_ac.key_mat_area_crop,4)=="Sco")))

%BUdged needed / available calcs
%((mean(tab_ewco_ac.value(GMlist.i)) + EMcost)*goal_Eng)/budget_Eng
%((400 + EMcost)*goal)/budget_GB
%Needed >> available
%(400 + EMcost)
   if contains(type_sim,"RAS") == 1 
   pixsolroll_tab = array2table([rolling_out_sim_RAS(:,1)]);         
   else
   pixsolroll_tab = array2table([rolling_out_sim_aside(:,1)]);        
   end

   pixsolroll_tab.Properties.VariableNames = ["i"]
   aggcountryroll = []



tic
for ijj = [1:height(listoftabs)]
%ijj = 2
%ijj = 1
%ijj = 6

    clearvars -except listoftabs ijj aggcountryroll pixsolroll pixsolroll_tab aggsolroll tab_ewco_ac woodland_financial_tab NPV_wood budget_GB stage goal budget simulation C0_bro C0_con EMcost_bro EMcost_con ras_sub input_directory output_directory midfile postsim_out ref_midfile timing r_inp_output_directory_1 timing_here r_inp_input_directory_1

    GMlist = readtable(string(table2array(listoftabs(ijj,1))))
    %mattab6 = [activity_shares_c.i string(activity_shares_c.key) activity_shares_c.GM_BL activity_shares_c.GM_AL activity_shares_c.GMdelta activity_shares_c.area_set_aside_sim];
    
    %index
%    GMlist.Properties.VariableNames = ["i","key","GM_BL","GM_AL","deltaGM","broadleaved", "conifer"]
    GMlist.Properties.VariableNames = ["i","key","broadleaved", "conifer"]
    GMlist.broadleaved(find(isnan(GMlist.broadleaved)==1)) = 0
    GMlist.conifer(find(isnan(GMlist.conifer)==1)) = 0

    GMlist.broadleaved(find(GMlist.broadleaved + GMlist.conifer < 1)) = 0
    GMlist.conifer(find(GMlist.broadleaved + GMlist.conifer < 1)) = 0

    GMlist = join(GMlist,tab_ewco_ac,"Keys","i")
    
    %payment tot per pixel
    GMlist.payment_tot =  GMlist.conifer.*GMlist.value + GMlist.broadleaved.*GMlist.value

    %OBS: remind that the maintenance and estab cost also include felling
    %and thinning costs
    if (simulation == "non_GIS" | simulation == "non_GIS_Eng")
    %vs fixed    
%        sub = str2double(extractBetween(string(table2array(listoftabs(ijj,1))),"TU_",".txt"))
        GMlist.C = (500 + C0_bro)*GMlist.broadleaved + (500 + C0_con)*GMlist.conifer

    else
    %vs GIS
%        GMlist.C = (tab_ewco_ac.value(GMlist.i) + EMcost).*GMlist.area_set_aside_sim
        GMlist.C = (GMlist.value + EMcost_bro).*GMlist.broadleaved + (GMlist.value + EMcost_con).*GMlist.conifer

    end    

    %Problem
   for ijh = ["Eng","Sco", "Wal"]
        GMlist_roll = GMlist(find(extractBefore(GMlist.key_mat_area_crop_copy,4)==ijh),:)
        payment_av_roll = mean(GMlist.value(find(extractBefore(GMlist.key_mat_area_crop_copy,4)==ijh)))
        goal_roll = 30000/4
    
        govProblem_sim_roll = optimproblem('ObjectiveSense','maximize');
        dummy_pix_roll = optimvar('dummy_pix_roll',height(GMlist_roll),'LowerBound',0,'UpperBound',1,'Type',"integer");
    
        if ijh == "Sco"
        obj_fun_sim_roll = ((GMlist_roll.score/(25*10^6))'*((GMlist_roll.broadleaved+GMlist_roll.conifer).*dummy_pix_roll)) 
        else
            obj_fun_sim_roll = (GMlist_roll.score'*((GMlist_roll.broadleaved+GMlist_roll.conifer).*dummy_pix_roll)) 
        end

        creation_goal_lb_roll = (GMlist_roll.broadleaved + GMlist_roll.conifer)'*dummy_pix_roll >= 0.95*goal_roll
       creation_goal_ub_roll = (GMlist_roll.broadleaved + GMlist_roll.conifer)'*dummy_pix_roll <= 1.05*goal_roll
       budget_constraint_roll = GMlist_roll.payment_tot'*dummy_pix_roll <= payment_av_roll*goal_roll
    
       govProblem_sim_roll.Objective = obj_fun_sim_roll;
       govProblem_sim_roll.Constraints.b1 = creation_goal_lb_roll;
       govProblem_sim_roll.Constraints.b2 = creation_goal_ub_roll;
       govProblem_sim_roll.Constraints.budget = budget_constraint_roll;

%        show(govProblem_sim_roll);

        [sol_gov_roll,fval_gov_roll,exitflag_gov_roll,output_gov_roll,lambda_gov_roll] = solve(govProblem_sim_roll)


    %Storing 1: output (pooling vertically 3 countries)    
    countryroll = array2table(sol_gov_roll.dummy_pix_roll)
    countryroll.i = GMlist_roll.i
    pixsolroll = [pixsolroll; countryroll]

    %Storing 1: statistics (pooling vertically 3 countries)  
    aggcountryroll = [aggcountryroll; [ijj ijh sum(sol_gov_roll.dummy_pix_roll) (GMlist_roll.broadleaved+GMlist_roll.conifer)'*sol_gov_roll.dummy_pix_roll GMlist_roll.C'*sol_gov_roll.dummy_pix_roll ((GMlist_roll.broadleaved+GMlist_roll.conifer)'*sol_gov_roll.dummy_pix_roll / sum(sol_gov_roll.dummy_pix_roll)) max(GMlist_roll.broadleaved(find(sol_gov_roll.dummy_pix_roll>0))+GMlist_roll.conifer(find(sol_gov_roll.dummy_pix_roll>0))) fval_gov_roll min(GMlist_roll.score.*sol_gov_roll.dummy_pix_roll)/max(GMlist_roll.score.*sol_gov_roll.dummy_pix_roll) median(GMlist_roll.score'*((GMlist_roll.broadleaved+GMlist_roll.conifer).*sol_gov_roll.dummy_pix_roll))/median(GMlist_roll.score'*(GMlist_roll.broadleaved+GMlist_roll.conifer))]];


   end
    %%%(2) Storing

    %pooling vertically simulations
    %[num_pix total_area total_cost av_area max_area total_score minimum_fraction_of_max_attainable_score mean_fraction_selected_cells_divided_by_all_cells]
    aggsolroll = [aggsolroll; aggcountryroll];

    pixsolroll.Properties.VariableNames = [extractBetween(string(table2array(listoftabs(ijj,1))),"BL_AL_",".txt")' "i"];
    pixsolroll_tab = join(pixsolroll_tab,pixsolroll,"Key","i")

    %RESUME AND USE JOIN (gambiarra 16/06)
    %pooling horizontally simulations
%    pixsolroll_tab = outerjoin(pixsolroll,pixsolroll_tab,"Key","i")
%    pixsolroll_tab.i = table2array(pixsolroll_tab(:,width(pixsolroll_tab)))
    
    pixsolroll = []
    aggcountryroll = []
end
toc
%STOP 1

%changing order of vars in pixsorolltab
%pixsolroll_tab = [array2table(pixsolroll_tab.i) pixsolroll_tab(:,find(pixsolroll_tab.Properties.VariableNames ~="i"))]
%pixsolroll_tab.Properties.VariableNames(1) = "i"

%pixsolroll_tab_c = pixsolroll_tab(:,["i" "set_aside_only_gis_nocalconstraint_EWCO_TU_4450" "RAS_all_delta_set_aside_nocalconstraint_wq_TU_4450" "RAS_aside_nocalconst_sub_fix_unit_TU_4450_ras_sub_half" "RAS_aside_nocalconst_sub_fix_unit_TU_4450_ras_sub_one" "RAS_aside_nocalconst_sub_fix_unit_two_wq_TU_4450"])
%pixsolroll_tab_c = pixsolroll_tab_c(find(pixsolroll_tab_c.i<=9326),:)
%pixsolroll_tab_c2 = pixsolroll_tab
%pixsolroll_tab = pixsolroll_tab_c

%max(pixsolroll_tab)
%min(pixsolroll_tab)
%RAS_all_delta_set_aside_TU_1000 is -3.10^-14

%share of area afforested (section 4.3)
%[min((GMlist.broadleaved(find(sol_gov.dummy_pix==1))+GMlist.conifer(find(sol_gov.dummy_pix==1))).*sol_gov.dummy_pix(find(sol_gov.dummy_pix==1))/2500) max((GMlist.broadleaved(find(sol_gov.dummy_pix==1))+GMlist.conifer(find(sol_gov.dummy_pix==1))).*sol_gov.dummy_pix(find(sol_gov.dummy_pix==1))/2500)]


%how many outputs diff than zero or one
rollcheckn1 = []
rollnempty = []
for j = 2:width(pixsolroll_tab)
    rollingnumberc = height(find(table2array(pixsolroll_tab(:,j))~=0 & table2array(pixsolroll_tab(:,j))~=1))
    rollcheckn1 = [rollcheckn1; rollingnumberc]
    if rollingnumberc>0
        rollnempty = [rollnempty; j] 
    end
end

rollnempty
%only two, for...
pixsolroll_tab.Properties.VariableNames(rollnempty')
for kki = 1:height(rollnempty)
    kkij = rollnempty(kki)
    pixsolroll_tab(find(table2array(pixsolroll_tab(:,kkij))~=0 & table2array(pixsolroll_tab(:,kkij))~=1),kkij) = round(pixsolroll_tab(find(table2array(pixsolroll_tab(:,kkij))~=0 & table2array(pixsolroll_tab(:,kkij))~=1),kkij))
end

rollcheckn1 = []
for j = 2:width(pixsolroll_tab)
rollcheckn1 = [rollcheckn1; height(find(table2array(pixsolroll_tab(:,j))~=0 & table2array(pixsolroll_tab(:,j))~=1))]
end
%now ok

%GMlist_c = GMlist
%GMlist_c = array2table([GMlist_c.i string(GMlist_c.key)])
%GMlist_c.Properties.VariableNames = ["i" "key"]
%GMlist_c.i = str2double(GMlist_c.i)
%pixsolroll_tab = join(GMlist_c, pixsolroll_tab,"Key","i")

%%%save for second part
%writetable(pixsolroll_tab,"D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Data\gov_2050_budget_results_pix_GISsim_EWCO_17_06_2025.txt")
%writetable(pixsolroll_tab,"D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Data\gov_2050_budget_results_pix_GISsim_EWCO_18_06_2025.txt")
%writetable(pixsolroll_tab,"D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Data\gov_2050_budget_results_pix_GISsim_EWCO_23_06_2025.txt")
%writetable(pixsolroll_tab,"D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Data\gov_2050_budget_results_pix_GISsim_EWCO_25_06_2025.txt")
%writetable(pixsolroll_tab,"D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Data\gov_2050_budget_results_pix_GISsim_EWCO_01_07_2025.txt")
%writetable(pixsolroll_tab,"D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Data\gov_2050_budget_results_pix_GISsim_EWCO_02_07_2025.txt")
%writetable(pixsolroll_tab,"D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Data\gov_2050_budget_results_pix_GISsim_EWCO_03_07_2025.txt")
%writetable(pixsolroll_tab,"D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Data\gov_2050_budget_results_pix_GISsim_EWCO_16_07_2025.txt")
%writetable(pixsolroll_tab,"D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Data\gov_2050_budget_results_pix_GISsim_EWCO_17_07_2025.txt")
writetable(pixsolroll_tab,strcat(output_directory,postsim_out))

%STOP 2

%%%%%%%%%%%[2] UPDATING WORKSPACE FILES
%%%%%%%%%Woodland simulations after government priority (26/04/24)
%    if (type_sim == "set_aside_only" | type_sim == "RAS_all_delta_set_aside" | type_sim == "RAS_&_AD_set_aside" | type_sim == "set_aside_only_nocalconstraint" | type_sim == "RAS_all_delta_set_aside_nocalconstraint" | type_sim == "set_aside_only_gis" )
clearvars -except input_directory output_directory midfile postsim_out ref_midfile timing r_inp_output_directory_1 timing_here r_inp_input_directory_1
%cd 'D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Data\sim_RAS_general_dump\'
%cd 'D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Data\sim_PMP_EE_AFRASTECHV_wageREP_wooddump\'
%cd 'D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Data\sim_PMP_EE_woodquad_2grants\wooddump\'

%all sims
%listofsimsup = dir('*TU0*.mat*')
%listofsimsup = struct2table(listofsimsup)
%listofsimsup = listofsimsup(:,1)
%no AD, remove
%listofsimsup = listofsimsup(2:height(listofsimsup),:)

%for kjjj = 1:height(listofsimsup)
%cd 'D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Data\sim_PMP_EE_woodquad_2grants\wooddump\'
%jj = 12
%kjjj = 10
%kjjj = 1
%kjjj = 2
kjjj = 1
    listofsimsup = array2table(string(strcat(output_directory,midfile)))
    clear rolling_tab rolling_out_tab rolling_out_sim_tab

        load(strcat(output_directory,midfile))
                output_directory = r_inp_output_directory_1


        %        load("D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Data\sim_RAS_water_LQ_NM_Nix_2023_extern_calib_01_05_24\rolling_rolling_out\workspace_rolling_rolling_out_calibration_30_04_24.mat")
%        load("D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\workspace_rolling_rolling_out_calibration_30_07_24.mat")
%        load("D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Data\sim_PMP_EE_woodquad\calibration\workspace_rolling_rolling_out_calibration_woodquad_20_05_25.mat")
        load(strcat(r_inp_input_directory_1,"workspace_rolling_rolling_out_calibration_woodquad_2woodgrants_17_06_25.mat"))
         clear RAS_CAPEX_annuity
         RAS_CAPEX_annuity = RAS_CAPEX/NPV_RAS
%HP
%         cd 'G:\LEEP\Sustainable_Prawn\'
         %%%%13/03 kcal fix
try
         vec_GM_RAS_store = vec_GM_RAS   
catch
        "no vec GM_RAS"
end    
         %upload_basic_data   
%        cd 'D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Data\sim_RAS_general_dump\'
%        cd 'D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Data\sim_PMP_EE_AFRASTECHV_wageREP_wooddump\'
%        cd 'D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Data\sim_PMP_EE_woodquad_2grants\'
         display(kjjj)
        rolling_tab = array2table(rolling)
        height(rolling_tab)
        rolling_out_tab = array2table(rolling_out)
        height(rolling_out_tab)
        
        rolling_tab.Properties.VariableNames = ["i" "d_cropless" "maxerror_crop" "maxerror_forage" "maxerror_animal" "maxerror_tree" "bind_const"]
        rolling_out_tab.Properties.VariableNames = ["i" [crops(1:3)' "fodder" crops(5:12)'] forages' trees' animals' "GM_BL" "lambda_land_target" "lambda_labour_target" "lambda_water_target" "lambda_land_LP" "lambda_labour_LP" "lambda_water_LP"]


        %%%%1.b, rolling_out_sim_RAS
        
        rolling_out_sim_tab = array2table(rolling_out_sim_RAS)
   %Attention: empty = 1 
   switch type_sim 
            case {"set_aside_only","set_aside_only_gis"}
                %orig: rolling_out_sim_aside = [rolling_out_sim_aside ; [i sol_sim.area_crop' sol_sim.area_forage' sollives' GM_gain_aside_net fval_sim obj_fun_sim_val GM_agric_no_aside sub_aside area_set_aside_sim kcal_sim kcal_BL share_land_set_aside share_labour_set_aside]]
                rolling_out_sim_tab = array2table(rolling_out_sim_aside)
                rolling_out_sim_tab.Properties.VariableNames = ["i" [crops(1:3)' "fodder" crops(5:12)'] forages' trees' animals' "GM_gain_aside_net" "fval_sim" "obj_fun_sim_val" "GM_agric_no_aside" "sub_aside" "kcal_sim" "kcal_BL" "share_land_set_aside" "share_labour_set_aside" "share_water_set_aside"]
                sim_name = strcat(type_sim,"_ras_sub_",string(0))
            case {"set_aside_only_nocalconstraint","set_aside_only_nocalconstraint_Eng", "set_aside_only_gis_nocalconstraint", "set_aside_only_gis_nocalconstraint_EWCO"}
                %orig (equal previous):rolling_out_sim_aside = [rolling_out_sim_aside ; [i sol_sim.area_crop' sol_sim.area_forage' sollives' GM_gain_aside_net fval_sim obj_fun_sim_val GM_agric_no_aside sub_aside area_set_aside_sim kcal_sim kcal_BL share_land_set_aside share_labour_set_aside]]
                rolling_out_sim_tab = array2table(rolling_out_sim_aside)
                rolling_out_sim_tab.Properties.VariableNames = ["i" [crops(1:3)' "fodder" crops(5:12)'] forages' trees' animals' "GM_gain_aside_net" "fval_sim" "obj_fun_sim_val" "GM_agric_no_aside" "sub_aside" "kcal_sim" "kcal_BL" "share_land_set_aside" "share_labour_set_aside" "share_water_set_aside"]
                sim_name = type_sim
            case {"RAS_all_delta_set_aside","RAS_all_delta_set_aside_nocalconstraint","RAS_all_delta_set_aside_nocalconstraint_v_irate", "RAS_all_delta_set_aside_nocalconstraint_irate_2p", "RAS_aside_nocalconst_sub_fix_unit", "RAS_aside_nocalconst_sub_fix_unit_two","RAS_all_delta_set_aside_nocalconstraint_wq","RAS_aside_nocalconst_sub_fix_unit_two_wq"}
                %orig: rolling_out_sim_RAS_by_unit = [rolling_out_sim_RAS_by_unit ; [i g sol_sim.area_crop' sol_sim.area_forage' sollives' GM_gain_RAS_net (fval_target - fval_sim) (area_RAS*vec_GM_RAS) fval_sim obj_fun_sim_val share_land_RAS share_labour_RAS area_RAS area_set_aside_sim kcal_sim kcal_BL share_land_set_aside share_labour_set_aside share_kcal_RAS d_one_unit_unfeasible]]
                rolling_out_sim_tab.Properties.VariableNames = ["i" "best_RAS_units" [crops(1:3)' "fodder" crops(5:12)'] forages' trees' animals' "GM_gain_RAS_net" "GM_agr_change" "GM_RAS" "fval_sim" "obj_fun_sim_val" "share_land_RAS" "share_labour_RAS" "share_water_RAS" "area_RAS" "kcal_sim" "kcal_BL" "share_land_set_aside" "share_labour_set_aside" "share_water_set_aside" "share_kcal_RAS" "sub_aside" "d_one_unit_unfeasible"]
                if contains(string(table2array(listofsimsup(kjjj,:))),"IR002") ==1
                                sim_name = strcat(type_sim,"_IR002")
                else
                                sim_name = strrep(strrep(strcat(type_sim,"_ras_sub_",string(ras_sub)),"0.5","0_5"),"1.5","1_5")               
                end

       case {"RAS_&_AD_set_aside", "RAS_&_AD_set_aside_heat", "RAS_&_AD_set_aside_nocalconstraint"}
                %orig: rolling_out_sim_RAS = [rolling_out_sim_RAS ; [i best_option_g best_option_LU best_option_name best_option_value option_val_list_tab.Option_1_NCF(1) option_val_list_tab.Option_2_NCF(1) option_val_list_tab.Option_3_NCF(1) option_val_list_tab.Option_4_NCF(1) share_land_RAS share_labour_RAS area_set_aside_sim kcal_BL share_land_set_aside share_labour_set_aside share_kcal_RAS]]
                %OBS: kcal_sim eliminated as must equal kcal_BL since it is an
                %equality constraint (the two were in the previous merely for
                %checking)
                rolling_out_sim_tab.Properties.VariableNames = ["i" "best_RAS_units" [crops(1:3)' "fodder" crops(5:12)'] forages' animals' "best_option_name" "best_option_value" "Option_1_NCF" "Option_2_NCF" "Option_3_NCF" "Option_4_NCF" "share_land_RAS" "share_labour_RAS" "share_water_RAS" "area_set_aside_sim" "kcal_BL" "share_land_aside" "share_labour_aside" "share_water_aside" "share_kcal_RAS"]
                sim_name = strcat(type_sim,"_TU_",string(topup_set_aside))
        end
          
        %%%Budget priority wood%%%Budget priority wood%%%Budget priority wood%%%Budget priority wood
        %OBS: update [1] here
   
%        priopix = readtable("D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Data\gov_2050_budget_results_pix_GISsim_EWCO_17_06_2025.txt")
%        priopix = readtable("D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Data\gov_2050_budget_results_pix_GISsim_EWCO_18_06_2025.txt")
%        priopix = readtable("D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Data\gov_2050_budget_results_pix_GISsim_EWCO_23_06_2025.txt")
%        priopix = readtable("D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Data\gov_2050_budget_results_pix_GISsim_EWCO_25_06_2025.txt")
%        priopix = readtable("D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Data\gov_2050_budget_results_pix_GISsim_EWCO_02_07_2025.txt")
%        priopix = readtable("D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Data\gov_2050_budget_results_pix_GISsim_EWCO_03_07_2025.txt")
%        priopix = readtable("D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Data\gov_2050_budget_results_pix_GISsim_EWCO_16_07_2025.txt")
%        priopix = readtable("D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Data\gov_2050_budget_results_pix_GISsim_EWCO_17_07_2025.txt")
%        priopix = readtable("D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Emulation_2025\simulations\RAS_all_delta_SLQ_BL_lowres_ras_sub_0\gov_2050_post_RAS_ras_sub_0_07_26.txt")
%        priopix = readtable("D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Emulation_2025\simulations\RAS_all_delta_SLQ_BL_lowres_ras_sub_0\gov_2050_post_RAS_ras_sub_0_07_26.txt")
        priopix = readtable(strcat(output_directory,postsim_out))
        
        posRASAD = (find(contains(string(priopix.Properties.VariableNames),"RAS__")))
        priopix.Properties.VariableNames(posRASAD) = replace(priopix.Properties.VariableNames(posRASAD),"RAS__","RAS_&")
        %string(priopix.Properties.VariableNames)

        %Removing sims RAS exp if not the case
        if contains(sim_name,"Rex")==0
            priopix(:,find(contains(string(priopix.Properties.VariableNames),"Rex")==1))  = []
        end
        %selecting only running column
        priopixtab = priopix(:,[1,find(contains(string(priopix.Properties.VariableNames),sim_name)==1)])

        priopixtab.Properties.VariableNames = ["i" "dummy_pix"]

        if (type_sim == "set_aside_only" | type_sim == "set_aside_only_nocalconstraint" | type_sim == "set_aside_only_nocalconstraint_Eng")

%joining dummy_pix to ref and sim DS
        rolling_out_sim_tab = join(priopixtab,rolling_out_sim_tab,"Keys","i");
        reference_tab = join(priopixtab,rolling_out_tab,"Keys","i");
        %making sure rows are the same in ref and sim
        rownorm = array2table(rolling_out_sim_tab.i)
        rownorm.Properties.VariableNames = ["i"]
        reference_tab = join(rownorm,reference_tab,"Keys","i")
        %sorting both on i to make sure equal rows = equal pixels
        rolling_out_sim_tab = sortrows(rolling_out_sim_tab,"i");
        reference_tab = sortrows(reference_tab,"i");

rolling_out_sim_tab.Properties.VariableNames
%rolling_out_sim_tab1 = rolling_out_sim_tab
%updating 1: LUs (Obs: ('') because of fields with spaces)
for kji = ["Barley", "Beans", "Field vegetables", "fodder", "Oats" "OSR", "Other cereals (triticale)", "Peas", "Potatoes", "Sugar beet", "Top and soft fruit", "Wheat", "Forage: grassland over five / permanent grassland" , "Forage: grassland under five / temporary grassland", "Rough grazing", "Animal: Beef cattle", "Animal: Dairy cow", "Animal: Sheep" ]
eval(strcat("rolling_out_sim_tab.('",kji, "')(find(rolling_out_sim_tab.dummy_pix==0)) = reference_tab.('",kji,"')(find(reference_tab.dummy_pix==0))")) 
end

%updating 2: area and sub
rolling_out_sim_tab.sub_aside(find(rolling_out_sim_tab.dummy_pix==0)) = 0 

%updating 3: GM-related: GM_gain_aside_net, fval_sim obj_fun_sim_val, GM_agric_no_aside
%making fval_sim = fval_target
%GM_gain_aside_net = -(fval_target - fval_sim) --> 
%fval_target= fval_sim - GM_gain_aside_net = fval_sim - (-(fval_target - fval_sim)) =
rolling_out_sim_tab.fval_sim(find(rolling_out_sim_tab.dummy_pix==0)) = rolling_out_sim_tab.fval_sim(find(rolling_out_sim_tab.dummy_pix==0)) - rolling_out_sim_tab.GM_gain_aside_net(find(rolling_out_sim_tab.dummy_pix==0))
%GM_gain_aside_net = -(fval_target - fval_sim)
rolling_out_sim_tab.GM_gain_aside_net(find(rolling_out_sim_tab.dummy_pix==0)) = 0 
%obj_fun_sim_val = vec_REV_crop(id_act_crop)'*sol_sim.area_crop(id_act_crop) - 1/2*calib_crop(:,1)'*sol_sim.area_crop(id_act_crop).^2 + mat_GM_nofor_forage_m(i,id_act_forage)*sol_sim.area_forage(id_act_forage) - 1/2*calib_forage(:,1)'*sol_sim.area_forage(id_act_forage).^2 + (sub_set_aside+topup_set_aside)*area_set_aside_sim
rolling_out_sim_tab.obj_fun_sim_val(find(rolling_out_sim_tab.dummy_pix==0)) = rolling_out_sim_tab.fval_sim(find(rolling_out_sim_tab.dummy_pix==0))
%GM_agric_no_aside = vec_REV_crop(id_act_crop)'*sol_sim.area_crop(id_act_crop) - 1/2*calib_crop(:,1)'*sol_sim.area_crop(id_act_crop).^2 + mat_GM_nofor_forage_m(i,id_act_forage)*sol_sim.area_forage(id_act_forage) - 1/2*calib_forage(:,1)'*sol_sim.area_forage(id_act_forage).^2
rolling_out_sim_tab.GM_agric_no_aside(find(rolling_out_sim_tab.dummy_pix==0)) = rolling_out_sim_tab.obj_fun_sim_val(find(rolling_out_sim_tab.dummy_pix==0))

%updating 4: share set-aside
rolling_out_sim_tab.share_land_set_aside(find(rolling_out_sim_tab.dummy_pix==0)) = 0 
rolling_out_sim_tab.share_labour_set_aside(find(rolling_out_sim_tab.dummy_pix==0)) = 0 
rolling_out_sim_tab.share_water_set_aside(find(rolling_out_sim_tab.dummy_pix==0)) = 0 
%updating 5: share RAS
%DA
%updating 6: kcal
rolling_out_sim_tab.kcal_sim(find(rolling_out_sim_tab.dummy_pix==0)) = rolling_out_sim_tab.kcal_BL(find(rolling_out_sim_tab.dummy_pix==0))
%removing dummy_pix
dummpixpos = find(contains(string(rolling_out_sim_tab.Properties.VariableNames),"dummy_pix"))
rolling_out_sim_tab = rolling_out_sim_tab(:,[1:(dummpixpos-1),(dummpixpos+1):width(rolling_out_sim_tab)])

%save updated file
rolling_out_sim_aside_update = table2array(rolling_out_sim_tab)
clearvars -except rolling_out_sim_aside_update listofsimsup kjjj output_directory midfile postsim_out ref_midfile timing r_inp_output_directory_1 timing_here r_inp_input_directory_1
load(strcat(output_directory,midfile))
        output_directory = r_inp_output_directory_1

rolling_out_sim_aside = rolling_out_sim_aside_update


        end
%        if ((type_sim == "RAS_all_delta_set_aside" | type_sim == "RAS_all_delta_set_aside_nocalconstraint") & string(table2array(listofsimsup(kjjj,:))) ~= "workspace_RAS_all_delta_set_aside_[SENSITIVITY]_(alpha_50%)_(EQ_alpha50%)_TU0_01_08_24.mat")
%        if ((type_sim == "RAS_all_delta_set_aside" | type_sim == "RAS_all_delta_set_aside_nocalconstraint") & string(table2array(listofsimsup(kjjj,:))) ~= "workspace_RAS_set_aside_nocalconst_[SENSITIVITY]_(alpha_10%)_(EQ_price_alpha_8th)_TU0_05_08_24.mat")
%        if ((type_sim == "RAS_all_delta_set_aside" | (type_sim == "RAS_all_delta_set_aside_nocalconstraint") & string(table2array(listofsimsup(kjjj,:))) ~= "workspace_RAS_all_delta_set_aside_[SENSITIVITY]_alpha010_(EQ)_TU0_13_01_25.mat"))
        if (type_sim == "RAS_all_delta_set_aside" | (type_sim == "RAS_all_delta_set_aside_nocalconstraint_wq" & contains(sim_name,"IR002") ==0))
%RET
%joining dummy_pix to ref and sim DS
        rolling_out_sim_tab = join(priopixtab,rolling_out_sim_tab,"Keys","i");
%RAS sim ref
        load(strcat(output_directory,ref_midfile))
        output_directory = r_inp_output_directory_1

        rolling_out_sim_tab_ref = array2table(rolling_out_sim_RAS)
        rolling_out_sim_tab_ref.Properties.VariableNames = ["i" "best_RAS_units" [crops(1:3)' "fodder" crops(5:12)'] forages' trees' animals' "GM_gain_RAS_net" "GM_agr_change" "GM_RAS" "fval_sim" "obj_fun_sim_val" "share_land_RAS" "share_labour_RAS" "share_water_RAS" "area_RAS" "d_none_or_one_unit_unfeasible"]
        reference_tab = join(priopixtab,rolling_out_sim_tab_ref,"Keys","i");

        %making sure rows are the same in ref and sim
        rownorm = array2table(rolling_out_sim_tab.i)
        rownorm.Properties.VariableNames = ["i"]
        reference_tab = join(rownorm,reference_tab,"Keys","i")
        %sorting both on i to make sure equal rows = equal pixels
        rolling_out_sim_tab = sortrows(rolling_out_sim_tab,"i");
        reference_tab = sortrows(reference_tab,"i");

rolling_out_sim_tab.Properties.VariableNames
reference_tab.Properties.VariableNames

%rolling_out_sim_tab1 = rolling_out_sim_tab
%updating 1: LUs (Obs: ('') because of fields with spaces)
%for kji = ["Barley", "Beans", "Field vegetables", "fodder", "Oats", "OSR", "Other cereals (triticale)", "Peas", "Potatoes", "Sugar beet", "Top and soft fruit", "Wheat", "Forage: grassland over five / permanent grassland" , "Forage: grassland under five / temporary grassland", "Rough grazing", "Animal: Beef cattle", "Animal: Dairy cow", "Animal: Sheep" ]
for kji = ["Barley", "Beans", "Field vegetables", "fodder", "Oats", "OSR", "Other cereals (triticale)", "Peas", "Potatoes", "Sugar beet", "Top and soft fruit", "Wheat", "Forage: grassland over five / permanent grassland" , "Forage: grassland under five / temporary grassland", "Rough grazing","Broadleaved", "Conifer", "Animal: Beef cattle", "Animal: Dairy cow", "Animal: Sheep" ]
    eval(strcat("rolling_out_sim_tab.('",kji, "')(find(rolling_out_sim_tab.dummy_pix==0)) = reference_tab.('",kji,"')(find(reference_tab.dummy_pix==0))")) 
end

%updating 3: GM-related: only best_option_value
for kjji = ["GM_gain_RAS_net", "GM_agr_change", "GM_RAS", "fval_sim", "obj_fun_sim_val"]
eval(strcat("rolling_out_sim_tab.('",kjji, "')(find(rolling_out_sim_tab.dummy_pix==0)) = reference_tab.('",kjji,"')(find(reference_tab.dummy_pix==0))")) 
end
 

%updating 4: share set-aside
rolling_out_sim_tab.share_land_set_aside(find(rolling_out_sim_tab.dummy_pix==0)) = 0 
rolling_out_sim_tab.share_labour_set_aside(find(rolling_out_sim_tab.dummy_pix==0)) = 0 
rolling_out_sim_tab.share_water_set_aside(find(rolling_out_sim_tab.dummy_pix==0)) = 0 

%updating 5: share RAS
rolling_out_sim_tab.share_land_RAS(find(rolling_out_sim_tab.dummy_pix==0)) = reference_tab.share_land_RAS(find(reference_tab.dummy_pix==0)) 
rolling_out_sim_tab.share_labour_RAS(find(rolling_out_sim_tab.dummy_pix==0)) = reference_tab.share_labour_RAS(find(reference_tab.dummy_pix==0)) 
rolling_out_sim_tab.share_water_RAS(find(rolling_out_sim_tab.dummy_pix==0)) = reference_tab.share_water_RAS(find(reference_tab.dummy_pix==0)) 

%updating 6: kcal
%OBS: kcal sim not calculated in ref file
rolling_out_sim_tab.kcal_sim = repelem(NaN,height(rolling_out_sim_tab))'

%updating 7: RAS units & d_unit_unfeasible & area_RAS
rolling_out_sim_tab.best_RAS_units(find(rolling_out_sim_tab.dummy_pix==0)) = reference_tab.best_RAS_units(find(reference_tab.dummy_pix==0)) 
rolling_out_sim_tab.d_one_unit_unfeasible(find(rolling_out_sim_tab.dummy_pix==0)) = reference_tab.d_none_or_one_unit_unfeasible(find(reference_tab.dummy_pix==0)) 
rolling_out_sim_tab.area_RAS(find(rolling_out_sim_tab.dummy_pix==0)) = reference_tab.area_RAS(find(reference_tab.dummy_pix==0)) 

%updating 8: wood subsidy
rolling_out_sim_tab.sub_aside(find(rolling_out_sim_tab.dummy_pix==0)) = 0

%removing dummy_pix
dummpixpos = find(contains(string(rolling_out_sim_tab.Properties.VariableNames),"dummy_pix"))
rolling_out_sim_tab = rolling_out_sim_tab(:,[1:(dummpixpos-1),(dummpixpos+1):width(rolling_out_sim_tab)])

%save updated file
rolling_out_sim_RAS_update = table2array(rolling_out_sim_tab)
clearvars -except rolling_out_sim_RAS_update listofsimsup kjjj sim_name output_directory midfile postsim_out ref_midfile timing r_inp_output_directory_1 timing_here r_inp_input_directory_1
load(strcat(output_directory,midfile))
        output_directory = r_inp_output_directory_1

rolling_out_sim_RAS = rolling_out_sim_RAS_update

        
 end
        if (type_sim == "RAS_&_AD_set_aside" | type_sim == "RAS_&_AD_set_aside_nocalconstraint")

%joining dummy_pix to ref and sim DS
        rolling_out_sim_tab = join(priopixtab,rolling_out_sim_tab,"Keys","i");
%RAS sim ref
%        load("D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Data\sim_RAS_water_LQ_NM_Nix_2023_extern_calib_01_05_24\workspace_RAS_&_AD_(empirdem)_(meat_6th_pseudo_EQ_price)_06_06_24.mat")
%        load("D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Data\sim_PMP_EE_AFRASTECHV\workspace_RAS_&_AD_(meat_pseudo_1)_01_11_24.mat")
%        load("D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Data\sim_PMP_EE_woodquad_2grants\workspace_wageREP_RAS_and_AD_lowres_wageREP_19.5652__2025_02_10_04_40_50_06_02_25.mat")

        rolling_out_sim_tab_ref = array2table(rolling_out_sim_RAS)
        rolling_out_sim_tab_ref.Properties.VariableNames = ["i" "best_RAS_units" [crops(1:3)' "fodder" crops(5:12)'] forages' animals' "best_option_name" "best_option_value" "Option_1_NCF" "Option_2_NCF" "Option_3_NCF" "Option_4_NCF" "share_land_RAS" "share_labour_RAS" "share_water_RAS"]
        reference_tab = join(priopixtab,rolling_out_sim_tab_ref,"Keys","i");

        %making sure rows are the same in ref and sim
        rownorm = array2table(rolling_out_sim_tab.i)
        rownorm.Properties.VariableNames = ["i"]
        reference_tab = join(rownorm,reference_tab,"Keys","i")
        %sorting both on i to make sure equal rows = equal pixels
        rolling_out_sim_tab = sortrows(rolling_out_sim_tab,"i");
        reference_tab = sortrows(reference_tab,"i");

rolling_out_sim_tab.Properties.VariableNames
reference_tab.Properties.VariableNames

%rolling_out_sim_tab1 = rolling_out_sim_tab
%updating 1: LUs (Obs: ('') because of fields with spaces)
for kji = ["Barley", "Beans", "Field vegetables", "fodder", "Oats", "OSR", "Other cereals (triticale)", "Peas", "Potatoes", "Sugar beet", "Top and soft fruit", "Wheat", "Forage: grassland over five / permanent grassland" , "Forage: grassland under five / temporary grassland", "Rough grazing", "Animal: Beef cattle", "Animal: Dairy cow", "Animal: Sheep" ]
eval(strcat("rolling_out_sim_tab.('",kji, "')(find(rolling_out_sim_tab.dummy_pix==0)) = reference_tab.('",kji,"')(find(reference_tab.dummy_pix==0))")) 
end

%updating 3: GM-related: only best_option_value
for kjji = ["best_option_value", "Option_1_NCF", "Option_2_NCF", "Option_3_NCF", "Option_4_NCF"]
eval(strcat("rolling_out_sim_tab.('",kjji, "')(find(rolling_out_sim_tab.dummy_pix==0)) = reference_tab.('",kjji,"')(find(reference_tab.dummy_pix==0))")) 
end
 

%updating 4: share set-aside
rolling_out_sim_tab.share_land_aside(find(rolling_out_sim_tab.dummy_pix==0)) = 0 
rolling_out_sim_tab.share_labour_aside(find(rolling_out_sim_tab.dummy_pix==0)) = 0 
rolling_out_sim_tab.share_water_aside(find(rolling_out_sim_tab.dummy_pix==0)) = 0 

%updating 5: share RAS
rolling_out_sim_tab.share_land_RAS(find(rolling_out_sim_tab.dummy_pix==0)) = reference_tab.share_land_RAS(find(reference_tab.dummy_pix==0)) 
rolling_out_sim_tab.share_labour_RAS(find(rolling_out_sim_tab.dummy_pix==0)) = reference_tab.share_labour_RAS(find(reference_tab.dummy_pix==0)) 
rolling_out_sim_tab.share_kcal_RAS(find(rolling_out_sim_tab.dummy_pix==0)) = NaN

%updating 6: kcal
%OBS: kcal sim not calculated in sim nor ref file

%updating 7: RAS units & d_unit_unfeasible & area_RAS
rolling_out_sim_tab.best_RAS_units(find(rolling_out_sim_tab.dummy_pix==0)) = reference_tab.best_RAS_units(find(reference_tab.dummy_pix==0)) 
rolling_out_sim_tab.best_option_name(find(rolling_out_sim_tab.dummy_pix==0)) = reference_tab.best_option_name(find(reference_tab.dummy_pix==0)) 

%removing dummy_pix
dummpixpos = find(contains(string(rolling_out_sim_tab.Properties.VariableNames),"dummy_pix"))
rolling_out_sim_tab = rolling_out_sim_tab(:,[1:(dummpixpos-1),(dummpixpos+1):width(rolling_out_sim_tab)])

%save file
rolling_out_sim_RAS_update = table2array(rolling_out_sim_tab)
clearvars -except rolling_out_sim_RAS_update listofsimsup kjjj output_directory midfile postsim_out ref_midfile timing r_inp_output_directory_1 timing_here r_inp_input_directory_1
load(string(table2array(listofsimsup(kjjj,:))))
        output_directory = r_inp_output_directory_1

rolling_out_sim_RAS = rolling_out_sim_RAS_update


        end

if (type_sim == "set_aside_only_gis" | type_sim == "set_aside_only_gis_nocalconstraint" | type_sim == "set_aside_only_gis_nocalconstraint_EWCO")       
%joining dummy_pix to ref and sim DS
        rolling_out_sim_tab = join(priopixtab,rolling_out_sim_tab,"Keys","i");
        reference_tab = join(priopixtab,rolling_out_tab,"Keys","i");
        %making sure rows are the same in ref and sim
        rownorm = array2table(rolling_out_sim_tab.i)
        rownorm.Properties.VariableNames = ["i"]
        reference_tab = join(rownorm,reference_tab,"Keys","i")
        %sorting both on i to make sure equal rows = equal pixels
        rolling_out_sim_tab = sortrows(rolling_out_sim_tab,"i");
        reference_tab = sortrows(reference_tab,"i");

rolling_out_sim_tab.Properties.VariableNames
%rolling_out_sim_tab1 = rolling_out_sim_tab
%updating 1: LUs (Obs: ('') because of fields with spaces)
for kji = ["Barley", "Beans", "Field vegetables", "fodder", "Oats", "OSR", "Other cereals (triticale)", "Peas", "Potatoes", "Sugar beet", "Top and soft fruit", "Wheat", "Forage: grassland over five / permanent grassland" , "Forage: grassland under five / temporary grassland", "Rough grazing", "Animal: Beef cattle", "Animal: Dairy cow", "Animal: Sheep", "Broadleaved", "Conifer"]
eval(strcat("rolling_out_sim_tab.('",kji, "')(find(rolling_out_sim_tab.dummy_pix==0)) = reference_tab.('",kji,"')(find(reference_tab.dummy_pix==0))")) 
end

%updating 2: subsidy
rolling_out_sim_tab.sub_aside(find(rolling_out_sim_tab.dummy_pix==0)) = 0 

%updating 3: GM-related: GM_gain_aside_net, fval_sim obj_fun_sim_val, GM_agric_no_aside
%making fval_sim = fval_target
%GM_gain_aside_net = -(fval_target - fval_sim) --> 
%fval_target= fval_sim - GM_gain_aside_net = fval_sim - (-(fval_target - fval_sim)) =
rolling_out_sim_tab.fval_sim(find(rolling_out_sim_tab.dummy_pix==0)) = rolling_out_sim_tab.fval_sim(find(rolling_out_sim_tab.dummy_pix==0)) - rolling_out_sim_tab.GM_gain_aside_net(find(rolling_out_sim_tab.dummy_pix==0))
%GM_gain_aside_net = -(fval_target - fval_sim)
rolling_out_sim_tab.GM_gain_aside_net(find(rolling_out_sim_tab.dummy_pix==0)) = 0 
%obj_fun_sim_val = vec_REV_crop(id_act_crop)'*sol_sim.area_crop(id_act_crop) - 1/2*calib_crop(:,1)'*sol_sim.area_crop(id_act_crop).^2 + mat_GM_nofor_forage_m(i,id_act_forage)*sol_sim.area_forage(id_act_forage) - 1/2*calib_forage(:,1)'*sol_sim.area_forage(id_act_forage).^2 + (sub_set_aside+topup_set_aside)*area_set_aside_sim
rolling_out_sim_tab.obj_fun_sim_val(find(rolling_out_sim_tab.dummy_pix==0)) = rolling_out_sim_tab.fval_sim(find(rolling_out_sim_tab.dummy_pix==0))
%GM_agric_no_aside = vec_REV_crop(id_act_crop)'*sol_sim.area_crop(id_act_crop) - 1/2*calib_crop(:,1)'*sol_sim.area_crop(id_act_crop).^2 + mat_GM_nofor_forage_m(i,id_act_forage)*sol_sim.area_forage(id_act_forage) - 1/2*calib_forage(:,1)'*sol_sim.area_forage(id_act_forage).^2
rolling_out_sim_tab.GM_agric_no_aside(find(rolling_out_sim_tab.dummy_pix==0)) = rolling_out_sim_tab.obj_fun_sim_val(find(rolling_out_sim_tab.dummy_pix==0))

%updating 4: share set-aside
rolling_out_sim_tab.share_land_set_aside(find(rolling_out_sim_tab.dummy_pix==0)) = 0 
rolling_out_sim_tab.share_labour_set_aside(find(rolling_out_sim_tab.dummy_pix==0)) = 0 
rolling_out_sim_tab.share_water_set_aside(find(rolling_out_sim_tab.dummy_pix==0)) = 0 
%updating 5: share RAS
%DA
%updating 6: kcal
rolling_out_sim_tab.kcal_sim(find(rolling_out_sim_tab.dummy_pix==0)) = rolling_out_sim_tab.kcal_BL(find(rolling_out_sim_tab.dummy_pix==0))
%removing dummy_pix
dummpixpos = find(contains(string(rolling_out_sim_tab.Properties.VariableNames),"dummy_pix"))
rolling_out_sim_tab = rolling_out_sim_tab(:,[1:(dummpixpos-1),(dummpixpos+1):width(rolling_out_sim_tab)])

%save updated file
rolling_out_sim_aside_update = table2array(rolling_out_sim_tab)
clearvars -except rolling_out_sim_aside_update listofsimsup kjjj output_directory midfile postsim_out ref_midfile timing r_inp_output_directory_1 timing_here r_inp_input_directory_1
load(strcat(output_directory,midfile))
        output_directory = r_output_directory_1

rolling_out_sim_aside = rolling_out_sim_aside_update

end


%        if (type_sim == "RAS_all_delta_set_aside_nocalconstraint" & string(table2array(listofsimsup(kjjj,:))) == "workspace_RAS_all_delta_set_aside_[SENSITIVITY]_(alpha_50%)_(EQ_alpha50%)_TU0_01_08_24.mat")
%       if (type_sim == "RAS_all_delta_set_aside_nocalconstraint" & string(table2array(listofsimsup(kjjj,:))) == "workspace_RAS_set_aside_nocalconst_[SENSITIVITY]_(alpha_10%)_(EQ_price_alpha_8th)_TU0_05_08_24.mat")
       if (type_sim == "RAS_all_delta_set_aside_nocalconstraint" & string(table2array(listofsimsup(kjjj,:))) == "workspace_RAS_all_delta_set_aside_sensitivity_alpha010_afwageREP_(EQ)_TU0_[SENSITIVITY]_09_02_25.mat")
           
%joining dummy_pix to ref and sim DS
        rolling_out_sim_tab = join(priopixtab,rolling_out_sim_tab,"Keys","i");
%RAS sim ref
%        load("D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Data\sim_RAS_sensitivity_EQ_price_finaL_sims_18_06_24\workspace_RAS_all_delta_[SENSITIVITY]_(alpha_50%)_(meat_3rd_pseudo_EQ_price)_17_06_24.mat")
%        load("D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Data\sim_RAS_sensitivity_30_07_2024\workspace_RAS_all_delta_nocalconst_TU0_[SENSITIVITY]_(alpha_10%)_(8th_EQ_price)_03_08_24.mat")
        load(strcat(output_directory,ref_midfile))
        output_directory = r_inp_output_directory_1

        rolling_out_sim_tab_ref = array2table(rolling_out_sim_RAS)
        rolling_out_sim_tab_ref.Properties.VariableNames = ["i" "best_RAS_units" [crops(1:3)' "fodder" crops(5:12)'] forages' animals' "GM_gain_RAS_net" "GM_agr_change" "GM_RAS" "fval_sim" "obj_fun_sim_val" "share_land_RAS" "share_labour_RAS" "share_water_RAS" "area_RAS" "d_none_or_one_unit_unfeasible"]
        reference_tab = join(priopixtab,rolling_out_sim_tab_ref,"Keys","i");

        %making sure rows are the same in ref and sim
        rownorm = array2table(rolling_out_sim_tab.i)
        rownorm.Properties.VariableNames = ["i"]
        reference_tab = join(rownorm,reference_tab,"Keys","i")
        %sorting both on i to make sure equal rows = equal pixels
        rolling_out_sim_tab = sortrows(rolling_out_sim_tab,"i");
        reference_tab = sortrows(reference_tab,"i");

rolling_out_sim_tab.Properties.VariableNames
reference_tab.Properties.VariableNames

%rolling_out_sim_tab1 = rolling_out_sim_tab
%updating 1: LUs (Obs: ('') because of fields with spaces)
for kji = ["Barley", "Beans", "Field vegetables", "fodder", "Oats", "OSR", "Other cereals (triticale)", "Peas", "Potatoes", "Sugar beet", "Top and soft fruit", "Wheat", "Forage: grassland over five / permanent grassland" , "Forage: grassland under five / temporary grassland", "Rough grazing", "Animal: Beef cattle", "Animal: Dairy cow", "Animal: Sheep" ]
eval(strcat("rolling_out_sim_tab.('",kji, "')(find(rolling_out_sim_tab.dummy_pix==0)) = reference_tab.('",kji,"')(find(reference_tab.dummy_pix==0))")) 
end

%updating 3: GM-related: only best_option_value
for kjji = ["GM_gain_RAS_net", "GM_agr_change", "GM_RAS", "fval_sim", "obj_fun_sim_val"]
eval(strcat("rolling_out_sim_tab.('",kjji, "')(find(rolling_out_sim_tab.dummy_pix==0)) = reference_tab.('",kjji,"')(find(reference_tab.dummy_pix==0))")) 
end
 

%updating 4: share set-aside
rolling_out_sim_tab.share_land_set_aside(find(rolling_out_sim_tab.dummy_pix==0)) = 0 
rolling_out_sim_tab.share_labour_set_aside(find(rolling_out_sim_tab.dummy_pix==0)) = 0 
rolling_out_sim_tab.share_water_set_aside(find(rolling_out_sim_tab.dummy_pix==0)) = 0 

%updating 5: share RAS
rolling_out_sim_tab.share_land_RAS(find(rolling_out_sim_tab.dummy_pix==0)) = reference_tab.share_land_RAS(find(reference_tab.dummy_pix==0)) 
rolling_out_sim_tab.share_labour_RAS(find(rolling_out_sim_tab.dummy_pix==0)) = reference_tab.share_labour_RAS(find(reference_tab.dummy_pix==0)) 
rolling_out_sim_tab.share_water_RAS(find(rolling_out_sim_tab.dummy_pix==0)) = reference_tab.share_water_RAS(find(reference_tab.dummy_pix==0)) 

%updating 6: kcal
%OBS: kcal sim not calculated in ref file
rolling_out_sim_tab.kcal_sim = repelem(NaN,height(rolling_out_sim_tab))'

%updating 7: RAS units & d_unit_unfeasible & area_RAS
rolling_out_sim_tab.best_RAS_units(find(rolling_out_sim_tab.dummy_pix==0)) = reference_tab.best_RAS_units(find(reference_tab.dummy_pix==0)) 
rolling_out_sim_tab.d_one_unit_unfeasible(find(rolling_out_sim_tab.dummy_pix==0)) = reference_tab.d_none_or_one_unit_unfeasible(find(reference_tab.dummy_pix==0)) 
rolling_out_sim_tab.area_RAS(find(rolling_out_sim_tab.dummy_pix==0)) = reference_tab.area_RAS(find(reference_tab.dummy_pix==0)) 

%removing dummy_pix
dummpixpos = find(contains(string(rolling_out_sim_tab.Properties.VariableNames),"dummy_pix"))
rolling_out_sim_tab = rolling_out_sim_tab(:,[1:(dummpixpos-1),(dummpixpos+1):width(rolling_out_sim_tab)])

%save updated file
rolling_out_sim_RAS_update = table2array(rolling_out_sim_tab)
clearvars -except rolling_out_sim_RAS_update listofsimsup kjjj sim_name output_directory midfile postsim_out ref_midfile timing r_inp_output_directory_1 timing_here r_inp_input_directory_1
load(strcat(output_directory, midfile))
        output_directory = r_inp_output_directory_1

rolling_out_sim_RAS = rolling_out_sim_RAS_update

        end


%        if type_sim == "RAS_all_delta_set_aside_nocalconstraint_v_irate"
%        if type_sim == "RAS_all_delta_set_aside_nocalconstraint_irate_2p"
        if (type_sim == "RAS_all_delta_set_aside_nocalconstraint_wq" & contains(sim_name,"IR002") ==1)

            %joining dummy_pix to ref and sim DS
        rolling_out_sim_tab = join(priopixtab,rolling_out_sim_tab,"Keys","i");
%RAS sim ref
%        load("D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Data\workspace_sensitivity_RAS_sensitivity_ir002_19.8997__2025_02_08_09_57_59_07_02_25.mat")
        load(strcat(output_directory,ref_midfile))
        output_directory = r_inp_output_directory_1

        rolling_out_sim_tab_ref = array2table(rolling_out_sim_RAS)
        rolling_out_sim_tab_ref.Properties.VariableNames = ["i" "best_RAS_units" [crops(1:3)' "fodder" crops(5:12)'] forages' trees' animals' "GM_gain_RAS_net" "GM_agr_change" "GM_RAS" "fval_sim" "obj_fun_sim_val" "share_land_RAS" "share_labour_RAS" "share_water_RAS" "area_RAS" "d_none_or_one_unit_unfeasible"]
        reference_tab = join(priopixtab,rolling_out_sim_tab_ref,"Keys","i");

        %making sure rows are the same in ref and sim
        rownorm = array2table(rolling_out_sim_tab.i)
        rownorm.Properties.VariableNames = ["i"]
        reference_tab = join(rownorm,reference_tab,"Keys","i")
        %sorting both on i to make sure equal rows = equal pixels
        rolling_out_sim_tab = sortrows(rolling_out_sim_tab,"i");
        reference_tab = sortrows(reference_tab,"i");

rolling_out_sim_tab.Properties.VariableNames
reference_tab.Properties.VariableNames

%rolling_out_sim_tab1 = rolling_out_sim_tab
%updating 1: LUs (Obs: ('') because of fields with spaces)
for kji = ["Barley", "Beans", "Field vegetables", "fodder", "Oats", "OSR", "Other cereals (triticale)", "Peas", "Potatoes", "Sugar beet", "Top and soft fruit", "Wheat", "Forage: grassland over five / permanent grassland" , "Forage: grassland under five / temporary grassland", "Rough grazing", "Animal: Beef cattle", "Animal: Dairy cow", "Animal: Sheep","Broadleaved", "Conifer" ]
eval(strcat("rolling_out_sim_tab.('",kji, "')(find(rolling_out_sim_tab.dummy_pix==0)) = reference_tab.('",kji,"')(find(reference_tab.dummy_pix==0))")) 
end

%updating 3: GM-related: only best_option_value
for kjji = ["GM_gain_RAS_net", "GM_agr_change", "GM_RAS", "fval_sim", "obj_fun_sim_val"]
eval(strcat("rolling_out_sim_tab.('",kjji, "')(find(rolling_out_sim_tab.dummy_pix==0)) = reference_tab.('",kjji,"')(find(reference_tab.dummy_pix==0))")) 
end
 

%updating 4: share set-aside
rolling_out_sim_tab.share_land_set_aside(find(rolling_out_sim_tab.dummy_pix==0)) = 0 
rolling_out_sim_tab.share_labour_set_aside(find(rolling_out_sim_tab.dummy_pix==0)) = 0 
rolling_out_sim_tab.share_water_set_aside(find(rolling_out_sim_tab.dummy_pix==0)) = 0 

%updating 5: share RAS
rolling_out_sim_tab.share_land_RAS(find(rolling_out_sim_tab.dummy_pix==0)) = reference_tab.share_land_RAS(find(reference_tab.dummy_pix==0)) 
rolling_out_sim_tab.share_labour_RAS(find(rolling_out_sim_tab.dummy_pix==0)) = reference_tab.share_labour_RAS(find(reference_tab.dummy_pix==0)) 
rolling_out_sim_tab.share_water_RAS(find(rolling_out_sim_tab.dummy_pix==0)) = reference_tab.share_water_RAS(find(reference_tab.dummy_pix==0)) 

%updating 6: kcal
%OBS: kcal sim not calculated in ref file
rolling_out_sim_tab.kcal_sim = repelem(NaN,height(rolling_out_sim_tab))'

%updating 7: RAS units & d_unit_unfeasible & area_RAS
rolling_out_sim_tab.best_RAS_units(find(rolling_out_sim_tab.dummy_pix==0)) = reference_tab.best_RAS_units(find(reference_tab.dummy_pix==0)) 
rolling_out_sim_tab.d_one_unit_unfeasible(find(rolling_out_sim_tab.dummy_pix==0)) = reference_tab.d_none_or_one_unit_unfeasible(find(reference_tab.dummy_pix==0)) 
rolling_out_sim_tab.area_RAS(find(rolling_out_sim_tab.dummy_pix==0)) = reference_tab.area_RAS(find(reference_tab.dummy_pix==0)) 

%updating 8: wood subsidy
rolling_out_sim_tab.sub_aside(find(rolling_out_sim_tab.dummy_pix==0)) = 0

%removing dummy_pix
dummpixpos = find(contains(string(rolling_out_sim_tab.Properties.VariableNames),"dummy_pix"))
rolling_out_sim_tab = rolling_out_sim_tab(:,[1:(dummpixpos-1),(dummpixpos+1):width(rolling_out_sim_tab)])

%save updated file
rolling_out_sim_RAS_update = table2array(rolling_out_sim_tab)
clearvars -except rolling_out_sim_RAS_update listofsimsup kjjj sim_name output_directory midfile postsim_out ref_midfile timing r_inp_output_directory_1 timing_here r_inp_input_directory_1
load(strcat(output_directory,midfile))
        output_directory = r_inp_output_directory_1

rolling_out_sim_RAS = rolling_out_sim_RAS_update

        end


        if (type_sim == "RAS_aside_nocalconst_sub_fix_unit" | type_sim == "RAS_aside_nocalconst_sub_fix_unit_two_wq")

%joining dummy_pix to ref and sim DS
        rolling_out_sim_tab = join(priopixtab,rolling_out_sim_tab,"Keys","i");
%RAS sim ref
%                    switch ras_sub
%                        case 0.5
%%                            load("D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Data\sim_PMP_EE_AFRASTECHV_wageREP\workspace_newpols2025_newpol25_RASsubfix_half_(meat_20p0616)__2025_02_20_13_56_53_07_02_25")
%                            load("D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Data\sim_PMP_EE_woodquad_2grants\workspace_wageREP_newpol25_RASsubfix_half_wq_(meat_20p1158)__2025_06_17_02_35_39_16_06_25")
%                        case 1
%%                            load("D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Data\sim_PMP_EE_AFRASTECHV_wageREP\workspace_newpols2025_newpol25_RASsubfix_one_(meat_19p8769)__2025_02_08_11_42_28_07_02_25")
%                            load("D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Data\sim_PMP_EE_woodquad_2grants\workspace_wageREP_newpol25_RASsubfix_one_wq_(meat_19p9141)__2025_06_17_14_27_29_16_06_25")
%                        case 1.5
%%                            load("D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Data\sim_PMP_EE_AFRASTECHV_wageREP\workspace_newpols2025_newpol25_RASsubfix_two_(meat_19p2228)__2025_03_04_02_58_35_28_02_25")
%%                            load("D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Data\sim_PMP_EE_woodquad_2grants\workspace_wageREP_newpol25_RASsubfix_onehalf_wq_(meat_19p9096)__2025_07_11_13_57_10_11_07_25")
%                             load("D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Data\sim_PMP_EE_woodquad_2grants\workspace_wageREP_newpol25_RASsubfix_onehalf_wq_(meat_19.6119)__2025_07_17_02_38_08_16_07_25")
%
%                        case 2
%%                            load("D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Data\sim_PMP_EE_AFRASTECHV_wageREP\workspace_newpols2025_newpol25_RASsubfix_two_(meat_19p2228)__2025_03_04_02_58_35_28_02_25")
%%                            load("D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Data\sim_PMP_EE_woodquad_2grants\workspace_wageREP_newpol25_RASsubfix_two_wq_(meat_19p2657)__2025_06_17_06_45_21p16455_16_06_25")
%                             load("D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\Data\sim_PMP_EE_woodquad_2grants\workspace_wageREP_newpol25_RASsubfix_two_wq_(meat_19.2657)__2025_07_17_00_57_58_16_07_25")
%
%                    end
        load(strcat(output_directory,ref_midfile))
        output_directory = r_inp_output_directory_1

        rolling_out_sim_tab_ref = array2table(rolling_out_sim_RAS)
        rolling_out_sim_tab_ref.Properties.VariableNames = ["i" "best_RAS_units" [crops(1:3)' "fodder" crops(5:12)'] forages' trees' animals' "GM_gain_RAS_net" "GM_agr_change" "GM_RAS" "fval_sim" "obj_fun_sim_val" "share_land_RAS" "share_labour_RAS" "share_water_RAS" "area_RAS" "d_none_or_one_unit_unfeasible"]


        reference_tab = join(priopixtab,rolling_out_sim_tab_ref,"Keys","i");

        %making sure rows are the same in ref and sim
        rownorm = array2table(rolling_out_sim_tab.i)
        rownorm.Properties.VariableNames = ["i"]
        reference_tab = join(rownorm,reference_tab,"Keys","i")
        %sorting both on i to make sure equal rows = equal pixels
        rolling_out_sim_tab = sortrows(rolling_out_sim_tab,"i");
        reference_tab = sortrows(reference_tab,"i");

rolling_out_sim_tab.Properties.VariableNames
reference_tab.Properties.VariableNames

%rolling_out_sim_tab1 = rolling_out_sim_tab
%updating 1: LUs (Obs: ('') because of fields with spaces)
for kji = ["Barley", "Beans", "Field vegetables", "fodder", "Oats", "OSR", "Other cereals (triticale)", "Peas", "Potatoes", "Sugar beet", "Top and soft fruit", "Wheat", "Forage: grassland over five / permanent grassland" , "Forage: grassland under five / temporary grassland", "Rough grazing", "Animal: Beef cattle", "Animal: Dairy cow", "Animal: Sheep", "Broadleaved", "Conifer"]
eval(strcat("rolling_out_sim_tab.('",kji, "')(find(rolling_out_sim_tab.dummy_pix==0)) = reference_tab.('",kji,"')(find(reference_tab.dummy_pix==0))")) 
end

%updating 3: GM-related: only best_option_value
for kjji = ["GM_gain_RAS_net", "GM_agr_change", "GM_RAS", "fval_sim", "obj_fun_sim_val"]
eval(strcat("rolling_out_sim_tab.('",kjji, "')(find(rolling_out_sim_tab.dummy_pix==0)) = reference_tab.('",kjji,"')(find(reference_tab.dummy_pix==0))")) 
end
 

%updating 4: share set-aside
rolling_out_sim_tab.share_land_set_aside(find(rolling_out_sim_tab.dummy_pix==0)) = 0 
rolling_out_sim_tab.share_labour_set_aside(find(rolling_out_sim_tab.dummy_pix==0)) = 0 
rolling_out_sim_tab.share_water_set_aside(find(rolling_out_sim_tab.dummy_pix==0)) = 0 

%updating 5: share RAS
rolling_out_sim_tab.share_land_RAS(find(rolling_out_sim_tab.dummy_pix==0)) = reference_tab.share_land_RAS(find(reference_tab.dummy_pix==0)) 
rolling_out_sim_tab.share_labour_RAS(find(rolling_out_sim_tab.dummy_pix==0)) = reference_tab.share_labour_RAS(find(reference_tab.dummy_pix==0)) 
rolling_out_sim_tab.share_water_RAS(find(rolling_out_sim_tab.dummy_pix==0)) = reference_tab.share_water_RAS(find(reference_tab.dummy_pix==0)) 

%updating 6: kcal
%OBS: kcal sim not calculated in ref file
rolling_out_sim_tab.kcal_sim = repelem(NaN,height(rolling_out_sim_tab))'

%updating 7: RAS units & d_unit_unfeasible & area_RAS
rolling_out_sim_tab.best_RAS_units(find(rolling_out_sim_tab.dummy_pix==0)) = reference_tab.best_RAS_units(find(reference_tab.dummy_pix==0)) 
rolling_out_sim_tab.d_one_unit_unfeasible(find(rolling_out_sim_tab.dummy_pix==0)) = reference_tab.d_none_or_one_unit_unfeasible(find(reference_tab.dummy_pix==0)) 
rolling_out_sim_tab.area_RAS(find(rolling_out_sim_tab.dummy_pix==0)) = reference_tab.area_RAS(find(reference_tab.dummy_pix==0)) 

%updating 8: wood subsidy
rolling_out_sim_tab.sub_aside(find(rolling_out_sim_tab.dummy_pix==0)) = 0


%removing dummy_pix
dummpixpos = find(contains(string(rolling_out_sim_tab.Properties.VariableNames),"dummy_pix"))
rolling_out_sim_tab = rolling_out_sim_tab(:,[1:(dummpixpos-1),(dummpixpos+1):width(rolling_out_sim_tab)])

%save updated file
rolling_out_sim_RAS_update = table2array(rolling_out_sim_tab)
clearvars -except rolling_out_sim_RAS_update listofsimsup kjjj sim_name output_directory midfile postsim_out ref_midfile timing r_inp_output_directory_1 timing_here r_inp_input_directory_1
load(strcat(output_directory,midfile))
        output_directory = r_inp_output_directory_1

rolling_out_sim_RAS = rolling_out_sim_RAS_update

     end

%%Avoiding to record simulation-specific vars
timing = timing_here
save(strcat(output_directory,"ws_post_",extractBefore(type_sim,4),"_ras_sub_",string(ras_sub),"_",timing,".mat"))

