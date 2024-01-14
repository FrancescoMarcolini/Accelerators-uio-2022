% v2019-02-22
%
% run FYS4565_envelope first to track inside envelope

%
FYS4565_define_beam % load beam
FYS4565_define_FODO % define characteristics of the FODO lattice

%
% Part II - track individual particles
%
N_part = 1000; % total particles to be tracked
for n_part=1:N_part, % track N particles
% initial conditions
n_rand = randi(size(B(:,1), 1)); % pick out a random particle
x0 = B(n_rand, [1 4]); % 
Ek = B(n_rand, 6);
% override particle from beam with a demo-particle at 3 sigma
%x0 = [3*sqrt(em_rms_x*beta_F); 0];  Ek = Ek0; % demo-particle at 3 sigma, nominal energy
n = 1; % counter 
x(:, n) = x0; % initial vector
s = 0; % initial beam position
is_ring=1; % simulate ring
if(is_ring)
    N_turns=100; 
else
    N_turns=1; % set to one for linac
end% if
turn_n(1) = 1;
n_noline = []; % don't plot the line when wrapping around the ring
for k=1:N_turns,
    for m=1:N_FODO,
        % define transfer matrices
        % adjust focal length for individial particle energy
        f = f * Ek/Ek0;
        M_F = [1 0; -1/f 1];
        s_F = 0;
        M_F2 = [1 0; -1/f/2 1];
        s_F2 = 0;
        M_D = [1 0; 1/f 1];
        s_D = 0;
        M_D2 = [1 0; 2/f/2 1];
        s_D2 = 0;
        M_0 = [1 L_FODO/2; 0 1];
        s_0 = L_FODO/2;
        % propagate particle through lattice
        x(:, n+1) = M_F2*x(:, n);
        s(n+1) = s(n) + s_F2;
        n=n+1;
        x(:, n+1) = M_0*x(:, n);
        s(n+1) = s(n) + s_0;
        n=n+1;
        x(:, n+1) = M_D*x(:, n);
        s(n+1) = s(n) + s_D;
        n=n+1;
        x(:, n+1) = M_0*x(:, n);
        s(n+1) = s(n) + s_0;
        n=n+1;
        x(:, n+1) = M_F2*x(:, n);
        s(n+1) = s(n) + s_F2;
        n=n+1;
    end% for
    s(n) = 0;
    turn_n(k+1) = n;
    % imperfection
    is_lattice_imperfection_present = 0;
    if( is_lattice_imperfection_present )
        % add a small dipole perturbation (kick) at a given point in ring
        dxp = 1e-6;
        x(2, n) = x(2, n) + dxp;
    end% if
end% for

% plotting
hold on;
for k=1:N_turns,
    idx=turn_n(k):(turn_n(k+1)-1);
        plot(s(idx), x(1, idx)*1e3, ':r');
        grid on;
        xlabel('s [m]');
        ylabel('x [um]');
        title('Tracking FODO cell with L_{FODO} = 100 m');
        
     %    end% for
     %disp('press the any key for next turn');
     pause;
end% for N_turns

disp('press the any key for next particle'); pause;
end% track N particles

hold off;
disp('done');
