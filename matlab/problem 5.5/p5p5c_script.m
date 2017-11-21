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
load('data/P5b_measurement_noise.mat');
%Variance in measurement noise
variance = var(measurement_noise.data*pi/180);
%% PROBLEM C - KALMAN FILTER
%New matrices
Q = [30, 0; 0, 10e-6];
P_0_a_priori = [1, 0, 0, 0, 0; 0, 0.013, 0, 0, 0;...
                0, 0, pi^2, 0, 0; 0, 0, 0, 1, 0; 0, 0, 0, 0, 2.5e-3];
x_0_a_priori = [0; 0; 0; 0; 0];

R = variance/Ts; %Variance

sys = struct('A_d', A_d, 'B_d', B_d, 'C_d', C_d, 'E_d', E_d,...
    'Q', Q, 'R', R, 'P_0_a_priori', P_0_a_priori,...
    'x_0_a_priori', x_0_a_priori);

%The discrete kalman filter is implemented in the file kalman_c.m%