
%%%%WARNING
% Very important to use only this module to centralize basic data for calibration module and pre-simulation modules, 
% That way, all changes in basic data are made here, thus feeding both
% modules, what avoid the issue of different data in one of them.




%%%%%%%%%%%%%%WITH LIVESTOCK COEFFS REVISED%%%%%%%%%%%%%%WITH LIVESTOCK COEFFS REVISED
%%%%%%%%%%%%%%WITH LIVESTOCK COEFFS REVISED%%%%%%%%%%%%%%WITH LIVESTOCK COEFFS REVISED
%%%%%%%%%%%%%%WITH LIVESTOCK COEFFS REVISED%%%%%%%%%%%%%%WITH LIVESTOCK COEFFS REVISED
%%%09/10; 12/10, this is the LU version

%%%%%%%%%%%%%%03/10 PMP a la Judez et al., 2018 -- GM FIXED AT COUNTRY
%%%%%%%%%%%%%%LEVEL
%clear
%data
cd(input_directory)
tab_coeffs = externalfile_coeffs

%%%Only one order
%Crops: Barley Beans FieldVegetables fodder_crops Oats OSR OtherCereals_triticale_ Peas Potatoes SugarBeet TopAndSoftFruit Wheat
%Forage: Forage_GrasslandOverFive_PermanentGrassland Forage_GrasslandUnderFive_TemporaryGrassland RoughGrazing
%Animal: Animal_BeefCattle Animal_DairyCow Animal_Sheep
%OK, tab_coeffs follows it

%RET
vec_GM_crop = tab_coeffs.final_value(find(tab_coeffs.parameter=="GM" & tab_coeffs.group=="crop"))
%Order ok
vec_GM_animal = tab_coeffs.final_value(find(tab_coeffs.parameter=="GM with forage cost" & tab_coeffs.group=="animal"))
%Order ok (recheck 12/10 16h08)
%vec_GM_RAS = tab_coeffs.final_value(find(tab_coeffs.parameter=="GM" & tab_coeffs.group=="RAS" & tab_coeffs.type=="RAS" ))
%28/03
%vec_GM_RAS_ex_lab = tab_coeffs.final_value(find(tab_coeffs.parameter=="GM" & tab_coeffs.group=="RAS" & tab_coeffs.type=="RAS_ex_lab_cost"))
%
vec_REV_crop = tab_coeffs.final_value(find(tab_coeffs.parameter=="Revenue" & tab_coeffs.group=="crop"))
%Order ok
vec_REV_animal = tab_coeffs.final_value(find(tab_coeffs.parameter=="Revenue" & tab_coeffs.group=="animal"))
%Order ok
%vec_REV_RAS = tab_coeffs.final_value(find(tab_coeffs.parameter=="Revenue" & tab_coeffs.group=="RAS"))
%
vec_VARCOS_crop = tab_coeffs.final_value(find(tab_coeffs.parameter=="Variable cost" & tab_coeffs.group=="crop"))
%Order ok
vec_VARCOS_animal = tab_coeffs.final_value(find(tab_coeffs.parameter=="Variable cost" & tab_coeffs.group=="animal"))
%Order ok
vec_COS_forage = tab_coeffs.final_value(find(tab_coeffs.parameter=="Forage cost"))
%Order ok
vec_COS_forage_animal_POV = tab_coeffs.final_value(find(tab_coeffs.parameter=="Forage cost, animal POV"))
%Order ok
vec_VARCOS_RAS = tab_coeffs.final_value(find(tab_coeffs.parameter=="Variable cost" & tab_coeffs.group=="RAS" & tab_coeffs.type=="RAS"))
%
%28/03
vec_VARCOS_RAS_oplab = tab_coeffs.final_value(find(tab_coeffs.parameter=="Variable cost" & tab_coeffs.group=="RAS" & tab_coeffs.type=="RAS_oplab"))
%
vec_VARCOS_RAS_mglab = tab_coeffs.final_value(find(tab_coeffs.parameter=="Variable cost"  & tab_coeffs.group=="RAS" & tab_coeffs.type=="RAS_mglab"))
%
vec_SLR_crop = tab_coeffs.final_value(find(tab_coeffs.parameter=="SLR" & tab_coeffs.group=="crop"))
%Order ok
vec_SLR_animal = tab_coeffs.final_value(find(tab_coeffs.parameter=="SLR" & tab_coeffs.group=="animal"))
%Order ok
vec_SLR_forage = tab_coeffs.final_value(find(tab_coeffs.parameter=="SLR" & tab_coeffs.group=="forage"))
%Order ok
vec_SLR_RAS = tab_coeffs.final_value(find(tab_coeffs.parameter=="SLR" & tab_coeffs.group=="RAS"))
 

%Order ok
vec_for_yield = tab_coeffs.final_value(find(tab_coeffs.parameter=="Forage yield"))
%Order ok
vec_COS_rear = tab_coeffs.final_value(find(tab_coeffs.parameter=="Animal rearing cost" & tab_coeffs.group=="animal"))
%Order ok 12/10
vec_GM_nofor_animal = tab_coeffs.final_value(find(tab_coeffs.parameter=="GM without forage cost" & tab_coeffs.group=="animal"))
vec_GM_nofor_animal
vec_REV_animal - vec_COS_rear
%GM no for = REV - rear cost, so use GM nofor
%vec_outadj_animal = tab_coeffs.final_value(find(tab_coeffs.parameter=="Output adjustment" & tab_coeffs.group=="animal"))
%09/04/24
vec_outadj_animal = tab_coeffs.final_value(find(tab_coeffs.parameter=="Revenue error correction" & tab_coeffs.group=="animal"))
%17/04/24: this is the full correction factor (includes price*yield <>
%revenue repair)
vec_outadj_crop = tab_coeffs.final_value(find(tab_coeffs.parameter=="Revenue error correction" & tab_coeffs.group=="crop"))
%18/04/24: this is the partial correction factor (only for GM - the REV -
%AVC part)
vec_outadj_crop_part = tab_coeffs.final_value(find(tab_coeffs.parameter=="GM error correction" & tab_coeffs.group=="crop"))
%check 
vec_REV_crop = vec_REV_crop + vec_outadj_crop_part
vec_GM_crop - (vec_REV_crop - vec_VARCOS_crop) 
%Ok, only two errors at -12 OM
vec_REV_crop
%%18/04/24, error corr for forage (as in LP vec_GM_animal used and in quad
%%vec_GM_nofor_animal used)
vec_GM_animal_forage_cost_error_corr = vec_GM_animal - (vec_GM_nofor_animal - vec_COS_forage_animal_POV)
vec_GM_animal - (vec_GM_nofor_animal - vec_COS_forage_animal_POV + vec_GM_animal_forage_cost_error_corr)
%all zero, ok
vec_GM_nofor_animal = vec_GM_nofor_animal + vec_GM_animal_forage_cost_error_corr
%check
vec_GM_animal - (vec_GM_nofor_animal - vec_COS_forage_animal_POV)
%all zero, ok

%%%vec_GM_RAS without energy cost, 10/05/24
%GM_RAS_ex_energy = tab_coeffs.final_value(find(tab_coeffs.parameter=="GM" & tab_coeffs.type=="RAS_ex_energy_cost"))
%GM_RAS_ex_energy_ex_labour = tab_coeffs.final_value(find(tab_coeffs.parameter=="GM" & tab_coeffs.type=="RAS_ex_lab_ex_energy_cost"))

%vec_price_RAS = tab_coeffs.final_value(find(tab_coeffs.parameter=="Price" & tab_coeffs.group=="RAS"))
%vec_yield_RAS = tab_coeffs.final_value(find(tab_coeffs.parameter=="Yield" & tab_coeffs.group=="RAS"))
%vec_varcost_RAS = tab_coeffs.final_value(find(tab_coeffs.parameter=="Variable cost" & tab_coeffs.group=="RAS"))
vec_size_RAS = 10*30*10^-4


%%%%Financial RAS from ML 24/09/24%%%%Financial RAS from ML 24/09/24%%%%Financial RAS from ML 24/09/24%%%%Financial RAS from ML 24/09/24
%%%%Financial RAS from ML 24/09/24%%%%Financial RAS from ML 24/09/24%%%%Financial RAS from ML 24/09/24%%%%Financial RAS from ML 24/09/24
%price_meat = 23
%price_chitin = 12
price_chitin = 12*(1+cs_chitin)
RAS_yield_meat = 6624
RAS_yield_chitin = 0.015*0.5*RAS_yield_meat
cost_adj_extra_sensitivity = 26496 - 26496*(1+cs_PLJ) + (794.88 + 26231.04) - (794.88 + 26231.04)*(1+cs_feed) + 20581.34 - 20581.34*(1+cs_salt)

%OBS: to match excel engineering sheet replace 1/vec_size_RAS by 33
%(1/vec_size_RAS = 33.333); but am here also using round because the number of
%units is an integer.
vec_GM_RAS = round(1/vec_size_RAS)*(price_meat*RAS_yield_meat + price_chitin*RAS_yield_chitin -   155549.9129 + cost_adj_extra_sensitivity)
vec_GM_RAS_ex_lab = round(1/vec_size_RAS)*(price_meat*RAS_yield_meat + price_chitin*RAS_yield_chitin -  104168.22 + cost_adj_extra_sensitivity)
GM_RAS_ex_energy = (price_meat*RAS_yield_meat + price_chitin*RAS_yield_chitin - 145369.35 + cost_adj_extra_sensitivity)
GM_RAS_ex_energy_ex_labour = (price_meat*RAS_yield_meat + price_chitin*RAS_yield_chitin -  93987.66 + cost_adj_extra_sensitivity)
vec_REV_RAS = round(1/vec_size_RAS)*(price_meat*RAS_yield_meat + price_chitin*RAS_yield_chitin)
vec_price_RAS = round(1/vec_size_RAS)*(price_meat*RAS_yield_meat + price_chitin*RAS_yield_chitin)/(RAS_yield_meat+RAS_yield_chitin)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%21/03/24, water
vec_water_crop = tab_coeffs.final_value(find(tab_coeffs.parameter=="Water" & tab_coeffs.group=="crop"))
vec_water_animal = tab_coeffs.final_value(find(tab_coeffs.parameter=="Water" & tab_coeffs.group=="animal"))
vec_water_RAS = tab_coeffs.final_value(find(tab_coeffs.parameter=="Water" & tab_coeffs.group=="RAS"))


%%Energy parameters (28/11)
%tab_param_ene = readtable("Parameters_energy_AD_28_11_23.txt")
%tab_param_ene = readtable("Parameters_energy_AD_01_12_23.txt")
%tab_param_ene = readtable("Parameters_energy_AD_RAS_06_12_23.txt")
%tab_param_ene = readtable("Parameters_energy_AD_RAS_11_12_23.txt")
%tab_param_ene = readtable("Parameters_energy_AD_RAS_11_03_24.txt")
%tab_param_ene = readtable("Parameters_energy_AD_RAS_21_03_24.txt")
%tab_param_ene = readtable("Parameters_energy_AD_RAS_10_04_24.txt")
tab_param_ene = readtable("Parameters_energy_AD_RAS_29_10_24.txt")

elec_retail_price = tab_param_ene.value(find(tab_param_ene.type=="Retail electricity price, paid by the non-HH consumer"))
elec_wholesale_price = tab_param_ene.value(find(tab_param_ene.type=="Wholesale electricity price, received by the producer"))
RAS_elec_consumption = tab_param_ene.value(find(tab_param_ene.type=="Electricity consumption per unit"))
AD_OPEX = tab_param_ene.value(find(tab_param_ene.type=="total AD OPEX"))
AD_CAPEX = tab_param_ene.value(find(tab_param_ene.type=="AD CAPEX"))
AD_lifetime = tab_param_ene.value(find(tab_param_ene.type=="AD lifetime"))
AD_output_elec = tab_param_ene.value(find(tab_param_ene.type=="AD electricity output"))
AD_size = tab_param_ene.value(find(tab_param_ene.type=="Area occupied"))
AD_SLR = tab_param_ene.value(find(tab_param_ene.type=="SLR"))
AD_SEG_tariff = tab_param_ene.value(find(tab_param_ene.type=="Smart export guarantee tariff"))
RAS_lifetime = tab_param_ene.value(find(tab_param_ene.type=="RAS lifetime"))
RAS_CAPEX = tab_param_ene.value(find(tab_param_ene.type=="RAS CAPEX"))
waste_heat_cost = tab_param_ene.value(find(tab_param_ene.type=="Waste heat energy cost"))
AD_water = tab_param_ene.value(find(tab_param_ene.type=="Water consumption AD"))


%woodland and calories parameters (09/01)
vec_kcal_crop = tab_coeffs.final_value(find(tab_coeffs.parameter=="Calories" & tab_coeffs.group=="crop"))
vec_kcal_animal = tab_coeffs.final_value(find(tab_coeffs.parameter=="Calories" & tab_coeffs.group=="animal"))
vec_kcal_RAS = tab_coeffs.final_value(find(tab_coeffs.parameter=="Calories" & tab_coeffs.group=="RAS"))
sub_set_aside = tab_coeffs.final_value(find(tab_coeffs.parameter=="GM" & tab_coeffs.group=="tree"))
%SLR_set_aside = tab_coeffs.final_value(find(tab_coeffs.parameter=="SLR" & tab_coeffs.group=="tree"))

vec_rev_forestry_Bro = tab_coeffs.final_value(find(tab_coeffs.parameter=="Revenue" & tab_coeffs.group=="tree, broadleaved"))
vec_rev_forestry_Con = tab_coeffs.final_value(find(tab_coeffs.parameter=="Revenue" & tab_coeffs.group=="tree, conifer"))

%max(woodland_financial_tab.Bro_rev)
%max(woodland_financial_tab.Con_rev)

mat_SLR_tree = tab_coeffs.final_value(find(tab_coeffs.parameter=="SLR" & tab_coeffs.group=="tree"))
mat_water_tree = tab_coeffs.final_value(find(tab_coeffs.parameter=="Water" & tab_coeffs.group=="tree"))



%AD map
%mat_AD = readtable("AD_GB_to_ML_28_11.txt")
%mat_AD = readtable("AD_GB_to_ML_01_12.txt")
%cd 'G:\LEEP\Sustainable_Prawn\Data\'
mat_AD = readtable("AD_GB_to_ML_11_12.txt")

%%simulation 20/10
vec_price_crop = tab_coeffs.final_value(find(tab_coeffs.parameter=="Price" & tab_coeffs.group=="crop"))
vec_yield_crop = tab_coeffs.final_value(find(tab_coeffs.parameter=="Yield" & tab_coeffs.group=="crop"))
vec_varcost_crop = tab_coeffs.final_value(find(tab_coeffs.parameter=="Variable cost" & tab_coeffs.group=="crop"))

vec_check_cost = [vec_REV_crop - vec_varcost_crop vec_GM_crop ((vec_REV_crop - vec_varcost_crop) - vec_GM_crop)]
% sugarbeet is Nix rounding error in unit (GM = 799, REV-COS = 800) but it results into error in exact reprod 
%must hand-correct
vec_REV_crop(10) = vec_REV_crop(10) - 1

vec_price_animal = tab_coeffs.final_value(find(tab_coeffs.parameter=="Price" & tab_coeffs.group=="animal"))
vec_yield_animal = tab_coeffs.final_value(find(tab_coeffs.parameter=="Yield" & tab_coeffs.group=="animal"))
vec_varcost_animal = tab_coeffs.final_value(find(tab_coeffs.parameter=="Variable cost" & tab_coeffs.group=="animal"))

vec_check_cost = [vec_REV_animal - vec_varcost_animal vec_GM_nofor_animal  ((vec_REV_animal - vec_varcost_animal) - vec_GM_nofor_animal)]
%ok, there's a Nix 0.1 error in beef, ignore

%Stocking from Census
%tab_stocking = readtable("stocking_coeffs_from_Census_11_10_23_formlab.txt","FileType","delimitedtext", "Delimiter", "#")
%tab_stocking = readtable("stocking_rates__pixel_level_from_Census_12_10_23_formlab.txt","FileType","delimitedtext", "Delimiter", "#")

%[RET]

%%%Census (N pix = 9092)

%cd 'G:\LEEP\Sustainable_Prawn\Data'
%mat_area_crop = readtable("census_mlab_area_crop_20_10.txt","FileType","delimitedtext", "Delimiter", "#")
%mat_area_crop = readtable("census_mlab_area_crop_21_11.txt","FileType","delimitedtext", "Delimiter", "#")
%mat_area_crop = readtable("census_mlab_area_crop_22_11.txt","FileType","delimitedtext", "Delimiter", "#")
%mat_area_crop = readtable("census_mlab_area_crop_30_11.txt","FileType","delimitedtext", "Delimiter", "#")
mat_area_crop = readtable("census_mlab_area_crop_11_12.txt","FileType","delimitedtext", "Delimiter", "#")

%Order ok
%mat_area_forage = readtable("census_mlab_area_forage_20_10.txt","FileType","delimitedtext", "Delimiter", "#")
%mat_area_forage = readtable("census_mlab_area_forage_21_11.txt","FileType","delimitedtext", "Delimiter", "#")
%mat_area_forage = readtable("census_mlab_area_forage_30_11.txt","FileType","delimitedtext", "Delimiter", "#")
mat_area_forage = readtable("census_mlab_area_forage_11_12.txt","FileType","delimitedtext", "Delimiter", "#")

%Order ok
%mat_head = readtable("census_mlab_head_20_10.txt","FileType","delimitedtext", "Delimiter", "#")
%mat_head = readtable("census_mlab_head_21_11.txt","FileType","delimitedtext", "Delimiter", "#")
%mat_head = readtable("census_mlab_head_30_11.txt","FileType","delimitedtext", "Delimiter", "#")
mat_head = readtable("census_mlab_head_11_12.txt","FileType","delimitedtext", "Delimiter", "#")

%Order ok
%mat_wood = readtable("census_mlab_woodland_22_11.txt","FileType","delimitedtext", "Delimiter", "#")
%mat_wood = readtable("census_mlab_woodland_30_11.txt","FileType","delimitedtext", "Delimiter", "#")
mat_wood = readtable("census_mlab_woodland_11_12.txt","FileType","delimitedtext", "Delimiter", "#")

%NFI woodland
%mat_tree = readtable("forest_inventory_mlab_trees_08_05_25.txt","FileType","delimitedtext", "Delimiter", "#")
mat_tree = readtable("forest_inventory_mlab_trees_09_05_25_12h23.txt","FileType","delimitedtext", "Delimiter", "#")

%mat_tree.brocon = mat_tree.broadleaved + mat_tree.conifer
%size(mat_tree)
%mat_tree = join(mat_tree,mat_wood,"Keys","key")
%size(mat_tree)
%height(find(mat_tree.brocon > mat_tree.x_woodland))/height(mat_tree)
%sum(mat_tree.brocon)/sum(mat_tree.x_woodland)
%FC bro and con > 2 larger than woodland from Census
%mat_tree.s_bro = mat_tree.broadleaved / mat_tree
%70.29%

%checking order
height(find(string(mat_tree.key) ~= string(mat_area_crop.key)))
height(find(string(mat_tree.key) ~= string(mat_area_forage.key)))
%Both ok

area_observed_crop = mat_area_crop(:,2:size(mat_area_crop,2))
area_observed_forage = mat_area_forage(:,2:size(mat_area_forage,2))
head_observed = mat_head(:,2:size(mat_head,2))
wood_observed = mat_wood(:,2:size(mat_wood,2))

area_observed_tree = mat_tree(:,2:size(mat_tree,2))

height(find(area_observed_tree.broadleaved > 0 | area_observed_tree.conifer > 0 |  area_observed_tree.other_woodland > 0))/height(area_observed_tree)
%share with woodland = 94%


area_observed_crop.Properties.VariableNames = extractAfter(area_observed_crop.Properties.VariableNames,5)
area_observed_forage.Properties.VariableNames = extractAfter(area_observed_forage.Properties.VariableNames,5)
head_observed.Properties.VariableNames = extractAfter(head_observed.Properties.VariableNames,5)

%%%29/07/24: repairing total agric areas > 2500
%%%09/05/25: updated to wood from NFI

checkcensus = array2table([table2array(area_observed_crop)*ones(12,1) table2array(area_observed_forage)*ones(3,1) table2array(area_observed_tree)*ones(3,1)])
checkcensus.Properties.VariableNames = ["acrop" "aforage" "awood"]
checkcensus.atot = checkcensus.acrop + checkcensus.aforage + checkcensus.awood
height(find(checkcensus.atot>2500))/height(checkcensus)
%14.49%, as seen earlier
%09/05/25: 18%, after incorporating NFI (~4% increase)
censuswrong = find(checkcensus.atot>2500)

%area_observed_crop_test = area_observed_crop
%for ikh = area_observed_crop.Properties.VariableNames
%    eval(strcat("area_observed_crop_test.",ikh,"(censuswrong,:) = area_observed_crop_test.",ikh,"(censuswrong,:)./checkcensus.atot(censuswrong)*2500"))
%end
%area_observed_crop_test2 = area_observed_crop_test(censuswrong,:)
%area_observed_crop2 = area_observed_crop(censuswrong,:)
%ok, reduced

for ikh = area_observed_crop.Properties.VariableNames
    eval(strcat("area_observed_crop.",ikh,"(censuswrong,:) = area_observed_crop.",ikh,"(censuswrong,:)./checkcensus.atot(censuswrong)*2500"))
end

%area_observed_forage_test = area_observed_forage
%for ikh = area_observed_forage.Properties.VariableNames
%    eval(strcat("area_observed_forage_test.",ikh,"(censuswrong,:) = area_observed_forage_test.",ikh,"(censuswrong,:)./checkcensus.atot(censuswrong)*2500"))
%end
%ok, reduced
%area_observed_forage_test2 = area_observed_forage_test(censuswrong,:)
%area_observed_forage2 = area_observed_forage(censuswrong,:)


for ikh = area_observed_forage.Properties.VariableNames
    eval(strcat("area_observed_forage.",ikh,"(censuswrong,:) = area_observed_forage.",ikh,"(censuswrong,:)./checkcensus.atot(censuswrong)*2500"))
end

for ikh = area_observed_tree.Properties.VariableNames
    eval(strcat("area_observed_tree.",ikh,"(censuswrong,:) = area_observed_tree.",ikh,"(censuswrong,:)./checkcensus.atot(censuswrong)*2500"))
end

checkcensus = array2table([table2array(area_observed_crop)*ones(12,1) table2array(area_observed_forage)*ones(3,1) table2array(area_observed_tree)*ones(3,1)])
checkcensus.Properties.VariableNames = ["acrop" "aforage" "awood"]
checkcensus.atot = checkcensus.acrop + checkcensus.aforage + checkcensus.awood
height(find(checkcensus.atot>2500))/height(checkcensus)
%3.23%
%09/05/25: 3.29%
height(find(checkcensus.atot>2500.001))/height(checkcensus)
%zero, so there is none above 2500, apart from negligible error
%09/05/25: zero
max(checkcensus.atot)
%censuswrong = find(checkcensus.atot>2500)

%Removing other_woodland
area_observed_tree = area_observed_tree(:,["broadleaved","conifer"])

%Eurostat - Average farm area, 26/03/24
av_farm_area = readtable("average_farm_area_Eurostat_2007_Censuses_26_03_24.txt")
mat_area_crop_t = [mat_area_crop(:,1) array2table(table2array(mat_area_crop(:,2:13))*ones(12,1))]
mat_area_forage_t = [mat_area_forage(:,1) array2table(table2array(mat_area_forage(:,2:4))*ones(3,1))]
av_farm_area = join(av_farm_area,mat_area_crop_t,"Keys","key")
av_farm_area.Properties.VariableNames(3) = "a_crop"
av_farm_area = join(av_farm_area,mat_area_forage_t,"Keys","key")
av_farm_area.Properties.VariableNames(4) = "a_forage"
av_farm_area = join(av_farm_area,mat_wood,"Keys","key")
av_farm_area.a_tot = (av_farm_area.a_crop+av_farm_area.a_forage+av_farm_area.x_woodland)
av_farm_area.n_farm = av_farm_area.a_tot./av_farm_area.afr_final

%[min(av_farm_area.n_farm) mean(av_farm_area.n_farm) median(av_farm_area.n_farm) max(av_farm_area.n_farm)]

%[min(av_farm_area.afr_final) mean(av_farm_area.afr_final) median(av_farm_area.afr_final) max(av_farm_area.afr_final)]

%min(av_farm_area.n_farm)
mean(av_farm_area.n_farm)
%mean = 273
median(av_farm_area.n_farm)
%median = 26
max(av_farm_area.n_farm)
%median = 26
%max = 2*10^6
height(find(av_farm_area.n_farm > 10^3))
%Only 10 pixels with more than 10^3, ignore.
height(find(av_farm_area.n_farm == 0))
%99 = 0
height(find(av_farm_area.a_tot == 0 & av_farm_area.n_farm == 0))/height(find(av_farm_area.n_farm == 0))
%All pixels with n_farm = 0 have a_tot = 0, so out of sim


%wage map
%mat_wage_PAYE = readtable("G:/LEEP/Sustainable_Prawn/Data/wage_PAYE_02_04_24.txt")
%mat_wage_PAYE = readtable("wage_PAYE_03_04_24.txt")
mat_wage_PAYE = readtable("wage_PAYE_06_02_25.txt")
%changed 06/02/25 (mean aggregation)

%I checked order below and it is ok
%mat_wage_PAYE_o = join(mat_wage_PAYE,mat_area_crop,"Keys","key")
%[mat_wage_PAYE_o.key mat_area_crop.key]

%RAS g* map (23/03/24)
RASmap = readtable("RAS_map_23_04_24.txt")
RASmap1 = array2table((1:height(area_observed_crop))')
RASmap1.Properties.VariableNames = "i"
height(RASmap)
RASmap = outerjoin(RASmap,RASmap1);
height(RASmap)
RASmap.units(find(isnan(RASmap.units)==1))=0
tabulate(RASmap.units)
%units of non-well-calib = 0

%sum_area_crop = table2array(area_observed_crop)' *ones(6350,1)
%sum_area_crop_s = sort(sum_area_crop)
%top_3_crops = find(sum_area_crop == sum_area_crop_s(12) | sum_area_crop == sum_area_crop_s(11) | sum_area_crop == sum_area_crop_s(10))
%name_crops(top_3_crops)
%Three top crops: Barley, OSR, Wheat


%sum_area_crop = table2array(area_observed_crop)' *ones(6350,1)
%sum_area_crop_s = sort(sum_area_crop)
%top_3_crops = find(sum_area_crop == sum_area_crop_s(12) | sum_area_crop == sum_area_crop_s(11) | sum_area_crop == sum_area_crop_s(10))
%name_crops(top_3_crops)
%Three top crops: Barley, OSR, Wheat

%Check order of pixel id the same in all Census files
%comp 1 forage vs crop
%rolll = 0
%rollcol = []
%for i = 1:height(area_observed_crop)
%    if string(mat_area_forage.key(i)) ~= string(mat_area_crop.key(i))
%       rolll = 1;
%    end 
%rollcol = [rollcol; rolll];
%end
%sum(rollcol)
%all zero

%comp 2 head vs crop
%rolll = 0
%rollcol = []
%for i = 1:height(area_observed_crop)
%    if string(mat_head.key(i)) ~= string(mat_area_crop.key(i))
%       rolll = 1;
%    end 
%rollcol = [rollcol; rolll];
%end
%sum(rollcol)
%all zero

%comp 3 wood vs crop
%rolll = 0
%rollcol = []
%for i = 1:height(area_observed_crop)
%    if string(mat_wood.key(i)) ~= string(mat_area_crop.key(i))
%       rolll = 1;
%    end 
%rollcol = [rollcol; rolll];
%end
%sum(rollcol)
%all zero

%wage vs crop
%rolll = 0
%rollcol = []
%for i = 1:height(area_observed_crop)
%    if string(mat_area_crop.key(i)) ~= string(mat_wage_PAYE.key(i))
%       rolll = 1;%
%    end 
%rollcol = [rollcol; rolll];
%end
%sum(rollcol)
%all zero

%shock
shock = 0.1
vec_price_crop_sim = vec_price_crop

name_crops = tab_coeffs.type(find(tab_coeffs.group=="crop" & tab_coeffs.parameter=="Revenue"))
num_crops = length(name_crops)

name_animals = tab_coeffs.type(find(tab_coeffs.group=="animal" & tab_coeffs.parameter=="Revenue"))
num_animals = length(name_animals)

%crops
for i = 1:num_crops
    
    %   vec_price_crop_sim_plus(i) = vec_price_crop(i)*(1+shock)
    eval(strcat('vec_REV_crop_sim_plus_',strrep(strrep(strrep(strrep(name_crops(i)," ", "_"),"-","_"),")",""),"(",""),' = vec_REV_crop'))
    eval(strcat('vec_REV_crop_sim_plus_',strrep(strrep(strrep(strrep(name_crops(i)," ", "_"),"-","_"),")",""),"(",""),'(i) = vec_price_crop(i)*(1+shock)*vec_yield_crop(i) + vec_outadj_crop(i)'))   

%    vec_price_crop_sim_minus(i) = vec_price_crop(i)*(1-shock)
    eval(strcat('vec_REV_crop_sim_minus_',strrep(strrep(strrep(strrep(name_crops(i)," ", "_"),"-","_"),")",""),"(",""),' = vec_REV_crop'))
    eval(strcat('vec_REV_crop_sim_minus_',strrep(strrep(strrep(strrep(name_crops(i)," ", "_"),"-","_"),")",""),"(",""),'(i) = vec_price_crop(i)*(1-shock)*vec_yield_crop(i)+ vec_outadj_crop(i)'))   
end

for i = 1:num_animals
%    vec_price_animal_sim_plus(i) = vec_price_animal(i)*(1+shock)
    eval(strcat('vec_GM_nofor_animal_sim_plus_',strrep(strrep(name_animals(i)," ", "_"),":",""),' = vec_GM_nofor_animal'))
    eval(strcat('vec_GM_nofor_animal_sim_plus_',strrep(strrep(name_animals(i)," ", "_"),":",""),'(i) = vec_price_animal(i)*(1+shock)*vec_yield_animal(i) + vec_outadj_animal(i) - vec_varcost_animal(i)'))   

%    vec_price_animal_sim_minus(i) = vec_price_animal(i)*(1-shock)
    eval(strcat('vec_GM_nofor_animal_sim_minus_',strrep(strrep(name_animals(i)," ", "_"),":",""),' = vec_GM_nofor_animal'))
    eval(strcat('vec_GM_nofor_animal_sim_minus_',strrep(strrep(name_animals(i)," ", "_"),":",""),'(i) = vec_price_animal(i)*(1-shock)*vec_yield_animal(i) + vec_outadj_animal(i) - vec_varcost_animal(i)'))   
end

simlist = [[[strrep(strrep(strrep(strrep(name_crops," ", "_"),"-","_"),")",""),"(","") repelem("crop",12)'; strrep(strrep(name_animals, " ", "_"),":","") repelem("animal",3)'] repelem("plus",15)']; [[strrep(strrep(strrep(strrep(name_crops," ", "_"),"-","_"),")",""),"(","") repelem("crop",12)'; strrep(strrep(name_animals, " ", "_"),":","") repelem("animal",3)'] repelem("minus",15)']]
simlist = [(1:length(simlist))' simlist]
simlist = array2table(simlist)
simlist.Properties.VariableNames = ["id" "activity" "type" "sign"]
simlist.name = strcat(simlist.sign, "_" , simlist.activity)
height(simlist)

%Redux: 3 top crops + Dairy
simlist = simlist(find(simlist.activity=="Animal_Dairy_cow" |(simlist.type=="crop" & (simlist.activity=="Barley" | simlist.activity=="Wheat" | simlist.activity=="OSR"))),:)

%gen all store objs
for i=1:height(simlist)
    eval(strcat("rolling_out_sim_",simlist.name(i), "= []"))
end

%2-5: dairy, 6-9: beef; 10-13: sheep
mat_GM_forage = []
mat_SLR_forage = []
mat_rear_forage = []

%%%(2) Cattle-pasture allocation algorithm
%cd 'G:\LEEP\Sustainable_Prawn'
%tic
%cattle_pasture_allocation_23_11_23
%cattle_pasture_allocation_04_12_23
%cattle_pasture_allocation_05_12_23_10h12
%cattle_pasture_allocation_06_12_23
%cattle_pasture_allocation_07_12_23
%cattle_pasture_allocation_12_12_23
%toc

%cd 'G:\LEEP\Sustainable_Prawn\Data'
%stocking_allocated = readtable("stocking_checking_new_alg_19_10_allpix_17h54.txt","FileType","delimitedtext", "Delimiter", ",")
%stocking_allocated = readtable("stocking_checking_new_alg_20_10_allpix.txt","FileType","delimitedtext", "Delimiter", ",")
%stocking_allocated = readtable("stocking_checking_new_alg_with_Sco_23_11_allpix.txt","FileType","delimitedtext", "Delimiter", ",")
%stocking_allocated = readtable("stocking_checking_new_alg_with_Sco_whole_Census_01_12_allpix.txt","FileType","delimitedtext", "Delimiter", ",")
%stocking_allocated = readtable('stocking_checking_new_alg_with_Sco_whole_Census_04_12_allpix.txt',"FileType","delimitedtext", "Delimiter", ",");
%stocking_allocated = readtable('stocking_checking_new_alg_with_Sco_whole_Census_05_12_allpix_after_revision.txt',"FileType","delimitedtext", "Delimiter", ",");
%stocking_allocated = readtable('stocking_checking_new_alg_with_Sco_whole_Census_06_12_allpix_after_revision.txt',"FileType","delimitedtext", "Delimiter", ",");
%stocking_allocated = readtable('stocking_checking_new_alg_with_Sco_whole_Census_07_12_allpix_after_revision.txt',"FileType","delimitedtext", "Delimiter", ",");
%stocking_allocated = readtable('stocking_checking_new_alg_with_Sco_whole_Census_11_12_allpix_after_revision.txt',"FileType","delimitedtext", "Delimiter", ",");
%OBS: corrected the stocking rate in 02/08/2024, 11:11 AM
%stocking_allocated = readtable('stocking_checking_new_alg_with_Sco_whole_Census_29_07_24_allpix_after_revision.txt',"FileType","delimitedtext", "Delimiter", ",");
%stocking_allocated = readtable('stocking_checking_new_alg_with_Sco_whole_Census_15_05_25_woodquad_allpix_after_revision.txt',"FileType","delimitedtext", "Delimiter", ",");
stocking_allocated = readtable('stocking_checking_new_alg_with_Sco_whole_Census_16_06_25_woodquad_allpix_after_revision.txt',"FileType","delimitedtext", "Delimiter", ",");

%check < 1 animal type has all respective animal types zeroed
[max(stocking_allocated.stocking_dairy_temp(find(head_observed.Animal_DairyCow < 1))) max(stocking_allocated.stocking_dairy_perm(find(head_observed.Animal_DairyCow < 1))) max(stocking_allocated.stocking_dairy_rough(find(head_observed.Animal_DairyCow < 1))) max(stocking_allocated.herd_dairy(find(head_observed.Animal_DairyCow < 1))) max(stocking_allocated.ig_herd_dairy(find(head_observed.Animal_DairyCow < 1)))]
[max(stocking_allocated.stocking_beef_temp(find(head_observed.Animal_BeefCattle < 1))) max(stocking_allocated.stocking_beef_perm(find(head_observed.Animal_BeefCattle < 1))) max(stocking_allocated.stocking_beef_rough(find(head_observed.Animal_BeefCattle < 1))) max(stocking_allocated.herd_beef(find(head_observed.Animal_BeefCattle < 1))) max(stocking_allocated.ig_herd_beef(find(head_observed.Animal_BeefCattle < 1)))]
[max(stocking_allocated.stocking_sheep_temp(find(head_observed.Animal_Sheep < 1))) max(stocking_allocated.stocking_sheep_perm(find(head_observed.Animal_Sheep < 1))) max(stocking_allocated.stocking_sheep_rough(find(head_observed.Animal_Sheep < 1))) max(stocking_allocated.herd_sheep(find(head_observed.Animal_Sheep < 1))) max(stocking_allocated.ig_herd_sheep(find(head_observed.Animal_Sheep < 1)))]
%OK


%%%%Weigthed sum loop
%now in the right order of excel vec_SLR_forage
%Forage: fodder_crops_root_crops_forage_crops_and_all_other_crops_for_st Forage_GrasslandOverFive_PermanentGrassland Forage_GrasslandUnderFive_TemporaryGrassland RoughGrazing
%forage: perm-temp-rough
%animal seq in GM vec: Beef-dairy-sheep
%perm[,beef-dairy-sheep] temp[,beef-dairy-sheep] rough[,beef-dairy-sheep]
%tab_stocking_for = [tab_stocking(:,[9,5,13])  tab_stocking(:,[7,3,11]) tab_stocking(:,[6,2,10]) tab_stocking(:,[8,4,12]) ]
tab_stocking_for = [stocking_allocated(:,[6,3,9]) stocking_allocated(:,[5,2,8]) stocking_allocated(:,[7,4,10]) ]

%kron
kron_GM_animal = kron(diag(repelem(1,3)),vec_GM_animal)
kron_GM_nofor_animal = kron(diag(repelem(1,3)),vec_GM_nofor_animal)

%size(kron_GM_animal)
kron_SLR_animal = kron(diag(repelem(1,3)),vec_SLR_animal)
kron_COS_rear = kron(diag(repelem(1,3)),vec_COS_rear)
kron_kcal_animal = kron(diag(repelem(1,3)),vec_kcal_animal)
kron_water_animal = kron(diag(repelem(1,3)),vec_water_animal)

%OBS: must replace miss for zero in tab_stocking, otherwise pixels with at
%least ONE stocking zero will have ALL weighted sums miss
tab_stocking_for_zero = table2array(tab_stocking_for)
tab_stocking_for_zero(isnan(tab_stocking_for_zero)==1)=0

%old (miss wrong)
%mat_GM_forage_m = table2array(tab_stocking_for) * kron_GM_animal
%mat_SLR_forage_m = table2array(tab_stocking_for) * kron_SLR_animal
%mat_rear_forage_m = table2array(tab_stocking_for) * kron_COS_rear

mat_GM_forage_m = tab_stocking_for_zero * kron_GM_animal
mat_GM_nofor_forage_m = tab_stocking_for_zero * kron_GM_nofor_animal
mat_SLR_forage_m = tab_stocking_for_zero * kron_SLR_animal
mat_rear_forage_m = tab_stocking_for_zero * kron_COS_rear
mat_kcal_m = tab_stocking_for_zero * kron_kcal_animal
mat_water_forage_m = tab_stocking_for_zero * kron_water_animal

%test of adding vec_SLR_forage to matrix
%vec_SLR_forage'+ diag(repelem(1,3))
%ok, adds to corresponding elements across columns
%but must not add in zero elements: 
mat_SLR_forage_m_s = mat_SLR_forage_m
mat_SLR_forage_m = vec_SLR_forage' + mat_SLR_forage_m
mat_SLR_forage_m(mat_SLR_forage_m_s==0)=0 

%%Gen GM forage for sim
%kron
for i = 1:num_animals
    %vec_GM_nofor_animal
    %kron_GM_nofor_animal = kron(diag(repelem(1,3)),vec_GM_nofor_animal)
    %mat_GM_nofor_forage_m = tab_stocking_for_zero * kron_GM_nofor_animal
    eval(strcat('kron_GM_nofor_animal_sim_minus_',strrep(strrep(name_animals(i)," ", "_"),":",""),"= kron(diag(repelem(1,3)) , vec_GM_nofor_animal_sim_minus_",strrep(strrep(name_animals(i)," ", "_"),":",""),")"))
    eval(strcat('mat_GM_nofor_forage_m_sim_minus_',strrep(strrep(name_animals(i)," ", "_"),":",""),'= tab_stocking_for_zero * kron_GM_nofor_animal_sim_minus_',strrep(strrep(name_animals(i)," ", "_"),":","")))
    eval(strcat('kron_GM_nofor_animal_sim_plus_',strrep(strrep(name_animals(i)," ", "_"),":",""),"= kron(diag(repelem(1,3)) , vec_GM_nofor_animal_sim_plus_",strrep(strrep(name_animals(i)," ", "_"),":",""),")"))
    eval(strcat('mat_GM_nofor_forage_m_sim_plus_',strrep(strrep(name_animals(i)," ", "_"),":",""),'= tab_stocking_for_zero * kron_GM_nofor_animal_sim_plus_',strrep(strrep(name_animals(i)," ", "_"),":","")))
end
%checked ok (only Dairy shocked)

%Heads calc 17/10
%%a11 coeff calc from a12 = 1 (a11 = beef on temp)


%%%Only one order
%Crops: Barley Beans FieldVegetables  Oats OSR OtherCereals_triticale_ Peas Potatoes SugarBeet TopAndSoftFruit Wheat
%Forage: fodder_crops_root_crops_forage_crops_and_all_other_crops_for_st Forage_GrasslandOverFive_PermanentGrassland Forage_GrasslandUnderFive_TemporaryGrassland Maize RoughGrazing
%Animal: Animal_BeefCattle Animal_DairyCow Animal_Sheep

%Fixed cost for fixed margin
map_fixed_cost_02_04_ACER

%EWCO Additional contributions maps (21/05 & 21/05/25)
%tab_ewco_ac = readtable("EWCO_add_contrib_21_05_25.txt","FileType","delimitedtext", "Delimiter", "#")
tab_ewco_ac = readtable("EWCO_FGS_WCG_score_payment_11_06_25.txt","FileType","delimitedtext", "Delimiter", "#")
size(tab_ewco_ac)
mat_area_crop_copy = mat_area_crop
mat_area_crop_copy.i = (1:height(mat_area_crop_copy))'
tab_ewco_ac = outerjoin(tab_ewco_ac,mat_area_crop_copy,"Keys","key")
size(tab_ewco_ac)

size(mat_area_crop)
%NPV woodland (21/05)
%cd 'D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\'
%[NPV_wood,woodland_financial_tab] = NPV_EWCO_20_05(0)
%[C0_bro,REV_Bro,C0_con,REV_Con,woodland_financial_tab] = NPV_EWCO_13_05_25(0)
[C0_bro,REV_Bro,C0_con,REV_Con,woodland_financial_tab] = NPV_EWCO_26_05_25(0)

vec_GM_tree = [REV_Bro - C0_bro ; REV_Con - C0_con]
vec_REV_tree = [REV_Bro ; REV_Con]

%07/05/25: this is the value of all harvests divided by the number of
%harvests (14)
%vec_rev_forestry_Bro = max(woodland_financial_tab.Bro_rev)
%vec_rev_forestry_Con = max(woodland_financial_tab.Con_rev)
%OBS: same as above from coefficient_of_constraints

%%%(29/04/24) crops and forages basic info
crops = tab_coeffs.type(find(tab_coeffs.group=="crop" & tab_coeffs.parameter=="GM"))
%OBS: ok, order matches that of area_observed
ncrops = length(crops)

forages = tab_coeffs.type(find(tab_coeffs.parameter=="Forage cost"))
nforages = length(forages)

animals = tab_coeffs.type(find(tab_coeffs.parameter=="GM without forage cost"))
nanimals = length(animals)

trees = tab_coeffs.type(find(tab_coeffs.group=="tree" & tab_coeffs.parameter=="GM"))
ntrees = length(trees)

%%%%%%%%%%%%Supply elasticity timber (13/05/25, from literature)
supply_elasticity_timber = [0.0246 0.171 0.28 0.91]

