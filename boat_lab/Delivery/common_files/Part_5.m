%% INIT
close all;
clear;
clc;

psi_ref = 30;
fig = 1;
load('data/part_1_data.mat');
load('data/part_2_data.mat');
load('data/part3_data.mat');
%% SYSTEM
%From part IV:
A = [0, 1, 0, 0, 0; -omega_0^2, -2*lambda*omega_0, 0, 0, 0;...
    0, 0, 0, 1, 0; 0, 0, 0, -1/T, -K/T; 0, 0, 0, 0, 0];
B = [0; 0; 0; K/T; 0];
C = [0, 1, 1, 0, 0];
D = 0;
E = [0, 0; K_w, 0; 0, 0; 0, 0; 0, 1];

%% PROBLEM A - DISCRETIZATION
%Discrete system
Ts = 0.1;

[~, B_d] = c2d(A, B, Ts);
C_d = C;
[A_d, E_d] = c2d(A, E, Ts);
D_d = D;
%% PROBLEM B - VARIANCE
load('data\P5b_measurement_noise.mat');
%Variance in measurement noise
variance = var(measurement_noise.data*pi/180);
%% PROBLEM C - KALMAN FILTER
%New matrices
Q = [30, 0; 0, 10e-6];
P_0_a_priori = [1, 0, 0, 0, 0; 0, 0.013, 0, 0, 0;...
                0, 0, pi^2, 0, 0; 0, 0, 0, 1, 0; 0, 0, 0, 0, 2.5e-3];
x_0_a_priori = [0; 0; 0; 0; 0];

R = variance/Ts; %Variance

sys = struct('A_d', A_d, 'B_d', B_d, 'C_d', C_d, 'E_d', E_d, 'Q', Q, 'R', R,...
    'P_0_a_priori', P_0_a_priori, 'x_0_a_priori', x_0_a_priori);


%% PROBLEM D - Simulation with estimated bias
%Load simulation results
load('data\P5d_reference.mat');
load('data\P5d_heading.mat');
load('data\P5d_rudder_input.mat');
load('data\P5d_est_bias.mat');


figure(fig)
fig = fig + 1;
plot(heading_reference_5d.time, heading_reference_5d.data, 'r--', ...
    heading_5d.time, heading_5d.data, rudder_input_5d.time,...
    rudder_input_5d.data, est_bias_5d.time,...
    est_bias_5d.data, 'LineWidth', 1);
xlabel('t [s]', 'FontSize', 18); 
ylabel('$\mathbf{\psi_{r}(t), \ \psi(t), \ \delta}$ [deg]', ...
    'FontSize', 20, 'Interpreter', 'latex');
legend({'Heading reference', 'Heading', 'Rudder input',...
    'Estimated bias'},'FontSize', 18, 'Location', 'best');
title('Response of the autopilot including Kalman filter, with measurement noise and current disturbance', ...
'FontSize', 24); 
grid on;

%% PROBLEM E - SIMULATION WITH FILTERET PSI
%Load simulation results
load('data\P5e_reference.mat');
load('data\P5e_heading.mat');
load('data\P5e_rudder_input.mat');
load('data\P5e_est_bias.mat');
load('data\P5e_heading_est.mat');
load('data\P5e2_heading_est.mat');
load('data\P5e2_heading.mat');
load('data\P5e2_est_bias.mat');

figure(fig)
fig = fig + 1;
plot(heading_reference_5e.time, heading_reference_5e.data, 'r--', ...
    heading_5e.time, heading_5e.data, est_heading_5e.time,...
    est_heading_5e.data, rudder_input_5e.time,...
    rudder_input_5e.data, est_bias_5e.time,...
    est_bias_5e.data, 'LineWidth', 1);
xlabel('t [s]', 'FontSize', 18); 
ylabel('$\mathbf{\psi_{r}(t), \ \psi(t), \ \delta}$ [deg]', ...
    'FontSize', 20, 'Interpreter', 'latex');
legend({'Heading reference', 'Heading', 'Estimated heading',...
    'Rudder input', 'Estimated bias'},'FontSize', 18, 'Location', 'best');
title('Response of the autopilot including Kalman filter, with measurement noise, wave and current disturbance', ...
'FontSize', 24); 
grid on;

%Plotting wave influence
figure(fig)
fig = fig + 1;
plot(heading_5e2.time, heading_5e2.data, est_heading_5e2.time,...
    est_heading_5e2.data, 'LineWidth', 2)
title(['Measured wave influence $\psi_{w}$ vs. estimated wave influence'...
' $\hat{\psi}_{w}$'], 'FontSize', 24, 'Interpreter', 'latex');
xlabel('t [s]', 'FontSize', 20); ylabel('Angle [deg]', 'FontSize', 20);
legend({'$\psi_{w}$', '$\hat{\psi}_{w}$'}, 'FontSize', 24, ...
'Interpreter', 'latex', 'Location', 'best')
ax = gca; ax.FontSize = 24; grid on;
axis([0 500 -4 4]);


