%% Simulate permanent improvements in nonprimary export sector productivity


%% Clear workspace

close all
clear


%% Load baseline model


load mat/create_model.mat m

m0 = m;
checkSteady(m0);


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

d = steadydb(m0, 1:40);


%% Simulate model with higher productivity

% Unexpected, from time t=3
d1 = d;
s1 = simulate( ...
    m1, d1, 3:40 ...
    , "prependInput", true ...
    , "method", "stacked" ...
);


p2 = Plan.forModel(m1, 1:40);
p2 = swap(p2, 1:2, ["Az", "shk_Az"]);

d2 = d;
s2 = simulate( ...
    m1, d2, 1:40 ...
    , "prependInput", true ...
    , "method", "stacked" ...
    , "plan", p2 ...
);


%% Create simulation minus control databanks

smc1 = databank.minusControl(m1, s1, d);
smc2 = databank.minusControl(m1, s2, d);


%% Chart results

ch = databank.Chartpack();
ch.Range = 0:40;
ch.PlotSettings = {"marker", "s"};

ch + ["Az", "Copt", "Chtm", "Id", "Kz", "Iz"];
ch + ["S", "dPc", "Rg", "W/Pc"];
ch + ["NIP_NGDP", "CA_NGDP", "TB_NGDP"];

draw(ch, databank.merge("horzcat", smc1, smc2));

visual.hlegend("bottom", "Unexpected", "Expected");


