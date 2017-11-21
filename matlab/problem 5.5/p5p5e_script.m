%% INIT
%These files use simulation resuls stored in the "data" directory%
%to update the simulation, run the simulation separately. (AFTER RUNNING%
%THE COMMON FILE "PART5")%
close all;
clear;
clc;

psi_ref = 30;
fig = 1;
load('data/part_1_data.mat');
load('data/part_2_data.mat');
load('data/part3_data.mat');
%% PROBLEM E - SIMULATION WITH FILTERET PSI
%Load simulation results
load('data/P5e_reference.mat');
load('data/P5e_heading.mat');
load('data/P5e_rudder_input.mat');
load('data/P5e_est_bias.mat');
load('data/P5e_heading_est.mat');
load('data/P5e2_heading_est.mat');
load('data/P5e2_heading.mat');
load('data/P5e2_est_bias.mat');

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
