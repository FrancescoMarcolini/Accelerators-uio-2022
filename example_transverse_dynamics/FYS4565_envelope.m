% v2019-02-21
clear all;
clf;

%
FYS4565_define_beam % load beam
FYS4565_define_FODO % define characteristics of the FODO lattice

%
% Solve envelope equation
%
s_range = [0 L_FODO*Nquad/2]; % m - range of 
sigma_init = [sqrt(em_rms_x*beta_F); 0]; % inital conditions for envelope equation (rms beam size)
ode_ops = odeset('MaxStep',1e-1); % put to 1e-2 for better accuracy, 1e-0 for faster solving
[s,sigma] = ode45(@(s,sigma) f_envelope(s, sigma, em_rms_x), s_range, sigma_init, ode_ops); % numerically solve the ODE 

%
% Plot
%
N_sigma = 3; % plot the 3-sigma beam envelope
plot(s, 3*sigma(:,1)*1e3, '-.b');
hold on;
plot(s, -3*sigma(:,1)*1e3, '-.b');
hold off;
xlabel('s [m]');
ylabel('3\sigma [mm]') 
title('3\sigma beam envelope');
%



%
% envelope equation ODE - with K(s)
% this equation is called by 'ode45' for each time step
% 
function dsigma_ds = f_envelope(s, sigma, emitt)
global L_FODO phi f beta_F lquad Nquad;

% first quads
K = 0; % default - no focusing fields
llim =  0;
hlim = lquad/2;
if (s >= llim && s < hlim),
    K = 1/f/lquad; % half F-quad
end% if
% next N quads
for n=2:Nquad,
    llim =  (0+(n-1)*L_FODO/2)-lquad/2;
    hlim = (lquad/2+(n-1)*L_FODO/2);
    if (s >= llim && s < hlim),
        if(mod(n,2)),
            K = 1/f/lquad; % F-quad
        else
            K = -1/f/lquad; % D-quad
        end% if
    end% if
end% for
% defining the envelope equation
dsigma_ds = zeros(2,1);
dsigma_ds(1) = sigma(2);
dsigma_ds(2) = -K*sigma(1) + emitt^2 / sigma(1)^3;
end% 


%
% test equation
%
function y = testfun(x)
    y=(x+1).^3.*dirac(x+1);
end% 
