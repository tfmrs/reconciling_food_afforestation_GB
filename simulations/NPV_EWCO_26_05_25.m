
%function [NPV_Bro,NPV_Con] = NPV_EWCO(Bro_cap_grant,Con_cap_grant,sub_add_contrib)
%function [min_cap_grant_Bro,min_cap_grant_Con,GM_set_aside_Bro,GM_set_aside_Con] = NPV_EWCO(subsidy)
%function [NPV_max,woodland_financial_tab] = NPV_EWCO(subsidy)
%function [GM_set_aside_Bro,GM_set_aside_Con,woodland_financial_tab] = NPV_EWCO(subsidy)

function [AVC_set_aside_Bro,REV_set_aside_Bro,AVC_set_aside_Con,REV_set_aside_Con,woodland_financial_tab] = NPV_EWCO_26_05_25(subsidy)

%Parameters
i_rate = 0.04
%i_rate = 0.03
bro_lifetime = 100
con_lifetime = 50

NPV_tree_bro = ((1+i_rate)^bro_lifetime - 1)/(i_rate*(1+i_rate)^bro_lifetime)
NPV_tree_con = ((1+i_rate)^con_lifetime - 1)/(i_rate*(1+i_rate)^con_lifetime)

%Table
woodland_financial_tab = zeros(100,12)
woodland_financial_tab = array2table(woodland_financial_tab)
woodland_financial_tab.Properties.VariableNames = ["Bro_cost_1_estab" "Bro_cost_2_maint" "Bro_rev" "Bro_grant" "Bro_tcost" "Bro_NCF" "Con_cost_1_estab" "Con_cost_2_maint" "Con_rev" "Con_grant" "Con_tcost" "Con_NCF"]


%%%%%%%%(1)Cost
%%Period:Year 1 to year 3

%%%%%%(1.a) Cost: establishment (net of grant)

%%%%%%(1.a.1) Broadleaved
%Nix 23 range, p.114, total three years = [8500;10500] (Deer protection
%required)
woodland_financial_tab.Bro_cost_1_estab(1:3) = repelem(((8500+10500)/2)/3,3)
%Annuity
%woodland_financial_tab.Bro_cost_1_estab(1:bro_lifetime) = repelem(((8500+10500)/2/NPV_tree_bro),bro_lifetime)

%%%%%%(1.a.2) Conifer
%Nix 23 range, p.114, total three years = [4000;6800]
woodland_financial_tab.Con_cost_1_estab(1:3) = repelem(((4000+6800)/2)/3,3)
%Annuity
%woodland_financial_tab.Con_cost_1_estab(1:con_lifetime) = repelem(((4000+6800)/2/NPV_tree_con)/3,con_lifetime)

%%%%%%(1.b) Cost: maintenance (net of grant)

%%%%%%(1.b.1) Broadleaved
%%Period: Year 4 to 95 (OBS: fertilizer cost = half year 4, half year 20 [in line with the "one or two times in the first 20 years", p.115]
woodland_financial_tab.Bro_cost_2_maint(4) = 1722 + 300 + 350/2 
woodland_financial_tab.Bro_cost_2_maint(5:95) = 4275/(95-5+1) 
woodland_financial_tab.Bro_cost_2_maint(20) = 4275/(95-5+1) + 350/2

%%maintenance cost according with p.115
%woodland_financial_tab.Bro_cost_2_maint(4) = 600 + (110+275)/2 
%woodland_financial_tab.Bro_cost_2_maint(5:95) = 600 
%woodland_financial_tab.Bro_cost_2_maint(20) = 600 + (110+275)/2


%%%%%%(1.b.2) Conifer
%%Period: Year 4 to 45 (OBS: fertilizer as in Bro)
woodland_financial_tab.Con_cost_2_maint(4) = 1017 + 300 + 350/2
woodland_financial_tab.Con_cost_2_maint(5:45) = 2025/(45-5+1)
woodland_financial_tab.Con_cost_2_maint(20) = 2025/(45-5+1) + 350/2

%maintenance cost according with p.115
%woodland_financial_tab.Con_cost_2_maint(4) = 600 + (110+275)/2
%woodland_financial_tab.Con_cost_2_maint(5:45) = 600
%woodland_financial_tab.Con_cost_2_maint(20) = 600 + (110+275)

%%%%%%(1.c) Cost: marking and measuring

%%%%%%(1.b.1) Broadleaved
%%Period: starting between 18-25 yr (MP ~ 22); freq 5-7 yr (MP = 6) year 18 to 100
%Production = 4-8 m3
%(1.b.1.a) Thinning;cost = 0.75-1 £/m3
woodland_financial_tab.Bro_cost_2_maint(22:6:100) = woodland_financial_tab.Bro_cost_2_maint(22:6:100) + repelem(6*1.75/2,length(22:6:100))'
%(1.b.1.b) Felling;cost = 300 to 400 £/ha -> MP ~ £350
woodland_financial_tab.Bro_cost_2_maint(100) = woodland_financial_tab.Bro_cost_2_maint(100) + 350

%%%%%%(1.b.2) Conifer
%%cost 0.75-1 £/m3
%Production = 12-18 m3
%(1.b.2.a) Thinning;cost = 0.75-1 £/m3
    %%Period: starting between 18-25 yr (MP ~ 22); freq 5-7 yr (MP = 6) year 18 to 50
woodland_financial_tab.Con_cost_2_maint(22:6:50) = woodland_financial_tab.Con_cost_2_maint(22:6:50) + repelem(15*1.75/2,length(22:6:50))'
%(1.b.2.b) Thinning;cost = 300 to 400 £/ha -> MP ~ £350
woodland_financial_tab.Con_cost_2_maint(50) = woodland_financial_tab.Con_cost_2_maint(50) + 350

%%%%%%%%(2)Revenue

%%%%%%(2.a) Broadleaved {attention: automatic harvest at terminal year}
%%Period: starting between 18-25 yr (MP ~ 22); freq 5-7 yr (MP = 6) year 18
%%to 100
%%(seq in ML: start:increment:end)
woodland_financial_tab.Bro_rev(22:6:100) = repelem((30000)/length(22:6:100),length(22:6:100))'

%%%%%%(2.b) Conifer {attention: no automatic harvest at terminal year}
%%Period: starting between 18-25 yr (MP ~ 22); freq 5-7 yr (MP = 6) year 18 to 50
%%(seq in ML: start:increment:end)
woodland_financial_tab.Con_rev([22:6:50,50]) = repelem((18000)/length([22:6:50,50]),length([22:6:50,50]))'

%%%%%%%%(4)Grants 1: capital and maintenance

%%%%%%(4.a) Broadleaved
%Nix table p.110
woodland_financial_tab.Bro_grant(1) = 2560
woodland_financial_tab.Bro_grant(4:13) = repelem(300,10)'

%woodland_financial_tab.Bro_grant(1) = 0
%woodland_financial_tab.Bro_grant(4:13) = repelem(0,10)'


%%Following EWCO web
%woodland_financial_tab.Bro_grant(1:3) = woodland_financial_tab.Bro_cost_1_estab(1:3)
%%woodland_financial_tab.Bro_grant(4:13) = woodland_financial_tab.Bro_cost_2_maint(4:13)
%woodland_financial_tab.Bro_grant(4:15) = woodland_financial_tab.Bro_cost_2_maint(4:15)

%%woodland_financial_tab.Bro_grant = repelem(subsidy,height(woodland_financial_tab))'
%%the additional contribution payment of EWCO is one-off
woodland_financial_tab.Bro_grant(4) = woodland_financial_tab.Bro_grant(4) + subsidy


%%%%%%(4.a) Conifer
%Nix table p.110
woodland_financial_tab.Con_grant(1) = 4000
woodland_financial_tab.Con_grant(4:13) = repelem(300,10)'

%woodland_financial_tab.Con_grant(1) = 0
%woodland_financial_tab.Con_grant(4:13) = repelem(0,10)'

%%Following EWCO web
%woodland_financial_tab.Con_grant(1:3) = woodland_financial_tab.Con_cost_1_estab(1:3)
%%woodland_financial_tab.Con_grant(4:13) = woodland_financial_tab.Con_cost_2_maint(4:13)
%woodland_financial_tab.Con_grant(4:15) = woodland_financial_tab.Con_cost_2_maint(4:15)

%%woodland_financial_tab.Con_grant = repelem(subsidy,height(woodland_financial_tab))'
%%woodland_financial_tab.Con_grant = repelem(subsidy,height(woodland_financial_tab))'
%%the additional contribution payment of EWCO is one-off
woodland_financial_tab.Con_grant(4) = woodland_financial_tab.Con_grant(4) + subsidy

%%%%%%%%(4)Grants 2: additional contribution

%%%%%%(4.a) Broadleaved
%woodland_financial_tab.Bro_grant(4) = woodland_financial_tab.Bro_grant(4) + sub_add_contrib

%%%%%%(4.a) Conifer
%woodland_financial_tab.Con_grant(4) = woodland_financial_tab.Con_grant(4) + sub_add_contrib


%%%%%%%%(4)Total cost and GM
woodland_financial_tab.Bro_tcost = woodland_financial_tab.Bro_cost_1_estab + woodland_financial_tab.Bro_cost_2_maint - woodland_financial_tab.Bro_grant
woodland_financial_tab.Bro_NCF = woodland_financial_tab.Bro_rev - woodland_financial_tab.Bro_tcost 

woodland_financial_tab.Con_tcost = woodland_financial_tab.Con_cost_1_estab + woodland_financial_tab.Con_cost_2_maint - woodland_financial_tab.Con_grant
woodland_financial_tab.Con_NCF = woodland_financial_tab.Con_rev - woodland_financial_tab.Con_tcost

woodland_financial_tab.discount = ((1+i_rate).^-(0:(height(woodland_financial_tab))-1))'

AVC_set_aside_Bro = woodland_financial_tab.discount'*woodland_financial_tab.Bro_tcost
AVC_set_aside_Con = woodland_financial_tab.discount'*woodland_financial_tab.Con_tcost

REV_set_aside_Bro = woodland_financial_tab.discount'*woodland_financial_tab.Bro_rev
REV_set_aside_Con = woodland_financial_tab.discount'*woodland_financial_tab.Con_rev

GM_set_aside_Bro = woodland_financial_tab.discount'*woodland_financial_tab.Bro_NCF
GM_set_aside_Con = woodland_financial_tab.discount'*woodland_financial_tab.Con_NCF

NPV_max = max(GM_set_aside_Bro,GM_set_aside_Con)
%NPV_max = max(GM_set_aside_Bro)
min_cap_grant_Bro = -woodland_financial_tab.Bro_NCF(1) -woodland_financial_tab.discount(2:100)'*woodland_financial_tab.Bro_NCF(2:100)
min_cap_grant_Con = -woodland_financial_tab.Con_NCF(1) -woodland_financial_tab.discount(2:100)'*woodland_financial_tab.Con_NCF(2:100)

end

%Procedure to obtain the NPV of the cost falling on farmer
%NPV_EWCO_19_03(0,0) --> [min_cap_grant_Bro*,min_cap_grant_Con*]
%NPV_EWCO_19_03(min_cap_grant_Bro*,min_cap_grant_Con*) --> [ACV_set_aside_Bro*,ACV_set_aside_Con*]
