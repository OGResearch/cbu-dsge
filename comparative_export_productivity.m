%% Comparative static for export productivity improvements

close all
clear

load mat/create_model.mat m

checkSteady(m);
m = solve(m);

m1 = m;
m1.ss_Az = m1.ss_Az * 1.10;

m1 = steady( ...
    m1 ...
    , "fixLevel", ["A", "Pc", "Pw_star"] ...
);

table( ...
    [m, m1], ["steady-level", "compare-steady-level", "form", "description"] ...
    , "writeTable", "tables/comparative-export-productivity.xlsx" ...
);

