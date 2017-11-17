%% INIT
close all;
clear;
clc;

fig = 1;
load('data\Part_1_data');
%% PROBLEM a
%psi < +-35deg
psi_ref = 30; %degrees
omega_c = 0.1; %rad

T_f = -1/(tan(130*pi/180)*omega_c);
K_pd = sqrt(omega_c^2+T_f^2*omega_c^4)/K;
T_d = T;

%Transfer functions
H_ship = tf(K, [T 1 0]);
H_pd = tf([K_pd*T_d K_pd], [T_f 1]);
H_0 = H_ship * H_pd;

%Plotting 
figure(fig);
fig = fig + 1;
[mag, phase] = bode(H_0, 0.1);
margin(H_0);
grid on;

%% PROBLEM b
%Simulation results, autopilot
%Load simulation results
load('data\P3b_reference.mat');
load('data\P3b_heading.mat');
load('data\P3b_rudder_input.mat');

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

%% PROBLEM c
%Plotting simulation results, autopilot with current disturbance
%Load simulation results
load('data\P3c_reference.mat');
load('data\P3c_heading.mat');
load('data\P3c_rudder_input.mat');

figure(fig)
fig = fig + 1;
plot(heading_reference_c.time, heading_reference_c.data, 'r--', ...
    heading_c.time, heading_c.data, rudder_input_c.time, rudder_input_c.data, ...
    'LineWidth', 1);
xlabel('t [s]', 'FontSize', 18); 
ylabel('$\mathbf{\psi_{r}(t), \ \psi(t), \ \delta}$ [deg]', ...
    'FontSize', 20, 'Interpreter', 'latex');
legend({'Heading reference', 'Heading', 'Rudder input'} ,'FontSize', 18, 'Location', 'best');
title('Response of the autopilot with measurement noise and current', ...
'FontSize', 24); 
grid on;

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

%% NORTH-EAST plot
%Load data from simulations
load('data\P3b_xy.mat');
load('data\P3c_xy.mat');
load('data\P3d_xy.mat');

plot(xy_plot.y.data,xy_plot.x.data,'r--', ...
    xy_plot_c.y.data,xy_plot_c.x.data, ...
    xy_plot_d.y.data,xy_plot_d.x.data,'m', 'LineWidth', 2);
title('North-East plot of ship course', 'FontSize', 24);
ylabel('North [m]', 'FontSize', 20); grid on;
xlabel('East [m]', 'FontSize', 20);
ax = gca; ax.FontSize = 24; axis([0 150 0 600]);
legend({'Without disturbances', 'With current', ...
'With waves'}, 'Location', 'best', 'FontSize', 36)

%% SAVE
save('data\part3_data', 'K_pd', 'T_d', 'T_f')

