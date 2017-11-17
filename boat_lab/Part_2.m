%% INIT
close all;
clear;
clc;

fig = 1;
load('wave.mat');
%% PROBLEM 5.2a Calculate estimate of PSD

s_freq = 10; %Hz
window = 4096;
noverlap = [];
nfft = [];

%Find estimated PSD. Converting input from deg to rad
[pxx, f] = pwelch(psi_w(2,:).*(pi/180), window, noverlap, nfft, s_freq);

%Converting result units, from Hz to rad/s and power per Hz to power rad/s.
omega = 2*pi.*f;
pxx = pxx./(2*pi);


%% PROBLEM 5.2c - Find omega_0

%Plot PSD
figure(fig);
fig = fig + 1;

plot(omega, pxx, 'LineWidth', 2);
axis([0 2 0 16*10^(-4)])

xlabel('$\omega$ [$\frac{\textrm{rad}}{\textrm{s}}$]', 'FontSize', 25,...
    'Interpreter', 'latex'); 
ylabel('$S_{\psi_{w}}(\omega)$ [rad]','FontSize', 25,...
    'Interpreter', 'latex');
title('Estimated Power spectral density of wave disturbance', ...
'FontSize', 24);
grid on;

%Setting x axis to rad values
ax = gca; 
ax.XTick = 0:pi/8:2;
ax.XTickLabel = {'$0$', '$\frac{\pi}{8}$', '$\frac{\pi}{4}$', ...
    '$\frac{3\pi}{8}$', '$\frac{\pi}{2}$','$\frac{5\pi}{8}$', ...
    '$\frac{3\pi}{4}$'};
ax.TickLabelInterpreter = 'latex';
ax.FontSize = 24;

%Calculating omega_0
[max_pxx, indx] = max(pxx);
omega_0 = omega(indx);

%% PROBLEM 5.2d - Find lambda
%
sigma = sqrt(max_pxx);
lambda_test_values = [0.04 0.08 0.12];

%Plotting S with different values for lambda
figure(fig)
fig = fig + 1;
plot(omega, pxx, 'LineWidth', 2);
axis([0 2 0 16*10^(-4)])

xlabel('$\omega$ [$\frac{\textrm{rad}}{\textrm{s}}$]', 'FontSize', 25,...
    'Interpreter', 'latex'); 
ylabel('$S_{\psi_{w}}(\omega)$ [rad]','FontSize', 25,...
    'Interpreter', 'latex');
title('Estimated Power spectral density of wave disturbance', ...
'FontSize', 24);
grid on;
hold on;

%Setting x axis to rad values
ax = gca; 
ax.XTick = 0:pi/8:2;
ax.XTickLabel = {'$0$', '$\frac{\pi}{8}$', '$\frac{\pi}{4}$', ...
    '$\frac{3\pi}{8}$', '$\frac{\pi}{2}$','$\frac{5\pi}{8}$', ...
    '$\frac{3\pi}{4}$'};
ax.TickLabelInterpreter = 'latex';
ax.FontSize = 24;


for lambda = lambda_test_values
    K_w = 2*lambda*omega_0*sigma;
    P_psi_omega = ((K_w*omega).^2)./(omega_0^4 + omega.^4 ... 
    + (omega_0*omega).^2.*(4*lambda^2 - 2));
    plot(omega, P_psi_omega, '--', 'LineWidth', 1.5);
end

legend({'$S_{\psi_{w}}(\omega)$', '$\lambda = 0.04$', ...
    '$\lambda = 0.08$', '$\lambda = 0.12$'}, ...
    'Interpreter', 'Latex', 'Location', 'best', 'FontSize', 25);
%Choosing lambda:
lambda = 0.08;

%% SAVE
save('data\Part_2_data', 'omega_0', 'lambda', 'K_w');
