% v2019-02-21
% define a 6D particle beam, with units
% B(:,1)    B(:,2)   B(:,3)   B(:,4)      B(:,5)      B(:,6)
% [x [m]    y [m]    z [m]    x' [rad]    y' [rad]    Ek [eV] ]; 
% all units are SI, except energy, which is in eV

%
% beam parameters
%
% protons 
SI_e = 1.60217662e-19;
SI_c = 299792458;
q = +SI_e; % C - proton charge
N_Q = 2e10; % # of REAL particles
Q = q*N_Q; % C
E0 = 938.27e6; % eV - protons mass
m0 = E0/2.998e8^2*1.602e-19; % kg - rest mass
Ek0 = 10.0e9; % eV
gamma = (E0+Ek0)/E0; % Lorentz factor
sigma_E_E = 0.001; % percent/100 - relative energy spread (dEk/Ek)
em_n_x = 1.0e-6; % m, emittance NORMALIZED to energy
em_n_y = 1.0e-6; % m, emittance NORMALIZED to energy
sigma_x = 3.855e-3; % m - set to give matched beta for FODO cell
sigma_y = 3.855e-3; % m - set to give matched beta for FODO cell
sigma_z = 5e-3; % m
% Initial Twiss parameters
alpha_x = 0; % the horizontal phase a is at a waist 
beta_x = sigma_x^2/em_n_x*gamma;
gamma_x = (1+alpha_x^2)/beta_x;
%
alpha_y = 1; % the vertical phase space is converging 
beta_y = sigma_y^2/em_n_y*gamma;
gamma_y = (1+alpha_y^2)/beta_y;

%
% define the beam distribution, one dimension at the time
%
N = 100000; % number of simulated MACRO particles
% x-x'
em_rms_x = em_n_x/gamma; % use GEOMETRIC emittance in distribution
MU_x = [0 0];
SIGMA_x = em_rms_x*[beta_x  -alpha_x; -alpha_x gamma_x];
B_x = mvnrnd(MU_x, SIGMA_x, N); % sample particles from a multi-variable Gaussian (requires statistics toolbol)
% y-y'
em_rms_y = em_n_y/gamma; % use GEOMETRIC emittance in distribution
MU_y = [0 0];
SIGMA_y = em_rms_y*[beta_y  -alpha_y; -alpha_y gamma_y];
B_y = mvnrnd(MU_y, SIGMA_y, N); % sample particles from a multi-variable Gaussian (requires statistics toolbox)
% z-E
z = sigma_z*randn(N, 1);
Ek = Ek0*(1 + sigma_E_E*randn(N, 1));
B_z = [z Ek];  % assume z uncorrelated with E

%
% compose total Nx6 beam matrix
%
B = [B_x(:,1)  B_y(:,1)  B_z(:,1)  B_x(:,2)  B_y(:,2)  B_z(:,2)]; % assumes no correlaton between the three planes
%
% B is now your Nx6 dimensional matrix containing all the information about the beam, except the total charge
%
