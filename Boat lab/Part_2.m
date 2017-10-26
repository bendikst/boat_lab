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

xlabel('$\omega$ [$\frac{rad}{s}$]', 'FontSize', 25,...
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
omega_0 = pxx(indx);

%% PROBLEM 5.2d - Find lambda