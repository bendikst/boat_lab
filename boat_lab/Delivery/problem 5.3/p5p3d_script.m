%% INIT
%These files use simulation resuls stored in the "data" directory%
%to update the simulation, run the simulation separately. (AFTER RUNNING%
%THE COMMON FILE "PART3")%
close all;
clear;
clc;

fig = 1;
load('data\Part_1_data');
load('data\Part_2_data');
load('data\part3_data');
%% PROBLEM d
%Plotting simulation results, autopilot with wave disturbance
%Load simulation results
load('data\P3d_reference.mat');
load('data\P3d_heading.mat');
load('data\P3d_rudder_input.mat');

figure(fig)
fig = fig + 1;
plot(heading_reference_d.time, heading_reference_d.data, 'r--', ...
    heading_d.time, heading_d.data, rudder_input_d.time, rudder_input_d.data, ...
    'LineWidth', 1);
xlabel('t [s]', 'FontSize', 18); 
ylabel('$\mathbf{\psi_{r}(t), \ \psi(t), \ \delta}$ [deg]', ...
    'FontSize', 20, 'Interpreter', 'latex');
legend({'Heading reference', 'Heading', 'Rudder input'} ,'FontSize', 18, 'Location', 'best');
title('Response of the autopilot with measurement noise and waves', ...
'FontSize', 24); 
grid on;
