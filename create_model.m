%% Read model with primary and non-primary exports


%% Clear workspace

close all
clear


%% Create model from model equations

modelFiles = [
    "model-source/master.model"
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


%% Assign generic calibration


% __Foreign__

% Steady-state parameters

m.ss_Rw_star = 1.030;
m.ss_dPw_star = 1.025;
m.ss_BWjz_NGDP = 0;
m.ss_Pj_Pw = 1;

% Transitory parameters

m.rho_Pw_star = 0.3;


% __Local__

% Steady-state parameters

m.beta = 0.97; 
m.delta_Ky = 0.20;
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

m.ss_TFwh_NGDP = 0.05; % to be reverse engineered

% Markups
m.mu_CI = 1.25; % to be reverse-engineered 
m.mu_Y2 = 1; % to be reverse-engineered 

% Local production
m.gamma_My = 0.3792; 0.30; % to be reverse-engineered 
m.gamma_Ny = 0.37; % to be reverse-engineered 
m.ss_N0y = 0.65; % to be reverse-engineered 

% Interest rate premia
m.zeta_Rg0 = 0; % to be reverse-engineered 
m.zeta_Rg1 = 0.10; 0.015;
m.zeta_Rh0 = 0; % to be reverse-engineered 
m.zeta_Rh1 = 0.1;0.2;

m.sigma = 0.7;

% Directly calibrated ratios and rates

% Residential investment
m.ss_Kh_Ky = 0.30; % to be reverse-engineered 
m.lambda_Ih1 = 0.05;

% Steady state for exogenous variables
m.ss_dA = 1.02;
m.ss_dPc = 1.04;
m.ss_Ay = 1;

% Transitory parameters

% Autoregressive coefficients
m.rho_A = 0;
m.rho_Ay = 0.5;

m.rho_My_Y2 = 0.75;
m.rho_Y3_Y2 = 0.75;

% Habit, adjustment costs
m.phi_Y = 1;

m.xi_Iy = 3;
m.xi_Pc = 2.5; %1
m.xi_Pi = 2.5; %0.5
m.xi_NNy = 0;


% __Primary export sector (Q)__

% Steady State for Exogenous/External/Policy Variables
m.ss_Aq = 1;
m.ss_Pq_Pw = 1;
m.ss_Pmq_Pw = 1;
m.gamma_Mq = 0.25; % if non-primary exporters disabled, use m.gamma_Mq = 0.29 in read_model
m.gamma_J = 0.07;

% Autoregression Parameters
m.rho_Aq = 0.5;
m.rho_Pq_Pw = 0.5;


% __Local energy sector (J)__

m.lambda_Pj = 1;


% __Non-primary__

% Steady-state parameters

% Non-Primary Exports
m.mu_Z = 1; % to be reverse-engineered 
m.gamma_Kz = 0.2;
m.gamma_Mz = 0.45; %0.45/(0.45+0.1388);0.45;
m.gamma_Nz = 0.40;0.29;
m.gamma_N0z = 0.7;
m.delta_Kz = 0.20;

% Steady State for Exogenous/External Variables
m.ss_Az = 1;
m.ss_Kz_A = 0.12; % to be reverse-engineered 
m.ss_Pmz_Pmy = 1;
m.ss_Pz_Pmz = 1;
m.ss_N0z_Kz = 0.12; % to be reverse-engineered 
m.ss_N0z = 0.3; % to be reverse-engineered 
m.alpha_Z = 1; 0.73; % to be reverse-engineered 

m.ss_Z0_Az = 1;

% Transitory parameters

% Autoregressive Coefficients
m.rho_Az = 0.5;
m.lambda_Kz = 0.5;
m.lambda_Z0 = 0.7;

% Adjustment Costs
m.xi_NNz = 0;
m.xi_Z = 0.3;

% Ownership of NP exporters. Note: local HH could also hold equity, i.e.
% psi_zw + psi_zg do not need to sum up to 1
m.psi_zw = 0; % share of foreign-owned equity in nonprimary export sectors
m.psi_zg = 0; % share of PIF-owned equity nonprimary export sectors

m.psi_jw = 0.25;


% __Monetary policy__

m.rho_Rg = 0.5;
m.kappa_dPc = 3;
m.kappa_dS = 1;


% __Fiscal__

% Steady-state parameters

% Government debt
m.ss_BG_NGDP = 0; %%%0.2; 
m.ss_BGw_BG = 0; %%%0.5;

% Transfers
m.ss_TFh_NGDP = 0; %%%0.01;
m.ss_TFhtm_TFh = 0; %%%0.65;

% Government consumption
m.ss_PcG_NGDP = 0.24;
m.ss_WNg_NGDP = 0.16;
m.ss_Wg_Wopt = 1;

% Government investment
m.ss_PiIg_NGDP = 0.08;
m.delta_Kg = 0.10;
m.ss_Kg_A = 1;
m.iota = 0.1;

% Public investment fund
m.ss_Bwf_NGDP = 0; %%%0.05;

% Tax rates
m.ss_TRvat = 0; % to be reverse-engineered 

m.ss_TXls_NGDP = 0; %%%0.05; % to be reverse-engineered

% Dynamic parameters

m.lambda_Cg1 = 0.5;%0.1;
m.lambda_Cg2 = 0.5; 

m.lambda_Ng1 = 0.2;%0.1;
m.lambda_Ng2 = 0.5; 

m.lambda_TXls1 = 0.5;
m.lambda_TXls2 = 0.5;

m.lambda_Ig1 = 1.5;%0.5; 

m.lambda_TFopt = 0.6;
m.lambda_BG_NGDP_tar = 0.93;
m.lambda_Bwf = 0.05; 
m.lambda_BWjz = 0.05;
m.lambda_BGw = 1; 
m.lambda_BCBg = 0.5;


% __Labor__

% Steady state parameters

m.omega_N = 0.30;
m.omega_TFwh = 0.50;
m.ss_Whtm_Wopt = 1; %%% 0.45;

m.eta = 0;
m.upsilon_Y = 0.9;
m.upsilon_Z = 0.9;

% Dynamic parameters

m.rho_Wopt = 0.4;
m.rho_Whtm = 0.4;



%% Calculate generic steady state

m.A = 1;
m.Pw_star = 1;
m.Pc = 1;


m.A = 0.5;


%m = steady( ...
%    m ...
%    , "fixLevel", ["A", "Pw_star", "Pc"] ...
%    , "blocks", true ...
%);
%
%checkSteady(m);


% Reverse engineer parameters for steady-state ratios

swap = string.empty(0, 2);

% Net investment position
m.NIP_NGDP = -0.40;
swap = [swap; "NIP_NGDP", "zeta_Rg0"];

% Public infrastructure expenditures
m.PiIg_NGDP = 0.08;
swap = [swap; "PiIg_NGDP", "ss_Kg_A"];

% Primary export to GDP
m.PqQ_NGDP = 0.08;
swap = [swap; "PqQ_NGDP", "ss_Aq"];

% Import for primary export
m.PmqMq_NGDP = 0.02;
swap = [swap; "PmqMq_NGDP", "gamma_Mq"];

% Energy volume
m.PjJ_NGDP = 0.04;
swap = [swap; "PjJ_NGDP", "gamma_J"];

% Import for energey sector
m.TXj_NGDP = 0.03;
swap = [swap; "TXj_NGDP", "psi_jw"];


m = steady( ...
    m ...
    , "fixLevel", ["A", "Pw_star", "Pc"] ...
    , "blocks", true ...
    , "exogenize", swap(:, 1) ...
    , "endogenize", swap(:, 2) ...
);

checkSteady(m);


t = table( ...
    m, ["steady-level", "compare-steady-level", "steady-change", "form", "description"] ...
    , "writeTable", "tables/steady-state-baseline.xlsx" ...
);

disp(t)

m = solve(m);

save mat/create_model.mat m










return

%% Exogenize some steady state values to reverse engineer respective parameters

% Define baseline steady-state properties
SS = struct();

% National accounts
SS.PcCh_NGDP = 0.42; % Private consumption share to GDP based on National Accounts data
SS.PiIh_NGDP = 0.04; % Private investment to real estate based on National Accounts data
SS.PxX_NGDP = 0.35; % Export share to GDP based on National Accounts data
SS.PjJ_NGDP = 0.065; % Size of petro chemical sector, based on trade statistics (w/o oil and natural resources related)
SS.PzZ_NGDP = 0.04; % Size of non-primary sector, based on trade statistics (w/o oil and natural resources related)

SS.VAq_NGDP = 0.285; % Value added of sector to GDP ratio based on NA statistics 
SS.VAj_NGDP = 0.025; % Value added of non-oil primary sector to GDP ratio, assumption

% BoP
SS.TFw_NGDP = 0.05; % Remittance to GDP, based on BOP data

% Production parameters
m.gamma_J = 0.07; % Share of primary inputs used in local production sectors; (1 - m.gamma_J) is a share of local labor, capital and imports. 
m.ss_TFq_PqQ = 0.05; % Transfers to households from primary producers' revenues

m.gamma_Nz = 0.40; % Labor intensity of Z sector (Y-3 production stage)
m.gamma_Mz = 0.45; % Import intensity of Z sector (Y-2 production stage)

% Fiscal data
SS.TXexp_NGDP = 0.008; % Expat levy to GDP based on fiscal data
SS.TXinp_NGDP = 0.035 - SS.TXexp_NGDP; % Input(excise +import) tax to GDP based on 2019 budget
SS.TXvat_NGDP = 0.015; % Tax revenues from VAT to GDP based on 2019 budget
SS.REV_NGDP = 0.328; % Revenue to GDP based on 2019 budget
m.ss_TRwf = 0.5;   % Fiscal revenues from primary producers' VA
m.ss_TFh_NGDP = 0.01;  % Transfers and subsidies to households
m.ss_TFhtm_TFh = 0.65;  % Share of transfers and subsidies to HTM households

m.ss_PcG_NGDP = 0.24; % Public consumtion to GDP 
m.ss_PiIg_NGDP = 0.08; % Public non-financial investment to GDP 

m.ss_WNg_NGDP = 0.16; % Public sector wage bill to GDP
m.ss_Wg_Wopt = 1.50; % Public sector wages to private sector OPT wages

m.ss_BG_NGDP = 0.2;  % Total public gross debt
m.ss_BGw_BG = 0.5;  % Share of external debt in Total public gross debt
m.ss_BCBg_NGDP = 0.15; % Gvmt reserve at SAMA
m.ss_BWcbX_NGDP = 0.35; % SAMA FX met reserves (w/o Gvmt reserve)
m.ss_Bwf_NGDP = 0.05; % PIF external assets to GDP


% Financial markets
SS.BWh_NGDP = 0.10;  % Household foreign investment position based on end-2018 data 
SS.Rg_Rw = 1.005; % Risk premium based on current interest rate differential vs U.S.
m.ss_BWjz_NGDP = 0;  % Foreign fund of retained earnings from jz sectors

% Labor market
SS.Nhtm_Np = 0.8;   % Share of expats in total employment, based on GOSI and GASTAT 
SS.WNz_VAz = 0.497; % Assuming larger wage bill to VA then in local sector.
SS.N0z_Nz = 0.5;   % Assumption about overhead labor to total labor in Non-primary production, assuming lower share then in local
m.ss_Whtm_Wopt = 0.45;  % Share of HTM vs. OPT wages in private sector 

% Technical assumptions
SS.Copt_Vh_nu0 = 0; % Set intercept to zero by default
SS.PSIy = 1.07; % Profit Margins in Local Production assumed at 10%
SS.VAj_PkjKj = 1/3; % Implicitly provides profil level PIEj
SS.VAz_PkzKz = 1/1.75; % Implicitly provides profil level PIEz



% Assign SS as initial parametrisation
m = assign(m, SS);


% Tune SS and set which parameter to use
swap = [
    "BWh_NGDP"       "zeta_Rh0"
    "PxX_NGDP"       "gamma_My"
    "PjJ_NGDP"       "ss_Aj"
    "PzZ_NGDP"       "ss_Az"
    "Rg_Rw"          "zeta_Rg0"
    "Copt_Vh_nu0"    "nu0"
    "PSIy"           "mu_Y2"
    "PcCh_NGDP"       "gamma_Ny"
    "PiIh_NGDP"      "ss_Kh_Ky"
    "Qy_Q"           "gamma_Qy"
    "Nhtm_Np"        "ss_N0y"
    "WNz_VAz"        "mu_Z"  
    "N0z_Nz"         "ss_N0z_Kz" 
    "TFw_NGDP"       "ss_TFw_WNhtm"
    "TXexp_NGDP"     "ss_TRexp"
    "TXinp_NGDP"     "ss_TRinp"
    "TXvat_NGDP"     "ss_TRvat"
    "REV_NGDP"       "ss_TXls_NGDP"
    "VAq_NGDP"       "gamma_Mq"
    "VAj_NGDP"       "gamma_Qj"
    "VAj_PkjKj"      "ss_Kj_A"
    "VAz_PkzKz"      "ss_Kz_A"
    ... "WNp_NGDP"       "upsilon_Y" %"mu_CI"
];


%% Second round calibration

steadyOptions = {
    "exogenize", swap(:, 1), ...
    "endogenize", swap(:, 2), ...
    "fix", ["A", "Pw_star", "S"], ...
    "blocks", ~true, ...
};

m = steady(m, steadyOptions{:});

checkSteady(m);


%% Calculate first-order approximate solution matrices

m = solve(m);


%% Save models to mat file

disp("Saving model to MAT/createModel.mat")
save MAT/create_model.mat m


%% Report steady-state table

t = table( ...
    m, ["steadyLevel"] ...
    , "round", 8 ...
    , "writeTable", "Tables/baseline-steady.xlsx" ...
);

rows = [
    "DEF_NGDP"
    "BCBg_NGDP"
    "BG_NGDP"
    "BWh_NGDP"
    "NIP_NGDP"
    "TB_NGDP"
    "TFw_NGDP"
    "TXexp_NGDP"
    "TXinp_NGDP"
    "TXwf_NGDP"
    "TXls_NGDP"
    "TX_NGDP"
    "PIEg_NGDP"
    "TFh_NGDP"
    "PcG_NGDP"
    "PcCg_NGDP"
    "PcCh_NGDP"
    "PiI_NGDP"
    "PizIz_NGDP"
    "PIEz_NGDP"
    "PqQ_NGDP"
    "PzZ_NGDP"
    "PjJ_NGDP"
    "PmzMz_NGDP"
    "PxX_NGDP"
    "PmM_NGDP"
    "WN_NGDP"
    "WNp_NGDP"
    "WNg_NGDP"
    "WNy_VAy"
    "WNz_VAz"
    "Rg"
    "PkzKz_NGDP"
    "VAy_PkyKy"
    "VAz_PkzKz"
    "Ng_N"
    "N0y_Ny"
    "N0z_Nz"
    "Nhtm_N"
    "Whtm_Wopt"
];


disp("=========================================================================");
disp(" Selected steate-state characteristics of the baseline model calibration")
disp("=========================================================================")
disp(" ")

disp(t(rows, :));

