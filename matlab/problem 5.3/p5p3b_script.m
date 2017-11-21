%% INIT
%These files use simulation resuls stored in the "data" directory%
%to update the simulation, run the simulation separately. (AFTER RUNNING%
%THE COMMON FILE "PART3")%
close all;
clear;
clc;

fig = 1;
load('data/Part_1_data');
load('data/Part_2_data');
load('data/part3_data');
%% PROBLEM b
%Simulation results, autopilot
%Load simulation results

load('data/P3b_reference.mat');
load('data/P3b_heading.mat');
load('data/P3b_rudder_input.mat');

figure(fig)
fig = fig + 1;
plot(heading_reference.time, heading_reference.data, 'r--', ...
    heading.time, heading.data, rudder_input.time, rudder_input.data, ...
    'LineWidth', 1);
xlabel('t [s]', 'FontSize', 18); 
ylabel('$\mathbf{\psi_{r}(t), \ \psi(t), \ \delta}$ [deg]', ...
    'FontSize', 20, 'Interpreter', 'latex');
legend({'Heading reference', 'Heading', 'Rudder input'}, ...
    'FontSize', 18, 'Location', 'best');
title('Response of the autopilot with measurement noise', ...
'FontSize', 24);
grid on;