% v2019-02-19
%
% visualize beam
%
subplot(2,2,1);
% plot particles in 3D space

plot3(B(:,3)*1e3, B(:,1)*1e3, B(:,2)*1e3, '.');
grid on;
xlabel('z [mm]');
ylabel('x [mm]');
zlabel('y [mm]');
title('3D space');
subplot(2,2,3);
% x-x' 2D histogram
n_bins = 71;
subplot(2,2,3);
hist_Zx = linspace(-4*std(B(:,1)), +4*std(B(:,1)), n_bins);
hist_Zy =  linspace(-4*std(B(:,4)), +4*std(B(:,4)), n_bins);
[histmat] = hist2(B(:,1), B(:,4), hist_Zx, hist_Zy);
h_g = pcolor(hist_Zx*1e3,hist_Zy*1e6,histmat); 
shading('flat');
xlabel('x [mm]');
ylabel('x'' [\mu rad]');
title('Transverse phase space');
% x - 1D histogram plotting
subplot(2,2,2);
[C, Z] = hist(B(:,3), linspace(-4*sigma_z, 4*sigma_z, n_bins));
h_g = bar(Z*1e3, C);
xlabel('z [mm]');
title('Longitudinal charge density');
% z-Ek 2D histogram
subplot(2,2,4);
%plot(z*1e3, Ek/1e9, '.');
hist_Zx = linspace(-4*std(B(:,3)), +4*std(B(:,3)), n_bins);
hist_Zy =  linspace(-4*std(B(:,6))+mean(B(:,6)), +4*std(B(:,6))+mean(B(:,6)), n_bins);
[histmat] = hist2(B(:,3), B(:,6), hist_Zx, hist_Zy);
h_g = pcolor(hist_Zx*1e3,hist_Zy/1e9,histmat); 
shading('flat');
xlabel('z [mm]');
ylabel('E_k [GeV]');
title('Longitudinal phase space');
