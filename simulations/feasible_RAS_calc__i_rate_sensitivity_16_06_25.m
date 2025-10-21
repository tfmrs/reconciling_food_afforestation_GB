i_rate = i_rate_out

NPV_RAS = ((1+i_rate)^RAS_lifetime - 1)/(i_rate*(1+i_rate)^RAS_lifetime)

if pixel_class == "crop_&_forage"
    NM_BL_LQ = table2array(area_observed_crop(i,id_act_crop))*vec_GM_crop(id_act_crop) + table2array(area_observed_forage(i,id_act_forage))*mat_GM_forage_m(i,id_act_forage)' - activity_shares.total_fixed_cost_ex_lab_pix(i)
    if treeless == 0
        landtot = table2array(area_observed_crop(i,id_act_crop))*ones(n_act_crop,1) + table2array(area_observed_forage(i,id_act_forage))*ones(n_act_forage,1) + table2array(area_observed_tree(i,id_act_tree))*ones(n_act_tree,1)
    else
        landtot = table2array(area_observed_crop(i,id_act_crop))*ones(n_act_crop,1) + table2array(area_observed_forage(i,id_act_forage))*ones(n_act_forage,1)
    end
    labourtot = table2array(area_observed_crop(i,id_act_crop))*vec_SLR_crop(id_act_crop) + table2array(area_observed_forage(i,id_act_forage))*mat_SLR_forage_m(i,id_act_forage)'
    watertot = table2array(area_observed_crop(i,id_act_crop))*vec_water_crop(id_act_crop) + table2array(area_observed_forage(i,id_act_forage))*mat_water_forage_m(i,id_act_forage)'
 
else
    NM_BL_LQ = table2array(area_observed_forage(i,id_act_forage))*mat_GM_forage_m(i,id_act_forage)' - activity_shares.total_fixed_cost_ex_lab_pix(i)
    if treeless == 0
        landtot = table2array(area_observed_forage(i,id_act_forage))*ones(n_act_forage,1) + table2array(area_observed_tree(i,id_act_tree))*ones(n_act_tree,1)
    else
        landtot = table2array(area_observed_forage(i,id_act_forage))*ones(n_act_forage,1)
    end
    labourtot = table2array(area_observed_forage(i,id_act_forage))*mat_SLR_forage_m(i,id_act_forage)'
    watertot = table2array(area_observed_forage(i,id_act_forage))*mat_water_forage_m(i,id_act_forage)'
end
    
     
    afford_RAS_DF = (delta*NM_BL_LQ)/(RAS_CAPEX*(1-alpha)/NPV_RAS) + ras_sub
    afford_RAS_land = landtot/vec_size_RAS
    afford_RAS_labour = labourtot/vec_SLR_RAS
    afford_RAS_water = watertot/vec_water_RAS
    gfeas = max([0 floor(min([afford_RAS_DF afford_RAS_land afford_RAS_labour afford_RAS_water]))])
    %max (0,gfeas) for cases with NM_BL_LQ < 0
    %07/05: must not use ceiling as it toss real gfeas out
