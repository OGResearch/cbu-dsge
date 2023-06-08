% Simulate fiscal expansion

close all
clear

load mat/create_model.mat m

m1 = alter(m, 2);
m1.nu = [0, 0.1];
m1.chi_DLI = [0.5];
m1.omega = [0.3];

m1.lambda_Gg1 = 5;
m1.lambda_Gg2 = 0.3;

m1.lambda_Ng1 = 5;
m1.lambda_Ng2 = 0.3;

m1 = steady( ...
    m1 ...
    , "fixLevel", ["A", "Pw_star", "Pc"] ...
    , "blocks", true ...
);

checkSteady(m1);
m1 = solve(m1);

m2 = m1;
m2.ss_Bg_NGDP = real(m2.ss_Bg_NGDP) + 0.20;

m2 = steady( ...
    m2 ...
    , "fixLevel", ["A", "Pw_star", "Pc"] ...
    , "blocks", true ...
);

checkSteady(m2);
m2 = solve(m2);


%% Comaparative static

t = table( ...
    [m1(1), m2(1)], ["steady-level", "compare-steady-level", "form", "description"] ...
    , "writeTable", "tables/fiscal-expansion.xlsx" ...
    , "round", 8 ...
);

t(["Copt", "Kd"], :)


%% Dynamic simulation

d = databank.forModel(m1, 1:40);
s = simulate( ...
    m2, d, 1:40 ...
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

ch + ["Gg", "Ng", "Bg_NGDP", "DEF_NGDP"];
ch + ["C", "Copt", "Chtm", "Id", "Kd", "Iz", "Kz"];
ch + ["dPc", "Rg", "S", "W/Pc", "W*N/Pc"];

draw(ch, smc);





