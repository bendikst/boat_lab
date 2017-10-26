%% INIT
close all;
clear;
clc;

fig = 1;
addpath('data');

%% PROBLEM 1b

omega_1 = 0.005;
omega_2 = 0.05;

load('P1b_w1.mat');
load('P1b_w2.mat');
load('P1c_w1.mat');
load('P1c_w2.mat');

%Plot response of sine wave
figure(fig);
fig = fig + 1;
subplot(2,1,1)
plot(Compass1.time, Compass1.data, 'LineWidth', 1);
xlabel('t [s]', 'FontSize', 18); 
ylabel('$\psi$ [deg]', 'Interpreter', 'latex');
legend({'Heading'} ,'FontSize', 18, 'Location', 'best');
title('Response of sine wave input where \omega_{1} = 0.005, without noise', ...
'FontSize', 24);
set(gca,'FontSize',14); 
grid on;

subplot(2,1,2)
plot(Compass2.time, Compass2.data, 'LineWidth', 1);
xlabel('t [s]', 'FontSize', 18); 
ylabel('$\psi$ [deg]', 'Interpreter', 'latex');
legend({'Heading'} ,'FontSize', 18, 'Location', 'best');
title('Response of sine wave input where \omega_{2} = 0.05, without noise', ...
'FontSize', 24);
set(gca,'FontSize',14); 
grid on;


% \\\ Find ampltiude peaks
A_1_max = max(Compass1.data(2000:end));
A_1_min = min(Compass1.data(2000:end));
A_2_max = max(Compass2.data(2000:end));
A_2_min = min(Compass2.data(2000:end));


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

%% PROBLEM 1c
figure(fig);
fig = fig + 1;
subplot(2,1,1)
plot(Compass3.time, Compass3.data, 'LineWidth', 1);
xlabel('t [s]', 'FontSize', 18); 
ylabel('$\psi$ [deg]', 'Interpreter', 'latex');
legend({'Heading'} ,'FontSize', 18, 'Location', 'best');
title('Response of sine wave input where \omega_{1} = 0.005, with noise', ...
'FontSize', 24);
set(gca,'FontSize',14); 
grid on;

subplot(2,1,2)
plot(Compass4.time, Compass4.data, 'LineWidth', 1);
xlabel('t [s]', 'FontSize', 18); 
ylabel('$\psi$ [deg]', 'Interpreter', 'latex');
legend({'Heading'} ,'FontSize', 18, 'Location', 'best');
title('Response of sine wave input where \omega_{2} = 0.05, with noise', ...
'FontSize', 24);
set(gca,'FontSize',14); 
grid on;

%% PROBLEM 1d
load('step_simulink.mat');

%Define transfer function
H_tf = tf(K, [T 1 0]);

%Plot step response of model vs simulation
figure(fig);
fig = fig + 1;

step(H_tf, Compass.time(end));
hold on;
plot(Compass.time, Compass.data, 'r', 'LineWidth', 1);
title('Step response of the ship and model', 'FontSize', 22);
legend({'Model', 'Ship'}, 'FontSize', 28, ...
    'Location', 'best');
grid on; hold off;
xlabel('Time ','FontSize', 22); 
ylabel('Amplitude [deg]','FontSize', 22);
set(gca,'FontSize',14);
