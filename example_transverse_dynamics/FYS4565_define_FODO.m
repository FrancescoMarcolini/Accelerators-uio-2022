% v2019-02-21
% define optics of FODO
global L_FODO N_FODO phi f b_F lquad Nquad;
L_FODO = 100; % m
most_irrational_number = (1+sqrt(5))/2; % the golden mean
phi = 36.0*most_irrational_number*pi/180; % to best avoid resonces, the tune should be irrational
                                          phi = 59.0*pi/180;
f = L_FODO/4/sin(phi/2); % calculate f from phi
%f = 24; % m
%phi = 2*asin(L_FODO/4/f)
beta_F = L_FODO*(1+sin(phi/2))/sin(phi); % matched beta in F-quad middle
lquad = 1; % m - length of quad
N_FODO = 8;
Nquad = N_FODO*2;
Q_tune = N_FODO*phi/2/pi; % tune

is_K_zero = 0; % force K=0 everywhere (drift in vacuum)
if( is_K_zero)
    % "a hack" to remove the FODO lattice, set focal length very large (K -> 0)
    f = 1e99;
    beta_F = 100;
end% if