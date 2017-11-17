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