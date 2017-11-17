%% INIT
%These files use simulation resuls stored in the "data" directory%
%to update the simulation, run the simulation separately. (AFTER RUNNING%
%THE COMMON FILE "PART3")%%
close all;
clear;
clc;

fig = 1;
load('data\Part_1_data');
load('data\Part_2_data');
load('data\part3_data');
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