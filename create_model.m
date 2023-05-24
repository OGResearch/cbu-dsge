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
    ... "model-source/processing.model"
    "model-source/nonprimary.model"
    "model-source/foreign.model"
    "model-source/labor.model"
];

m = Model.fromFile( ...
    modelFiles ...
    , "growth", true ...
    , "assign", struct("LongCobbDouglas", true) ...
);


%% Assign generic calibration


% __Foreign__

% Steady-state parameters

m.ss_Rw_star  = 1.030;
m.ss_dPw_star = 1.025;
m.ss_BWjz_NGDP = 0;

% Transitory parameters

m.rho_Pw_star = 0.3;


% __Local__

% Households
m.beta = 0.97; 
m.chi_dli = 0.20;
m.chi_c = 0.3;
m.nu = 0.05;
m.nu0 = 0; % to be reverse-engineered
m.delta_Ky = 0.20;
m.delta_Kh = 0.20;
m.omega = 0.30;

m.ss_TFw_WNhtm = 0.36; % to be reverse engineered

% Markups
m.mu_CI = 1.25; % to be reverse-engineered 
m.mu_Y2 = 1; % to be reverse-engineered 

% Local production
m.gamma_My = 0.3792; 0.30; % to be reverse-engineered 
m.gamma_Ny = 0.37; % to be reverse-engineered 
m.ss_N0y = 0.65; % to be reverse-engineered 

% Interest rate premia
m.zeta_Rg0 = 0.88; % to be reverse-engineered 
m.zeta_Rg1 = 0.015;
m.zeta_Rh0 = 0.0; % to be reverse-engineered 
m.zeta_Rh1 = 0.1;0.2;

% Directly calibrated ratios and rates

% Residential investment
m.ss_Kh_Ky = 0.30; % to be reverse-engineered 
m.lambda_Ih1 = 0.05;

% Steady state for exogenous variables
m.ss_dA = 1.02;
m.ss_dPc = 1.025;
m.ss_Ay = 1;
m.ss_S = 1;

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


% __Primary__

% Steady State for Exogenous/External/Policy Variables
m.ss_Aq         = 1;
m.ss_Pq_Pw      = 1;
m.ss_Pmq_Pw     = 1;
m.gamma_Mq      = 0.15; % if non-primary exporters disabled, use m.gamma_Mq  = 0.29 in read_model
m.ss_TRwf       = 0.5;
m.ss_TFq_PqQ    = 0.05;
m.gamma_Qy      = 0.07;

% Autoregression Parameters
m.rho_Aq    = 0.5;
m.rho_Pq_Pw = 0.5;


% __Non-primary__

% Steady-state parameters

% Non-Primary Exports
m.mu_Z = 1; % to be reverse-engineered 
m.gamma_Kz = 0.2;
m.gamma_Mz = 0.45; %0.45/(0.45+0.1388);0.45;
m.gamma_Nz = 0.40;0.29;
m.gamma_Iz = 0.70; %Import content of capital ussed in the production
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

m.ss_Zref_Az = 1;

% Transitory parameters

% Autoregressive Coefficients
m.rho_Az = 0.5;
m.lambda_Kz = 0.5;
m.lambda_Zref = 0.7;

% Adjustment Costs
m.xi_NNz = 0;
m.xi_Z = 0.3;

% Ownership of NP exporters. Note: local HH could also hold equity, i.e.
% psi_zw + psi_zg do not need to sum up to 1
m.psi_zw = 0; % share of foreign-owned equity in nonprimary export sectors
m.psi_zg = 0; % share of PIF-owned equity nonprimary export sectors


% __Processing__

% Steady-state parameters

% Non-oil primary exports
% m.gamma_Kj = 0.95;
% m.gamma_Qj = 0.6154; % reverse-engineered
% m.gamma_Ij = 0.70; %Import content of capital used in the production
% m.delta_Kj = 0.20;

% Steady state for exogenous/external variables
% m.ss_mu_J = 1;
% m.ss_Aj = 1;
% m.ss_Kj_A = 0.22; % to be reverse-engineered 

% m.ss_Pmj_Pmy = 1;

% Transitory parameters

% Autoregressive parameters
% m.rho_Aj = 0.5;
% m.rho_Kj = 0.8;

%ownership of NP exporters. Note: local HH could also hold equity, i.e.
%psi_jw&psi_jg doesn't necessery sum up to 1
% m.psi_jw = m.psi_zw; % share of foreign owned equity at NP exporters
% m.psi_jg = m.psi_zg; % share of PIF owned equity at NP exporters


% __Public__

% Steady-state parameters

% Central bank
m.ss_BCBg_NGDP = 0; %%%0.15;
m.ss_BWcbX_NGDP = 0; %%%0.35;

% Government debt
m.ss_BG_NGDP = 0; %%%0.2; 
m.ss_BGw_BG = 0; %%%0.5;

% Transfers
m.ss_TFh_NGDP = 0; %%%0.01;
m.ss_TFhtm_TFh = 0; %%%0.65;

% Government consumption
m.ss_PcG_NGDP = 0.24;
m.ss_WNg_NGDP = 0.16;
m.ss_Wg_Wopt = 1.50;

% Government investment
m.ss_PiIg_NGDP = 0.08;

% Public investment fund
m.ss_BWpif_NGDP = 0; %%%0.05;

% Tax rates
m.ss_TRvat = 0; % to be reverse-engineered 
m.ss_TRinp = 0; % to be reverse-engineered 
m.ss_TRexp = 0; % to be reverse-engineered 
% m.ss_TRwf = 0; % defined in Primary sector

m.ss_TXls_NGDP = 0; %%%0.05; % to be reverse-engineered

% Dynamic parameters

m.lambda_Gg1 = 0.5;%0.1;
m.lambda_Gg2 = 0.5; 

m.lambda_Ng1 = 0.2;%0.1;
m.lambda_Ng2 = 0.5; 

m.lambda_TXls1 = 0.5;
m.lambda_TXls2 = 0.5;

m.lambda_Ig1 = 1.5;%0.5; 

m.lambda_TFopt = 0.6;
m.lambda_BG_NGDP_tar = 0.93;
m.lambda_BWpif = 0.05; 
m.lambda_BWjz = 0.05;
m.lambda_BGw = 1; 
m.lambda_BCBg = 0.5;


% __Labor__

% Steady state parameters

m.ss_Whtm_Wopt = 1; %%% 0.45;

m.eta = 0;
m.upsilon_Y = 0.9;
m.upsilon_Z = 0.9;

% Dynamic parameters

m.rho_Wopt = 0.3;
m.rho_Whtm = 0.3;



%% Calculate generic steady state

m.A = 1 + 1i*m.ss_dA;
m.Pw_star = 1 + 1i*m.ss_dPw_star;
m.S = m.ss_S + 1i;

m.Ky = 5;

m = steady( ...
    m ...
    , "fixLevel", ["A", "Pw_star", "S"] ...
    , "blocks", true ...
);



checkSteady(m);
m = solve(m);

return

%% Exogenize some steady state values to reverse engineer respective parameters

% Define baseline steady-state properties
SS = struct();

% National accounts
SS.PcC_NGDP    = 0.42; % Private consumption share to GDP based on National Accounts data
SS.PiIh_NGDP   = 0.04; % Private investment to real estate based on National Accounts data
SS.PxX_NGDP    = 0.35; % Export share to GDP based on National Accounts data
SS.PjJ_NGDP    = 0.065; % Size of petro chemical sector, based on trade statistics (w/o oil and natural resources related)
SS.PzZ_NGDP    = 0.04; % Size of non-primary sector, based on trade statistics (w/o oil and natural resources related)

SS.VAq_NGDP    = 0.285; % Value added of sector to GDP ratio based on NA statistics 
SS.VAj_NGDP    = 0.025; % Value added of non-oil primary sector to GDP ratio, assumption

% BoP
SS.TFw_NGDP    = 0.05; % Remittance to GDP, based on BOP data

% Production parameters
SS.Qy_Q        = 0.15; % Locally consumed oil to total oil production 
m.gamma_Qy     = 0.07; % Share of primary inputs used in local production sectors; (1 - m.gamma_Qy) is a share of local labor, capital and imports. 
m.ss_TFq_PqQ   = 0.05; % Transfers to households from primary producers' revenues

m.gamma_Nz     = 0.40; % Labor intensity of Z sector (Y-3 production stage)
m.gamma_Mz     = 0.45; % Import intensity of Z sector (Y-2 production stage)

% Fiscal data
SS.TXexp_NGDP  = 0.008; % Expat levy to GDP based on fiscal data
SS.TXinp_NGDP  = 0.035 - SS.TXexp_NGDP; % Input(excise +import) tax to GDP based on 2019 budget
SS.TXvat_NGDP  = 0.015; % Tax revenues from VAT to GDP based on 2019 budget
SS.REV_NGDP    = 0.328; % Revenue to GDP based on 2019 budget
m.ss_TRwf      = 0.5;   % Fiscal revenues from primary producers' VA
m.ss_TFh_NGDP  = 0.01;  % Transfers and subsidies to households
m.ss_TFhtm_TFh = 0.65;  % Share of transfers and subsidies to HTM households

m.ss_PcG_NGDP   = 0.24; % Public consumtion to GDP 
m.ss_PiIg_NGDP  = 0.08; % Public non-financial investment to GDP 

m.ss_WNg_NGDP   = 0.16; % Public sector wage bill to GDP
m.ss_Wg_Wopt    = 1.50; % Public sector wages to private sector OPT wages

m.ss_BG_NGDP    = 0.2;  % Total public gross debt
m.ss_BGw_BG     = 0.5;  % Share of external debt in Total public gross debt
m.ss_BCBg_NGDP  = 0.15; % Gvmt reserve at SAMA
m.ss_BWcbX_NGDP = 0.35; % SAMA FX met reserves (w/o Gvmt reserve)
m.ss_BWpif_NGDP = 0.05; % PIF external assets to GDP


% Financial markets
SS.BWh_NGDP     = 0.10;  % Household foreign investment position based on end-2018 data 
SS.Rg_Rw        = 1.005; % Risk premium based on current interest rate differential vs U.S.
m.ss_BWjz_NGDP  = 0;  % Foreign fund of retained earnings from jz sectors

% Labor market
SS.Nhtm_Np     = 0.8;   % Share of expats in total employment, based on GOSI and GASTAT 
SS.WNz_VAz     = 0.497; % Assuming larger wage bill to VA then in local sector.
SS.N0z_Nz      = 0.5;   % Assumption about overhead labor to total labor in Non-primary production, assuming lower share then in local
m.ss_Whtm_Wopt = 0.45;  % Share of HTM vs. OPT wages in private sector 

% Technical assumptions
SS.Copt_Vh_nu0 = 0; % Set intercept to zero by default
SS.PSIy        = 1.07; % Profit Margins in Local Production assumed at 10%
SS.VAj_PkjKj   = 1/3; % Implicitly provides profil level PIEj
SS.VAz_PkzKz   = 1/1.75; % Implicitly provides profil level PIEz



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
    "PcC_NGDP"       "gamma_Ny"
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
    "PcGg_NGDP"
    "PcC_NGDP"
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

