
%a.0 Totals (OBS: for livestock should use mat_GM_forage_m, which is discounted by forage cost)
mat_landtot = table2array(area_observed_crop)*ones(12,1) + table2array(area_observed_forage)*ones(3,1)
mat_GMtot = table2array(area_observed_crop)*vec_GM_crop + (table2array(area_observed_forage).*mat_GM_forage_m)*ones(3,1)

%a.1.Dairy
sh_dairy_GM = vec_GM_animal(2)*stocking_allocated.herd_dairy./ mat_GMtot

inv_dairy_temp = 1./stocking_allocated.stocking_dairy_temp
inv_dairy_temp(find(inv_dairy_temp>10^10)) = 0

inv_dairy_perm = 1./stocking_allocated.stocking_dairy_perm
inv_dairy_perm(find(inv_dairy_perm>10^10)) = 0

inv_dairy_rough = 1./stocking_allocated.stocking_dairy_rough
inv_dairy_rough(find(inv_dairy_rough>10^10)) = 0

%sh_dairy_area = ((inv_dairy_temp + inv_dairy_perm + inv_dairy_rough).*stocking_allocated.herd_dairy)./mat_landtot
height(find(inv_dairy_perm > 0 & inv_dairy_perm < 1))
%149 cases; let's use only dairy_temp, as perm < 1 mostly and this explodes
%dairy area

sh_dairy_area = ((inv_dairy_temp).*stocking_allocated.herd_dairy)./mat_landtot


%a.2.cereals: barley(1), oats(5), other cereals(7), wheat(12)
sh_cereal_GM = (table2array(area_observed_crop(:,[1,5,7,12])) * vec_GM_crop([1,5,7,12])) ./ mat_GMtot
sh_cereal_area = table2array(area_observed_crop(:,[1,5,7,12]))*ones(4,1) ./ mat_landtot

%a.3.general cropping: all crops
sh_crop_GM = (table2array(area_observed_crop) * vec_GM_crop) ./ mat_GMtot
sh_crop_area = table2array(area_observed_crop)*ones(12,1) ./ mat_landtot

%a.4.sheep and cattle
sh_livestock_GM = (table2array(area_observed_forage).*mat_GM_forage_m)*ones(3,1) ./ mat_GMtot
sh_livestock_area = table2array(area_observed_forage)*ones(3,1) ./ mat_landtot

activity_shares = [mat_area_crop(:,1) array2table(sh_dairy_GM) array2table(sh_cereal_GM ) array2table(sh_crop_GM ) array2table(sh_livestock_GM ) array2table(sh_dairy_area ) array2table(sh_cereal_area ) array2table(sh_crop_area ) array2table(sh_livestock_area)]
activity_shares = join(av_farm_area,activity_shares,"Keys","key")

%check pctiles
[prctile(activity_shares.sh_dairy_GM,20) prctile(activity_shares.sh_dairy_GM,40) prctile(activity_shares.sh_dairy_GM,50) prctile(activity_shares.sh_dairy_GM,60) prctile(activity_shares.sh_dairy_GM,80) prctile(activity_shares.sh_dairy_GM,100)]
[prctile(activity_shares.sh_dairy_area,20) prctile(activity_shares.sh_dairy_area,40) prctile(activity_shares.sh_dairy_area,50) prctile(activity_shares.sh_dairy_area,60) prctile(activity_shares.sh_dairy_area,80) prctile(activity_shares.sh_dairy_area,100)]

[prctile(activity_shares.sh_cereal_GM,20) prctile(activity_shares.sh_cereal_GM,40) prctile(activity_shares.sh_cereal_GM,50) prctile(activity_shares.sh_cereal_GM,60) prctile(activity_shares.sh_cereal_GM,80) prctile(activity_shares.sh_cereal_GM,100)]
[prctile(activity_shares.sh_cereal_area,20) prctile(activity_shares.sh_cereal_area,40) prctile(activity_shares.sh_cereal_area,50) prctile(activity_shares.sh_cereal_area,60) prctile(activity_shares.sh_cereal_area,80) prctile(activity_shares.sh_cereal_area,100)]

[prctile(activity_shares.sh_crop_GM,20) prctile(activity_shares.sh_crop_GM,40) prctile(activity_shares.sh_crop_GM,50) prctile(activity_shares.sh_crop_GM,60) prctile(activity_shares.sh_crop_GM,80) prctile(activity_shares.sh_crop_GM,100)]
[prctile(activity_shares.sh_crop_area,20) prctile(activity_shares.sh_crop_area,40) prctile(activity_shares.sh_crop_area,50) prctile(activity_shares.sh_crop_area,60) prctile(activity_shares.sh_crop_area,80) prctile(activity_shares.sh_crop_area,100)]

[prctile(activity_shares.sh_livestock_GM,20) prctile(activity_shares.sh_livestock_GM,40) prctile(activity_shares.sh_livestock_GM,50) prctile(activity_shares.sh_livestock_GM,60) prctile(activity_shares.sh_livestock_GM,80) prctile(activity_shares.sh_livestock_GM,100)]
[prctile(activity_shares.sh_livestock_area,20) prctile(activity_shares.sh_livestock_area,40) prctile(activity_shares.sh_livestock_area,50) prctile(activity_shares.sh_livestock_area,60) prctile(activity_shares.sh_livestock_area,80) prctile(activity_shares.sh_livestock_area,100)]


activity_shares.d_class_dairy = repelem(0,height(activity_shares))'
activity_shares.d_class_dairy(find(activity_shares.sh_dairy_GM>2/3)) = repelem(1,height(find(activity_shares.sh_dairy_GM>2/3)))

activity_shares.d_class_cereal = repelem(0,height(activity_shares))'
activity_shares.d_class_cereal(find(activity_shares.sh_cereal_GM>2/3)) = repelem(1,height(find(activity_shares.sh_cereal_GM>2/3)))

activity_shares.d_class_crop = repelem(0,height(activity_shares))'
activity_shares.d_class_crop(find(activity_shares.sh_crop_GM>2/3)) = repelem(1,height(find(activity_shares.sh_crop_GM>2/3)))

activity_shares.d_class_livestock = repelem(0,height(activity_shares))'
activity_shares.d_class_livestock(find(activity_shares.sh_livestock_GM>2/3)) = repelem(1,height(find(activity_shares.sh_livestock_GM>2/3)))

find(activity_shares.d_class_dairy==1 & activity_shares.d_class_cereal==1 & activity_shares.d_class_crop==1 & activity_shares.d_class_livestock==1)

%Dairy vs cereal (3 2 1)
find(activity_shares.d_class_dairy==1 & activity_shares.d_class_cereal==1)
%Dairy vs crop (2 1)
find(activity_shares.d_class_dairy==1 & activity_shares.d_class_crop==1)
%Dairy vs livestock (1)
height(find(activity_shares.d_class_dairy==1 & activity_shares.d_class_livestock==1))
%527 --> should be dairy (most specialized prevails)
%Cereal vs crop (2 1)
height(find(activity_shares.d_class_cereal==1 & activity_shares.d_class_crop==1))
%134--> should be cereal (most specialized prevails)
%Cereal vs livestock (1) 
height(find(activity_shares.d_class_cereal==1 & activity_shares.d_class_livestock==1))
%0
%Crop vs livestock (1)
height(find(activity_shares.d_class_crop==1 & activity_shares.d_class_livestock==1))
%0
height(find(activity_shares.d_class_dairy==0 & activity_shares.d_class_cereal==0 & activity_shares.d_class_crop==0 & activity_shares.d_class_livestock==0))
%1827 --> use the average across the four types (and size info)

activity_shares.class = repelem("NA",height(activity_shares))'
activity_shares.class(find(activity_shares.d_class_dairy ==1)) = repelem("dairy",height(find(activity_shares.d_class_dairy ==1)))
activity_shares.class(find(activity_shares.d_class_cereal ==1)) = repelem("cereal",height(find(activity_shares.d_class_cereal ==1)))
activity_shares.class(find(activity_shares.d_class_crop ==1 & activity_shares.d_class_cereal ==0)) = repelem("crop",height(find(activity_shares.d_class_crop ==1 & activity_shares.d_class_cereal ==0)))
activity_shares.class(find(activity_shares.d_class_livestock ==1 & activity_shares.d_class_dairy ==0)) = repelem("livestock",height(find(activity_shares.d_class_livestock ==1 & activity_shares.d_class_dairy ==0)))
activity_shares.class(find(activity_shares.d_class_dairy==0 & activity_shares.d_class_cereal==0 & activity_shares.d_class_crop==0 & activity_shares.d_class_livestock==0)) = repelem("mixed",height(find(activity_shares.d_class_dairy==0 & activity_shares.d_class_cereal==0 & activity_shares.d_class_crop==0 & activity_shares.d_class_livestock==0)))
tabulate(activity_shares.class)


upland = readtable("upland_census_03_04_24.txt");
height(upland)
activity_shares = join(upland,activity_shares,"Keys","key");
activity_shares.class(find(activity_shares.class == "livestock" & activity_shares.d_upland == 1)) = repelem("livestock_upland",height(find(activity_shares.class == "livestock" & activity_shares.d_upland == 1)));
height(activity_shares)
tabulate(activity_shares.class)

activity_shares.Properties.VariableNames
activity_shares.total_fixed_cost = repelem(NaN,height(activity_shares))'

activity_shares.total_fixed_cost(find(activity_shares.afr_final < 75 & activity_shares.class =="dairy")) = repelem(1825,height(find(activity_shares.afr_final < 75 & activity_shares.class =="dairy")))
activity_shares.total_fixed_cost(find(activity_shares.afr_final >= 75 & activity_shares.afr_final < 125 & activity_shares.class =="dairy")) = repelem(2060,height(find(activity_shares.afr_final >= 75 & activity_shares.afr_final < 125 & activity_shares.class =="dairy")))
activity_shares.total_fixed_cost(find(activity_shares.afr_final > 125 & activity_shares.class =="dairy")) = repelem(2185,height(find(activity_shares.afr_final > 125 & activity_shares.class =="dairy")))
activity_shares.total_fixed_cost(find(activity_shares.afr_final < 200 & activity_shares.class =="cereal")) = repelem(935,height(find(activity_shares.afr_final < 200 & activity_shares.class =="cereal")))
activity_shares.total_fixed_cost(find(activity_shares.afr_final >= 200 & activity_shares.afr_final < 300 & activity_shares.class =="cereal")) = repelem(965,height(find(activity_shares.afr_final >= 200 & activity_shares.afr_final < 300 & activity_shares.class =="cereal")))
activity_shares.total_fixed_cost(find(activity_shares.afr_final > 300 & activity_shares.class =="cereal")) = repelem(915,height(find(activity_shares.afr_final > 300 & activity_shares.class =="cereal")))
activity_shares.total_fixed_cost(find(activity_shares.afr_final < 150 & activity_shares.class =="crop")) = repelem(1075,height(find(activity_shares.afr_final < 150 & activity_shares.class =="crop")))
activity_shares.total_fixed_cost(find(activity_shares.afr_final >= 150 & activity_shares.afr_final < 250 & activity_shares.class =="crop")) = repelem(1170,height(find(activity_shares.afr_final >= 150 & activity_shares.afr_final < 250 & activity_shares.class =="crop")))
activity_shares.total_fixed_cost(find(activity_shares.afr_final > 250 & activity_shares.class =="crop")) = repelem(1125,height(find(activity_shares.afr_final > 250 & activity_shares.class =="crop")))
activity_shares.total_fixed_cost(find(activity_shares.afr_final < 90 & activity_shares.class =="livestock")) = repelem(1035,height(find(activity_shares.afr_final < 90 & activity_shares.class =="livestock")))
activity_shares.total_fixed_cost(find(activity_shares.afr_final >= 90 & activity_shares.afr_final < 125 & activity_shares.class =="livestock")) = repelem(1120,height(find(activity_shares.afr_final >= 90 & activity_shares.afr_final < 125 & activity_shares.class =="livestock")))
activity_shares.total_fixed_cost(find(activity_shares.afr_final > 125 & activity_shares.class =="livestock")) = repelem(1060,height(find(activity_shares.afr_final > 125 & activity_shares.class =="livestock")))
activity_shares.total_fixed_cost(find(activity_shares.afr_final < 130 & activity_shares.class =="livestock_upland")) = repelem(690,height(find(activity_shares.afr_final < 130 & activity_shares.class =="livestock_upland")))
activity_shares.total_fixed_cost(find(activity_shares.afr_final >= 130 & activity_shares.afr_final < 200 & activity_shares.class =="livestock_upland")) = repelem(620,height(find(activity_shares.afr_final >= 130 & activity_shares.afr_final < 200 & activity_shares.class =="livestock_upland")))
activity_shares.total_fixed_cost(find(activity_shares.afr_final > 200 & activity_shares.class =="livestock_upland")) = repelem(495,height(find(activity_shares.afr_final > 200 & activity_shares.class =="livestock_upland")))
activity_shares.total_fixed_cost(find(activity_shares.class =="mixed")) = repelem(1151.66666666667,height(find(activity_shares.class =="mixed")))

activity_shares.total_fixed_cost_ex_lab = repelem(NaN,height(activity_shares))'

activity_shares.total_fixed_cost_ex_lab(find(activity_shares.afr_final < 75 & activity_shares.class =="dairy")) = repelem(955,height(find(activity_shares.afr_final < 75 & activity_shares.class =="dairy")))
activity_shares.total_fixed_cost_ex_lab(find(activity_shares.afr_final >= 75 & activity_shares.afr_final < 125 & activity_shares.class =="dairy")) = repelem(1245,height(find(activity_shares.afr_final >= 75 & activity_shares.afr_final < 125 & activity_shares.class =="dairy")))
activity_shares.total_fixed_cost_ex_lab(find(activity_shares.afr_final > 125 & activity_shares.class =="dairy")) = repelem(1430,height(find(activity_shares.afr_final > 125 & activity_shares.class =="dairy")))
activity_shares.total_fixed_cost_ex_lab(find(activity_shares.afr_final < 200 & activity_shares.class =="cereal")) = repelem(710,height(find(activity_shares.afr_final < 200 & activity_shares.class =="cereal")))
activity_shares.total_fixed_cost_ex_lab(find(activity_shares.afr_final >= 200 & activity_shares.afr_final < 300 & activity_shares.class =="cereal")) = repelem(720,height(find(activity_shares.afr_final >= 200 & activity_shares.afr_final < 300 & activity_shares.class =="cereal")))
activity_shares.total_fixed_cost_ex_lab(find(activity_shares.afr_final > 300 & activity_shares.class =="cereal")) = repelem(705,height(find(activity_shares.afr_final > 300 & activity_shares.class =="cereal")))
activity_shares.total_fixed_cost_ex_lab(find(activity_shares.afr_final < 150 & activity_shares.class =="crop")) = repelem(785,height(find(activity_shares.afr_final < 150 & activity_shares.class =="crop")))
activity_shares.total_fixed_cost_ex_lab(find(activity_shares.afr_final >= 150 & activity_shares.afr_final < 250 & activity_shares.class =="crop")) = repelem(835,height(find(activity_shares.afr_final >= 150 & activity_shares.afr_final < 250 & activity_shares.class =="crop")))
activity_shares.total_fixed_cost_ex_lab(find(activity_shares.afr_final > 250 & activity_shares.class =="crop")) = repelem(795,height(find(activity_shares.afr_final > 250 & activity_shares.class =="crop")))
activity_shares.total_fixed_cost_ex_lab(find(activity_shares.afr_final < 90 & activity_shares.class =="livestock")) = repelem(560,height(find(activity_shares.afr_final < 90 & activity_shares.class =="livestock")))
activity_shares.total_fixed_cost_ex_lab(find(activity_shares.afr_final >= 90 & activity_shares.afr_final < 125 & activity_shares.class =="livestock")) = repelem(675,height(find(activity_shares.afr_final >= 90 & activity_shares.afr_final < 125 & activity_shares.class =="livestock")))
activity_shares.total_fixed_cost_ex_lab(find(activity_shares.afr_final > 125 & activity_shares.class =="livestock")) = repelem(690,height(find(activity_shares.afr_final > 125 & activity_shares.class =="livestock")))
activity_shares.total_fixed_cost_ex_lab(find(activity_shares.afr_final < 130 & activity_shares.class =="livestock_upland")) = repelem(350,height(find(activity_shares.afr_final < 130 & activity_shares.class =="livestock_upland")))
activity_shares.total_fixed_cost_ex_lab(find(activity_shares.afr_final >= 130 & activity_shares.afr_final < 200 & activity_shares.class =="livestock_upland")) = repelem(345,height(find(activity_shares.afr_final >= 130 & activity_shares.afr_final < 200 & activity_shares.class =="livestock_upland")))
activity_shares.total_fixed_cost_ex_lab(find(activity_shares.afr_final > 200 & activity_shares.class =="livestock_upland")) = repelem(300,height(find(activity_shares.afr_final > 200 & activity_shares.class =="livestock_upland")))
activity_shares.total_fixed_cost_ex_lab(find(activity_shares.class =="mixed")) = repelem(740,height(find(activity_shares.class =="mixed")))

tabulate(activity_shares.total_fixed_cost_ex_lab)
%checkcheck = [activity_shares.afr_final activity_shares.class activity_shares.total_fixed_cost activity_shares.total_fixed_cost_ex_lab]
%ok

%Attention: fixed costs in per-hectare basis, must be coverted to per-pixel
%basis
activity_shares.total_fixed_cost_pix = activity_shares.total_fixed_cost .* mat_landtot
activity_shares.total_fixed_cost_ex_lab_pix = activity_shares.total_fixed_cost_ex_lab .* mat_landtot



%Map
writetable(activity_shares,"activity_shares_for_farm_classification_net_margin_03_04_24.txt")
