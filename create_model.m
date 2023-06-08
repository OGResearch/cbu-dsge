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
m.ss_Pj0_Pw = 1;
m.ss_At = 0.1;

% Transitory parameters

m.rho_Pw_star = 0.3;
m.rho_At =  0.5;


% __Local (D)__

% Steady-state parameters

m.ss_dA = 1.04;
m.ss_dPc = 1.05;
m.beta = 0.95; 


% Households

m.chi_C = 0;
m.chi_DLI = 0.50;
m.nu = 0;0.20;
m.nu0 = NaN;

m.delta_Kd = 0.15;
m.delta_Kh = 0.15;
m.omega = 0.30;

% Markups
m.mu_CI = 1.25; % to be reverse-engineered 
m.mu_D3 = 1; % to be reverse-engineered 

% Local production
m.gamma_Md = 0.40; 0.3792; 0.30; % to be reverse-engineered 
m.gamma_Nd = 0.50; % to be reverse-engineered 
m.ss_N0d_Nd = 0.35;

% Interest rate premia
m.zeta_Rg0 = 0; % to be reverse-engineered 
m.zeta_Rg1 = 0.10; 0.015;
m.zeta_Rh0 = 0.05; % to be reverse-engineered 
m.zeta_Rh1 = 0.05;0.1;0.2;

m.zeta_S = 0.5;

% Directly calibrated ratios and rates

% Residential investment
m.ss_Kh_Kd = 0.30; % to be reverse-engineered 
m.lambda_Ih1 = 0.05;

% Steady state for exogenous variables
m.ss_Ad = 1;

% Transitory parameters

% Autoregressive coefficients
m.rho_A = 0;
m.rho_Ad = 0.5;

m.rho_GAMMA = 0.75;

m.xi_Id = 1;
m.xi_Iz = 1;
m.xi_Pc = 2.5;
m.xi_Pi = 2.5;


% __Primary export sector (Q)__

% Steady State for Exogenous/External/Policy Variables
m.ss_Aq = 1;
m.ss_Pq_Pw = 1;
m.ss_Pmq_Pw = 1;
m.gamma_Mq = 0.25; % % gives PmqMq_NGDP = 0.02; if non-primary exporters disabled, use m.gamma_Mq = 0.29 in read_model

% Autoregression Parameters
m.rho_Aq = 0.5;
m.rho_Pq_Pw = 0.5;


% __Energy sector (J)__
m.gamma_J = 0.07; % to be reverse-engineered 
m.gamma_Mj = 0.2; % gives PmjMj_NGDP = 0.02
m.gamma_TFjw = 0.25; %gives TFjw_NGDP = 0.02
m.lambda_Pj0 = 1;


% __Nonprimary export (Z)__

% Steady-state parameters

% Non-Primary Exports
m.mu_Z = 1; % to be reverse-engineered 
m.gamma_Kz = 0.2;
m.gamma_Mz = 0.40;
m.gamma_Nz = 0.45;
m.delta_Kz = 0.15;
m.ss_N0z_Nz = 0.30;

% Steady state for exogenous/external variables
m.ss_Az = 1;
m.ss_Pmz_Pw = 1;
m.ss_Pz_Pw = 1;
m.ss_Zref_A = 1;
m.Az1 = 1;

% Dynamic adjustment parameters

m.rho_Zref = 0.5;
m.lambda_Kz = 0.5;
m.rho_Az = 0.5;
m.xi_Z = 0.2;


% __Monetary policy__

m.rho_Rg = 0.5;
m.kappa_dPc = 3;
m.kappa_dS = 0;1;


% __Fiscal__

% Steady-state parameters

% Government debt
m.ss_Bg_NGDP = 0.28;
m.ss_Bgw_Bg  = 25/28;
m.theta_Bg = 0.2;

% Government transfers to households
m.ss_TFgh_NGDP = 0.05;
m.ss_TFgj_NGDP = 0.025;

% Government consumption
m.ss_PcG_NGDP = 0.16;
m.ss_WNg_NGDP = 0.10;

% Government investment
m.ss_PiIg_NGDP = 0.08;
m.delta_Kg = 0.10;
m.ss_Kg_A = 1;

m.iota_Kg = 0.5;
m.iota_TFgd = 0.5;
m.iota_TFgz = 0.5;

% Public investment fund
m.ss_Bwf_NGDP = 0.10;

% Tax rates
m.ss_TRvat = 0; % to be reverse-engineered 
m.ss_TRlit = 0.03;
m.ss_TRgd = 0;
m.ss_TRgz = 0;
m.ss_TRj = 0;
m.ss_TRq = 0;

m.ss_TAXls_NGDP = 0; %%%0.05; % to be reverse-engineered

% Dynamic parameters

m.lambda_Gg1 = 0.5;%0.1;
m.lambda_Gg2 = 0.5; 

m.lambda_Ng1 = 0.2;%0.1;
m.lambda_Ng2 = 0.5; 

m.lambda_Ig1 = 1.5;%0.5; 

m.rho_Bg_NGDP_tar = 0.5;
m.lambda_Bgw = 0.1;
m.lambda_Bwf = 0.05; 
m.lambda_BCBg = 0.5;

m.rho_TAXls = 0.5;


% __Labor__

m.rho_W = 0.4;


%% Calculate steady state for initial parameters

% Fix unit root processes

m.A = 1;
m.Pw_star = 1;
m.Pc = 1;

m.gamma_Mz = 0.3;
m.gamma_Nz = 0.40;
m.ss_Az = 1.5;
m.ss_Pz_Pw = 1.5;

m.J = 0.20;
m.Mj = 0.20;
m.Ad2 = 1;



swap = string.empty(0, 2);

m.Zref_Z = 1;
swap = [swap; "Zref_Z", "ss_Zref_A"];

m.Copt_Vopt_nu0 = 0;
swap = [swap; "Copt_Vopt_nu0", "nu0"];

m = steady( ...
    m ...
    , "fixLevel", ["A", "Pw_star", "Pc"] ...
    , "blocks", true ...
    , "exogenize", swap(:, 1) ...
    , "endogenize", swap(:, 2) ...
);

checkSteady(m, "equationSwitch", "steady");
m = solve(m);

%save mat/create_model.mat m

%% Reverse engineer parameters for steady-state ratios

% Net investment position
m.NIP_NGDP = -0.30;
swap = [swap; "NIP_NGDP", "zeta_Rg0"];

% Public infrastructure expenditures
m.PiIg_NGDP = 0.03;
swap = [swap; "PiIg_NGDP", "ss_Kg_A"];

% Primary export to GDP
m.PqQ_NGDP = 0.08;
swap = [swap; "PqQ_NGDP", "ss_Aq"];

% Energy cost base
m.VAj_NGDP = 0.08;
swap = [swap; "VAj_NGDP", "gamma_J"];

% Energy sector tax
m.TAXj_NGDP = 0.03;
swap = [swap; "TAXj_NGDP", "ss_TRj"];

% Primary export sector
m.TAXq_NGDP = 0.04;
swap = [swap; "TAXq_NGDP", "ss_TRq"];

% Value added tax
m.TAXvat_NGDP = 0.07;
swap = [swap; "TAXvat_NGDP", "ss_TRvat"];

% Labor income tax
m.TAXlit_NGDP = 0.03;
swap = [swap; "TAXlit_NGDP", "ss_TRlit"];

% Subsidies for local supply capacity (SOE...)
m.TFgd_NGDP = 0.01;
swap = [swap; "TFgd_NGDP", "ss_TRgd"];

m.TFwh_NGDP = 0.12;
swap = [swap; "TFwh_NGDP", "ss_At"];


%% Calibrate steady state

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
    , "solver", {"qnsd", "stepTolerance", Inf} ...
);

checkSteady(m);

% m1 = m;
% m1.PIEd3_NGDP = 0;
% 
% m1 = steady( ...
%     m1 ...
%     , "fixLevel", ["A", "Pw_star", "Pc"] ...
%     , "exogenize", "PIEd3_NGDP" ...
%     , "endogenize", "mu_D3" ...
% );
% 
% return

steadyTable = table( ...
    m, ["steady-level", "description"] ...
    , "writeTable", "tables/steady-state-baseline.xlsx" ...
);

disp(steadyTable)

m = solve(m);

disp("==> Writing model to mat file")
save mat/create_model.mat m


%% Calibration table with key ratios and rates

nationalList = [
    "PcC_NGDP"
    "PiI_NGDP"
    "PgG_NGDP"
    "PxX_NGDP"
    "PzZ_NGDP"
    "PmM_NGDP"
    "PiIg_NGDP"
    "WN_NGDP"
    "Nz_N"
    "Ng_N"
    "Rg"
    "Rh"
    "Rg_star"
    "NIP_NGDP"
    "INTw_NGDP"
    "CA_NGDP"
    "TB_NGDP"
];

fiscalList = [
    "Bg_NGDP"
    "Bgw_Bg"
    "TAX_NGDP"
];

nationalTable = steadyTable(nationalList, :);
fiscalTable = steadyTable(fiscalList, :);

writetable(nationalTable, "tables/calibration-national.xlsx", "writeRowNames", true);
writetable(fiscalTable, "tables/calibration-fiscal.xlsx", "writeRowNames", true);

disp(nationalTable)
disp(fiscalTable)


