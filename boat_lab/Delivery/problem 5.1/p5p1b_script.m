%% INIT
%These files are optimized for delivery as requested on blackboad, 
%and will differ slightly from the files that are included in the report.%
close all;
clear;
clc;

fig = 1;
addpath('data');
%% %% Problem b
%Will run simulation two times and update "parameters each time."
omega_1 = 0.005;
omega_2 = 0.05;
simtime = 5000;

%First omega
omega = 0.005;
sim('p5p1b');

%Plot response of sine wave
figure(fig);
fig = fig + 1;
subplot(2,1,1)
plot(parameters.time, parameters.data, 'LineWidth', 1);
xlabel('t [s]', 'FontSize', 18); 
ylabel('$\psi$ [deg]', 'Interpreter', 'latex');
legend({'Heading'} ,'FontSize', 18, 'Location', 'best');
title('Response of sine wave input where \omega_{1} = 0.005, without noise', ...
'FontSize', 24);
set(gca,'FontSize',14); 
grid on;

% Find ampltiude peaks
A_1_max = max(parameters.data(2000:end));
A_1_min = min(parameters.data(2000:end));

%Second omega
omega = 0.05;
sim('p5p1b');
subplot(2,1,2)
plot(parameters.time, parameters.data, 'LineWidth', 1);
xlabel('t [s]', 'FontSize', 18); 
ylabel('$\psi$ [deg]', 'Interpreter', 'latex');
legend({'Heading'} ,'FontSize', 18, 'Location', 'best');
title('Response of sine wave input where \omega_{2} = 0.05, without noise', ...
'FontSize', 24);
set(gca,'FontSize',14); 
grid on;


% Find ampltiude peaks
A_2_max = max(parameters.data(2000:end));
A_2_min = min(parameters.data(2000:end));


% \\\ Average amplitude value of output
A_1 = (A_1_max - A_1_min)/2;
A_2 = (A_2_max - A_2_min)/2;

%\\\ Finding K and T from system output
syms T K
eqn1 = K/(omega_1*sqrt((omega_1)^2*T^2 + 1)) == A_1;
eqn2 = K/(omega_2*sqrt((omega_2)^2*T^2 + 1)) == A_2;

sol = vpasolve([eqn1, eqn2], [T, K]);

%Converting sym to double
K = double(sol.K);
T = double(sol.T);

