%% Simulate permanent deterioration in primary TOT


%% Clear workspace

close all
clear


%% Load baseline model


load mat/create_model.mat m

m0 = m;
checkSteady(m0);
m0 = solve(m0);


%% Create a new model with lower TOT in primary sector

% m1 = m0;
% m1.rho_Pq_Pw = 0;
% m1.ss_Pq_Pw = m1.ss_Pq_Pw * 0.90;
% 
% m1 = steady( ...
%     m1 ...
%     , "fixLevel", ["A", "Pw_star", "Pc"] ...
%     , "blocks", true ...
%     , "exogenize", "Zref_Z" ...
%     , "endogenize", "ss_Zref_A" ...
%     , "solver", {@auto, "stepTolerance", Inf} ...
% );
% checkSteady(m1);
% m1 = solve(m1);
% 

m2 = alter(m0, 2);
m2.xi_Z = [0, 0.3];
m2.rho_Pq_Pw = 0;
m2.ss_Pq_Pw = m2.ss_Pq_Pw * 0.90;
m2 = steady( ...
    m2 ...
    , "fixLevel", ["A", "Pw_star", "Pc"] ...
    , "blocks", true ...
    , "solver", {@auto, "stepTolerance", Inf} ...
);
checkSteady(m2);
m2 = solve(m2);

t1 = table( ...
    [m0, m2] ...
    , ["steady-level", "compare-steady-level", "form", "description"] ...
    , "writeTable", "tables/comparative-primary-tot.xlsx" ...
    , "round", 8 ...
);

disp(t1);


%% Prepare initial databank for simulation

T = 40;
d = databank.forModel(m0, 1:T);


%% Simulate model with higher productivity

% d1 = d;
% s1 = simulate( ...
%     m1, d1, 1:T ...
%     , "prependInput", true ...
%     , "method", "stacked" ...
% );

d2 = d;
s2 = simulate( ...
    m2, d2, 1:T ...
    , "prependInput", true ...
    , "method", "stacked" ...
);


%% Create simulation minus control databanks

%smc1 = databank.minusControl(m1, s1, d);
smc2 = databank.minusControl(m2, s2, d);


%% Chart results

ch = databank.Chartpack();
ch.Range = 0:T;
ch.PlotSettings = {"marker", "s"};
ch.Round = 8;
ch.AxesSettings = {"fontSize", 20};

ch + ["Pq_Pw", "Z", "Zref", "Copt", "Chtm", "Id", "Kd", "Iz", "Kz"];
ch + ["S", "dPc", "Rg", "W/Pc", "RER"];
ch + ["NIP_NGDP", "^CA_NGDP", "^TB_NGDP", "GAMMA_Md", "TFwh_NGDP", "Nd"];
ch + ["GAMMA_Md", "GAMMA_Mz"];

chartDb = databank.merge("horzcat", smc2);
draw(ch, chartDb);

h = visual.hlegend( ...
    "bottom" ...
    , "xi_Z = 0" ...
    , "xi_Z = 0.30" ...
);

set(h, fontSize=20);


