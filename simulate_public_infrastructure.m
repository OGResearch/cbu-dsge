

close all
clear

load mat/create_model.mat m

m = alter(m, 2);
m.nu = [0, 0.10];

m = steady( ...
    m ...
    , "fixLevel", ["A", "Pw_star", "Pc"] ...
    , "blocks", true ...
    , "solver", {@auto, "stepTolerance", Inf} ...
);
checkSteady(m);
m = solve(m);

m1 = m;
m1.ss_Bg_NGDP = m1.ss_Bg_NGDP + 0.20;
m1.ss_Kg_A = m1.ss_Kg_A * 1.10;

m1.lambda_Ng1 = 2;
m1.lambda_Ng2 = 0.5;

m1 = steady( ...
    m1 ...
    , "fixLevel", ["A", "Pw_star", "Pc"] ...
    , "blocks", true ...
    , "solver", {@auto, "stepTolerance", Inf} ...
);
checkSteady(m1);
m1 = solve(m1);

d = databank.forModel(m, 1:40);
s = simulate( ...
    m1, d, 1:40 ...
    , "prependInput", true ...
    , "method", "stacked" ...
);

smc = databank.minusControl(m, s, d, "range", 0:40);


%% Plot results

close all

ch = databank.Chartpack();
ch.Range = 0:40;
ch.PlotSettings = {"marker", "s"};
ch.Round = 8;
ch.AxesSettings = {"fontSize", 20};

ch + ["Kg", "Ig", "Bg_NGDP", "Ng"];
ch + ["C", "Copt", "Chtm", "Id", "Kd", "Iz", "Kz"];
ch + ["dPc", "Rg", "S", "W/Pc", "W*N/Pc"];

draw(ch, smc);

