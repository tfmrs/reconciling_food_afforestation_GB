
%%%%Starting
server_flag = false;
%%Altered Thiago 25/07
cd D:\Pesquisa\Pesquisa_2022\LEEP_2023\github\NEV
%%Altered Thiago 25/07
conn = fcn_connect_database(server_flag);
cd D:\Pesquisa\Pesquisa_2024\Sustainable_Prawn\NEV_TFMRS
SetDataPaths_TFMRS_D_2025;

%%Thiago modified 27/07
    cd 'D:\Pesquisa\Pesquisa_2022\LEEP_2023\github\NEV'
%%Thiago modified 27/07

    parameters = fcn_set_parameters();

%%%%Starting

%Source: ImportAgriculture

    NEVO_AgricultureGHG_data_mat = strcat(agricultureghg_data_folder, 'AgricultureGHG_data.mat');


%%Thiago modified
cd 'D:\Pesquisa\Pesquisa_2022\LEEP_2023\github\NEV\Model Imports\Agriculture'
%%Thiago modified

%Source: ImportAgriculture (no need to run this as AgricultureGHG
%structure's already generated

%    AgricultureGHG        = ImportAgricultureGHG(conn, climate_data_folder,...
%                                                'ukcp18', 'rcp60', 50, 50, ...
%                                                2020, 2059);
%    save(NEVO_AgricultureGHG_data_mat, 'AgricultureGHG', '-mat', '-v6')

%Source: fcn_run_agriculture
    % (b) Data files 
    % --------------
    AgricultureGHG_data_mat = strcat(agricultureghg_data_folder, 'AgricultureGHG_data.mat');

%Jump that.... 
%    if parameters.run_ghg
%        load(AgricultureGHG_data_mat, 'AgricultureGHG');
%        % Check if the size of AgricultureGHG is consistent with the number
%        % of years
%        if (size(AgricultureGHG.EmissionsLivestockPerHead.dairy,2) ~= parameters.num_years)
%            error('Rerun imports for AgricultureGHG such that the number of years matches parameters.num_years');
%        end
%    end

%%%...and simply run this
load(AgricultureGHG_data_mat, 'AgricultureGHG');



%%%[Thiago modified] Running timber emissions, tCO2 per ha
%%%%%%%From ImportForestGHG

    %% (1) Load data from database
    %  ===========================
    % (a) Forest Timber Carbon
    % ------------------------
    sqlquery    = ['SELECT * ', ...
                   'FROM nevo.ghg_forest_carbon_ext ', ...
                   'ORDER BY species, yield_class, year'];
    setdbprefs('DataReturnFormat','table');
    dataReturn  = fetch(exec(conn,sqlquery));
    fc_timber = dataReturn.Data;

%%%%24/01/25: Total sequestration from wood
%%Part 1, stats
fc_timber.Properties.VariableNames
unique(fc_timber.yield_class(find(fc_timber.species=="PedunculateOak")))

sum(fc_timber.tree(find(fc_timber.species=="PedunculateOak" & fc_timber.year<=2113 & fc_timber.yield_class==2)))
%Tree sequestration: tCO2e/m3
mean([sum(fc_timber.tree(find(fc_timber.species=="PedunculateOak" & fc_timber.year<=2113 & fc_timber.yield_class==2))) sum(fc_timber.tree(find(fc_timber.species=="PedunculateOak" & fc_timber.year<=113 & fc_timber.yield_class==4))) sum(fc_timber.tree(find(fc_timber.species=="PedunculateOak" & fc_timber.year<=113 & fc_timber.yield_class==6))) sum(fc_timber.tree(find(fc_timber.species=="PedunculateOak" & fc_timber.year<=113 & fc_timber.yield_class==8)))])
%Deadwood sequestration: tCO2e/m3
mean([sum(fc_timber.deadwood(find(fc_timber.species=="PedunculateOak" & fc_timber.year<=2113 & fc_timber.yield_class==2))) sum(fc_timber.deadwood(find(fc_timber.species=="PedunculateOak" & fc_timber.year<=113 & fc_timber.yield_class==4))) sum(fc_timber.deadwood(find(fc_timber.species=="PedunculateOak" & fc_timber.year<=113 & fc_timber.yield_class==6))) sum(fc_timber.deadwood(find(fc_timber.species=="PedunculateOak" & fc_timber.year<=113 & fc_timber.yield_class==8)))])
%Products sequestration: tCO2e/m3
mean([sum(fc_timber.products(find(fc_timber.species=="PedunculateOak" & fc_timber.year<=2113 & fc_timber.yield_class==2))) sum(fc_timber.products(find(fc_timber.species=="PedunculateOak" & fc_timber.year<=113 & fc_timber.yield_class==4))) sum(fc_timber.products(find(fc_timber.species=="PedunculateOak" & fc_timber.year<=113 & fc_timber.yield_class==6))) sum(fc_timber.products(find(fc_timber.species=="PedunculateOak" & fc_timber.year<=113 & fc_timber.yield_class==8)))])
%Average of sums of three sources
%%Part 2: total emissions from selected size classes

%%%%%Carbon from tree sequestration, 100 years horizon (as in Nix EWCO)
%%%%%financial sheet for Broadleaved (Pedunculate Oak) (this is in
%%%%%tonne/ha)
%YC 2
tc_yc2 = sum([fc_timber.tree(find(fc_timber.species=="PedunculateOak" & fc_timber.year<=2113 & fc_timber.yield_class==2)) fc_timber.deadwood(find(fc_timber.species=="PedunculateOak" & fc_timber.year<=2113 & fc_timber.yield_class==2)) fc_timber.products(find(fc_timber.species=="PedunculateOak" & fc_timber.year<=2113 & fc_timber.yield_class==2))],"all")
%85.4
%YC 4
tc_yc4 = sum([fc_timber.tree(find(fc_timber.species=="PedunculateOak" & fc_timber.year<=2113 & fc_timber.yield_class==4)) fc_timber.deadwood(find(fc_timber.species=="PedunculateOak" & fc_timber.year<=2113 & fc_timber.yield_class==4)) fc_timber.products(find(fc_timber.species=="PedunculateOak" & fc_timber.year<=2113 & fc_timber.yield_class==4))],"all")
%170.81
%YC 6
tc_yc6 = sum([fc_timber.tree(find(fc_timber.species=="PedunculateOak" & fc_timber.year<=2113 & fc_timber.yield_class==6)) fc_timber.deadwood(find(fc_timber.species=="PedunculateOak" & fc_timber.year<=2113 & fc_timber.yield_class==6)) fc_timber.products(find(fc_timber.species=="PedunculateOak" & fc_timber.year<=2113 & fc_timber.yield_class==6))],"all")
%228.041
%YC 8
tc_yc8 = sum([fc_timber.tree(find(fc_timber.species=="PedunculateOak" & fc_timber.year<=2113 & fc_timber.yield_class==8)) fc_timber.deadwood(find(fc_timber.species=="PedunculateOak" & fc_timber.year<=2113 & fc_timber.yield_class==8)) fc_timber.products(find(fc_timber.species=="PedunculateOak" & fc_timber.year<=2113 & fc_timber.yield_class==8))],"all")
%275.49
tc_av = mean([tc_yc2 tc_yc4 tc_yc6 tc_yc8])
