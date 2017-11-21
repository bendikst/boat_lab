%% INIT
%These files are optimized for delivery as requested on blackboad, 
%and will differ slightly from the files that are included in the report.%
close all;
clear;
clc;

fig = 1;
addpath('data');

%From previous parts
K = 0.156121789144805;
T = 72.434665779920020;
%% problem d
sim('p5p1d')
%Define transfer function
H_tf = tf(K, [T 1 0]);


%Plot step response of model vs simulation
figure(fig);
fig = fig + 1;

step(H_tf, parameters.time(end));
hold on;
plot(parameters.time, parameters.data, 'r', 'LineWidth', 1);
title('Step response of the ship and model', 'FontSize', 22);
legend({'Model', 'Ship'}, 'FontSize', 28, ...
    'Location', 'best');
grid on; hold off;
xlabel('Time ','FontSize', 22); 
ylabel('Amplitude [deg]','FontSize', 22);
set(gca,'FontSize',14);




