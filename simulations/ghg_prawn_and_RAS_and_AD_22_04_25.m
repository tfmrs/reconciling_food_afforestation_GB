function total_GHG_GB_prawn = ghg_prawn_and_RAS_03_03_25(RAS_units_grid,RAS_units_AD, RAS_binary)
%Emissions from Prawn imports
%GHG from Henriksson et al., 2014, kgCO2eq/kg
GHG_prawn_imported = 0.79916
%Quantity in kg
GHG_prawn_transport_imported = 0.82824
%Calculated 22/04/25
quantity_prawn_imported =  34852800
%quantity_prawn_produced =  8690688
quantity_prawn_produced = (RAS_units_grid + RAS_units_AD)*6624

total_GHG_prawn_net_imports = GHG_prawn_imported * (quantity_prawn_imported - quantity_prawn_produced * RAS_binary)

%Emissions from RAS

%%(1) Electricity emissions (kgCO2eq/kg prawn)
GHG_RAS_electricity = 0.33824
%%Energy consumption : 7kWh/kg [no need to multply by 6624 kg as will do
%%that for whole GB production)
%RAS_electricity_consumption = 7
%consumption not needed as already incorporated to GHG_RAS_electricity

total_GHG_RAS_grid_electricity = GHG_RAS_electricity * RAS_units_grid*6624

%%(2) Electricity from biogas consumption (kgCO2eq/kg)
%This is a 10^3ton/terajoule coeff (biogas)
%% 0.000001 (multiplied by 10^3 to express as tCO2e, not ktCOe)
emission_coeff_CH4 = 10^3 * 10^-6;
%% 0.0000001 (multiplied by 10^3 to express as tCO2e, not ktCOe)
emission_coeff_N2O = 10^3 * 10^-7; 

%[kg/MWh * MWh/10^3kWh] 
conversion_factor_kWh_to_TJ = 3.6 * 10^-6
conversion_CH4_CO2 = 28
conversion_N2O_CO2 = 265
consumption_electricity_AD_RAS = 6624*7*RAS_units_AD
%conversion gases source : (table 1.1) https://uk-air.defra.gov.uk/assets/documents/reports/cat09/2404111649_ukghgi-90-22_Main_Issue1.pdf

%CH4 = 10^-3 tCH4 / TJ * 28 tCO2/tCH4 * 3.6 * 10^-6 TJ /kWh = 28*3.6*10^-9 tCO2e/kWh
%N2O = 10^-7 kton N2O / TJ * 265 tCO2/tCH4 * 3.6 * 10^-6 TJ /kWh =
%265*3.6*10^-10
28*3.6*10^-9 + 265*3.6*10^-10
(emission_coeff_CH4 * conversion_CH4_CO2 + emission_coeff_N2O * conversion_N2O_CO2)*conversion_factor_kWh_to_TJ
%ok
%total tCO2e/tonne Prawn

total_GHG_RAS_AD_electricity = (emission_coeff_CH4 * conversion_CH4_CO2 + emission_coeff_N2O * conversion_N2O_CO2)*conversion_factor_kWh_to_TJ*consumption_electricity_AD_RAS


%%Nitrification emissions (Yogev et al., 2018), kgCO2/kgPrawn
GHG_RAS_nitrification = 1.36*10^-3
total_GHG_RAS_nitrification = GHG_RAS_nitrification * quantity_prawn_produced

total_GHG_RAS = total_GHG_RAS_grid_electricity + total_GHG_RAS_AD_electricity + total_GHG_RAS_nitrification

%Total emissions British prawn consumption

total_GHG_GB_prawn = (-1)*(total_GHG_prawn_net_imports + total_GHG_RAS)

%Total emission avoided from prawn substituted
GHG_avoided_by_import_substitution = GHG_prawn_imported*quantity_prawn_produced - (GHG_RAS_electricity + GHG_RAS_nitrification)*RAS_units_grid*6624 - (emission_coeff_CH4 * conversion_CH4_CO2 + emission_coeff_N2O*conversion_N2O_CO2)*conversion_factor_kWh_to_TJ*consumption_electricity_AD_RAS

%22/04/25
%format = (EF_import - EF_prod_grid)*(0 - prod_AL_grid) + (EF_import - EF_prod_AD)*(0 - prod_AL_prod_AL_AD) 
GHG_increase_prod_decrease_imports = (GHG_prawn_imported - (GHG_RAS_electricity + GHG_RAS_nitrification))*(0 - RAS_units_grid*6624) + (GHG_prawn_imported - ((emission_coeff_CH4 * conversion_CH4_CO2 + emission_coeff_N2O*conversion_N2O_CO2)*conversion_factor_kWh_to_TJ+ GHG_RAS_nitrification))*(0 - RAS_units_AD*6624)

GHG_increase_prod_decrease_imports_grid = (GHG_prawn_imported - (GHG_RAS_electricity + GHG_RAS_nitrification))*(0 - RAS_units_grid*6624) 
GHG_increase_prod_decrease_imports_AD = (GHG_prawn_imported - ((emission_coeff_CH4 * conversion_CH4_CO2 + emission_coeff_N2O*conversion_N2O_CO2)*conversion_factor_kWh_to_TJ+ GHG_RAS_nitrification))*(0 - RAS_units_AD*6624)

total_GHG_transport_imported = (0.82824)*((0 - RAS_units_grid*6624) +(0 - RAS_units_AD*6624))

total_GHG_GB_prawn = array2table([total_GHG_GB_prawn (-1)*total_GHG_prawn_net_imports (-1)*total_GHG_RAS_grid_electricity (-1)*total_GHG_RAS_AD_electricity GHG_avoided_by_import_substitution GHG_increase_prod_decrease_imports GHG_increase_prod_decrease_imports_grid GHG_increase_prod_decrease_imports_AD total_GHG_transport_imported])

total_GHG_GB_prawn.Properties.VariableNames = ["total_GHG_GB_prawn" "GHG_prawn_net_imports" "GHG_domestic_prawn_grid" "GHG_domestic_prawn_AD" "GHG_avoided_by_import_substitution" "GHG_increase_prod_decrease_imports" "GHG_increase_prod_decrease_imports_grid" "GHG_increase_prod_decrease_imports_AD" "total_GHG_transport_imported"]

end

