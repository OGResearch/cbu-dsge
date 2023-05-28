%% Simulate permanent improvements in nonprimary export sector productivity


%% Clear workspace

close all
clear


%% Load baseline model


load mat/create_model.mat m

m0 = m;


%% Create model with higher productivity

m1 = m0;
m1.ss_Az = m1.ss_Az * 1.10;

m1 = steady( ...
    m1 ...
    , "fixeLeveL", ["A", "Pw_star", "Pc"] ...
);

checkSteady(m1);
m1 = solve(m1);

t1 = table( ...
    [m0, m1] ...
    , ["steady-level", "compare-steady-level", "form", "description"] ...
    , "writeTable", "tables/comparative-export-productivity.xlsx" ...
);


%% Prepare initial databank for simulation

d = databank.forModel(m0, 1:40);

%% Simulate model with higher productivity

d1 = d;
s1 = simulate( ...
    m1, d1, 1:40 ...
    , "prependInput", true ...
    , "method", "stacked" ...
);


smc1 = databank.minusControl(m1, s1, d);


%% Chart results

ch = Chartpack();
ch.Range = 0:40;
ch.PlotSettings = {"marker", "s"};

ch + ["Copt", "Chtm", "Iy", "Kz", "Iz"];

draw(ch, smc1);


