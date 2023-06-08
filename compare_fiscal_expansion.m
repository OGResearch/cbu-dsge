%% Comparative static for higher government debt

close all
clear

load mat/create_model.mat m

%% Create three variants of the model
% #1: Baseline
% #2: Higher government debt with crowding out
% #3: Higher government debt without crowding out

m = alter(m, 5);
m.iota_Kg = 0.25;
m.nu = [0.10, 0.10, 0, 0.10, 0];
m.ss_Bg_NGDP = m.ss_Bg_NGDP + [0, 0.20, 0.20, 0.20, 0.20];
m.ss_Kg_A = m.ss_Kg_A .* [1, 1, 1, 1.50, 1.50];

m = steady( ...
    m ...
    , "fixLevel", ["A", "Pw_star", "Pc"] ...
    , "blocks", true ...
);
checkSteady(m);
m = solve(m);

t = table( ...
    m ...
    , ["steady-level", "compare-steady-level", "form", "description"] ...
    , "writeTable", "tables/compare-fiscal-expansion.xlsx" ...
);


