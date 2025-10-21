
tab_coeffs = readtable("coefficients_OF_constraints_RAS_only_EQ_protein_04_07_25.txt")

%woodland and calories parameters (09/01)
vec_kcal_crop = tab_coeffs.final_value(find(tab_coeffs.parameter=="Calories" & tab_coeffs.group=="crop"))
vec_kcal_animal = tab_coeffs.final_value(find(tab_coeffs.parameter=="Calories" & tab_coeffs.group=="animal"))
vec_kcal_RAS = tab_coeffs.final_value(find(tab_coeffs.parameter=="Calories" & tab_coeffs.group=="RAS"))

%woodland and Protein parameters (09/01)
vec_protein_crop = tab_coeffs.final_value(find(tab_coeffs.parameter=="Protein" & tab_coeffs.group=="crop"))
vec_protein_animal = tab_coeffs.final_value(find(tab_coeffs.parameter=="Protein" & tab_coeffs.group=="animal"))
vec_protein_RAS = tab_coeffs.final_value(find(tab_coeffs.parameter=="Protein" & tab_coeffs.group=="RAS"))


stocking_allocated = readtable('stocking_checking_new_alg_with_Sco_whole_Census_16_06_25_woodquad_allpix_after_revision.txt',"FileType","delimitedtext", "Delimiter", ",");
tab_stocking_for = [stocking_allocated(:,[6,3,9]) stocking_allocated(:,[5,2,8]) stocking_allocated(:,[7,4,10]) ]
tab_stocking_for_zero = table2array(tab_stocking_for)
tab_stocking_for_zero(isnan(tab_stocking_for_zero)==1)=0

kron_kcal_animal = kron(diag(repelem(1,3)),vec_kcal_animal)
mat_kcal_m = tab_stocking_for_zero * kron_kcal_animal

kron_protein_animal = kron(diag(repelem(1,3)),vec_protein_animal)
mat_protein_m = tab_stocking_for_zero * kron_protein_animal
