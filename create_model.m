
%% Read model with primary and non-primary exports


%% Clear workspace

close all
clear


%% Create model from model equations

modelFiles = [
    "model-source/clearing.model"
    "model-source/local.model"
    "model-source/fiscal.model"
    "model-source/primary.model"
    "model-source/nonprimary.model"
    "model-source/foreign.model"
    "model-source/labor.model"
    "model-source/energy.model"
];

m = Model.fromFile( ...
    modelFiles ...
    , "growth", true ...
    , "assign", struct("LongCobbDouglas", true) ...
);


list = m{"transition-variables"};
list = list(endsWith(list, "_NGDP"));
status = m{"log-status"};
for n = list
    if status.(n)
        error(n);
    end
end

%% Assign generic calibration


% __Foreign__

% Steady-state parameters

m.ss_RRw_star = 1.01;
m.ss_dPw_star = 1.03;
m.ss_BWjz_NGDP = 0;
m.ss_Pj_Pw = 1;

% Transitory parameters

m.rho_Pw_star = 0.3;


% __Local (D)__

% Steady-state parameters

m.beta = 0.95;
m.delta_Kd = 0.20;
m.delta_Kh = 0.20;


% Households

m.chi_dli = 0.20;
m.chi_c = 0.3;
m.nu = 0.05;
m.nu0 = 0; % to be reverse-engineered


% ----- Temporary -----
m.chi_dli = 0;
m.chi_c = 0.5;
m.nu = 0;



m.ss_TFwh_NGDP = 0.12;

% Markups
m.mu_CI = 1.25; % to be reverse-engineered 
m.mu_D2 = 1; % to be reverse-engineered 

% Local production
m.gamma_Md = 0.45; 0.3792; 0.30; % to be reverse-engineered 
m.gamma_Nd = 0.45; 0.37; % to be reverse-engineered 
%m.ss_N0d = 0.65; % to be reverse-engineered 
m.ss_N0d_Nd = 0.30;

% Interest rate premia
m.zeta_Rg0 = 0; % to be reverse-engineered 
m.zeta_Rg1 = 0.10; 0.015;
m.zeta_Rh0 = 0; % to be reverse-engineered 
m.zeta_Rh1 = 0.1;0.2;

m.zeta_S = 0.5;

% Directly calibrated ratios and rates

% Residential investment
m.ss_Kh_Kd = 0.10; 0.30; % to be reverse-engineered 
m.lambda_Ih1 = 0.05;

% Steady state for exogenous variables
m.ss_dA = 1.04;
m.ss_dPc = 1.05;
m.ss_Ad = 1;

% Transitory parameters

% Autoregressive coefficients
m.rho_A = 0;
m.rho_Ad = 0.5;

m.rho_Md_D2 = 0.75;
m.rho_D3_D2 = 0.75;

% Habit, adjustment costs
m.phi_Y = 1;

m.xi_Id = 3;
m.xi_Pc = 2.5; %1
m.xi_Pi = 2.5; %0.5
m.xi_NNd = 0;


% __Primary export sector (Q)__

% Steady state for exogenous/external/policy variables
m.ss_Aq = 1;
m.ss_Pq_Pw = 1;
m.gamma_Mq = 0.30; 0.25;
m.gamma_J = 0.07;

% Autoregression Parameters
m.rho_Aq = 0.5;
m.rho_Pq_Pw = 0.5;


% __Energy sector (J)__

m.lambda_Pj0 = 0.5;
m.mu_J = 1;


% __Nonprimary export (Z)__

% Steady-state parameters

% Non-Primary Exports
m.mu_Z = 1; % to be reverse-engineered 
m.gamma_Kz = 0.2;
m.gamma_Mz = 0.50;0.40;
m.gamma_Nz = 0.45;
m.gamma_N0z = 0.4;
m.delta_Kz = 0.20;
m.ss_N0z_Nz = 0.30;

% Steady State for Exogenous/External Variables
m.ss_Az = 1;
m.ss_Kz_A = 0.12; % to be reverse-engineered 
m.ss_Pmz_Pmd = 1;
m.ss_Pz_Pmz = 1;
%m.ss_N0z_Kz = 0.12; % to be reverse-engineered 
m.ss_N0z = 0.3; % to be reverse-engineered 
m.alpha_Z = 1; 0.73; % to be reverse-engineered 

m.ss_Z_ref_Az = 1;

% Transitory parameters

% Autoregressive Coefficients
m.rho_Az = 0.5;
m.lambda_Kz = 0.5;
m.lambda_Z_ref = 0.7;

% Adjustment Costs
m.xi_NNz = 0;
m.xi_Z = 0.3;

m.psi_jw = 0;
m.psi_qw = 0;


% __Monetary policy__

m.rho_Rg = 0.5;
m.kappa_dPc = 3;
m.kappa_dS = 1;


% __Fiscal__

% Steady-state parameters

% Government debt
m.ss_Bg_NGDP = 0.40;
m.ss_Bgw_Bg = 0.85;

% Government transfers to households
m.ss_TFgh_NGDP = 0.05;

% Government consumption
m.ss_PcG_NGDP = 0.26;
m.ss_WNg_NGDP = 0.10;

m.omega = 0.30;

% Government investment
m.ss_PiIg_NGDP = 0.08;
m.delta_Kg = 0.10;
m.ss_Kg_A = 1;

m.iota_kg = 0.1;
m.iota_tf = 0.5;

% Public investment fund
m.ss_Bwf_NGDP = 0.10;

% Tax rates
m.ss_TRvat = 0; % to be reverse-engineered 
m.ss_TRlit = 0.03;

m.ss_TRgd = 0;

% Dynamic parameters

m.lambda_Gg1 = 0.5;%0.1;
m.lambda_Gg2 = 0.5; 

m.lambda_Ng1 = 0.2;%0.1;
m.lambda_Ng2 = 0.5; 

m.lambda_Ig1 = 1.5;%0.5; 

m.lambda_Bg_NGDP_tar = 0.93;
m.lambda_Bwf = 0.05; 
m.lambda_BWjz = 0.05;
m.lambda_BCBg = 0.5;


% __Labor__

% Dynamic parameters

m.rho_W = 0.4;



%% Calculate steady state for initial parameters

% Fix unit root processes

m.A = 1;
m.Pw_star = 1;
m.Pc = 1;

m = steady( ...
    m ...
    , "fixLevel", ["A", "Pw_star", "Pc"] ...
    , "blocks", true ...
);

checkSteady(m);
m = solve(m)

save mat/create_model.mat m
return


%% Directly calibrate Uzbeksitan steady state

m.ss_TFwh_NGDP = 0.12;


%% Reverse engineer Uzbekistan steady state

swap = string.empty(0, 2);

% Net investment position
m.NIP_NGDP = -0.40;
swap = [swap; "NIP_NGDP", "zeta_Rg0"];

% Public infrastructure expenditures
m.PiIg_NGDP = 0.20;
swap = [swap; "PiIg_NGDP", "ss_Kg_A"];

% Primary export to GDP
m.PqQ_NGDP = 0.08;
swap = [swap; "PqQ_NGDP", "ss_Aq"];

% Energy volume
m.PjJ_NGDP = 0.04;
swap = [swap; "PjJ_NGDP", "gamma_J"];

% Import for energy sector
m.TAXj_NGDP = 0.03;
swap = [swap; "TAXj_NGDP", "psi_jw"];

% Value added tax
m.TAXvat_NGDP = 0.07;
swap = [swap; "TAXvat_NGDP", "ss_TRvat"];

% Labor income tax
m.TAXlit_NGDP = 0.03;
swap = [swap; "TAXlit_NGDP", "ss_TRlit"];

% Subsidies for local supply capacity (SOE...)
m.TFgd_NGDP = 0.01;
swap = [swap; "TFgd_NGDP", "ss_TRgd"];


% Fix unit root processes

m.A = 1;
m.Pw_star = 1;
m.Pc = 1;

m = steady( ...
    m ...
    , "fixLevel", ["A", "Pw_star", "Pc"] ...
    , "blocks", true ...
    , "exogenize", swap(:, 1) ...
    , "endogenize", swap(:, 2) ...
);

checkSteady(m);


t = table( ...
    m, ["steady-level", "steady-change", "form", "description"] ...
    , "writeTable", "tables/steady-state-baseline.xlsx" ...
);

disp(t)

m = solve(m);

save mat/create_model.mat m

