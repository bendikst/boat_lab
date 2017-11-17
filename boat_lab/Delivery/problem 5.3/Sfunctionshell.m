function [sys,x0,str,ts] = DiscKal(t,x,u,flag,data)
% Shell for the discrete kalman filter assignment in
% TTK4115 Linear Systems.
%
% Author: Jørgen Spjøtvold
% 19/10-2003 
%

switch flag,

  %%%%%%%%%%%%%%%%%%
  % Initialization %
  %%%%%%%%%%%%%%%%%%
  case 0,
    [sys,x0,str,ts]= mdlInitializeSizes(data);

  %%%%%%%%%%%%%
  % Outputs   %
  %%%%%%%%%%%%%
  
  case 3,
    sys=mdlOutputs(t,x,u,data);
  %%%%%%%%%%%%%
  % Terminate %
  %%%%%%%%%%%%%
  
  case 2,
    sys=mdlUpdate(t,x,u, data);
  
  case {1,4,}
    sys=[];

  case 9,
      sys=mdlTerminate(t,x,u);
  %%%%%%%%%%%%%%%%%%%%
  % Unexpected flags %
  %%%%%%%%%%%%%%%%%%%%
  otherwise
    error(['Unhandled flag = ',num2str(flag)]);

end

function [sys,x0,str,ts] = mdlInitializeSizes(data)
% This is called only at the start of the simulation. 

sizes = simsizes; % do not modify

sizes.NumContStates  = 0; % Number of continuous states in the system, do not modify
sizes.NumDiscStates  = 35; % Number of discrete states in the system, modify. 
sizes.NumOutputs     = 2; % Number of outputs, the hint states 2
sizes.NumInputs      = 2; % Number of inputs, the hint states 2
sizes.DirFeedthrough = 1; % 1 if the input is needed directly in the
% update part
sizes.NumSampleTimes = 1; % Do not modify  

sys = simsizes(sizes); % Do not modify  

x0  = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, (data.P_0_a_priori(:)')]'; % Initial values for the discrete states, modify

str = []; % Do not modify

ts  = [-1 0]; % Sample time. [-1 0] means that sampling is
% inherited from the driving block and that it changes during
% minor steps.


function sys = mdlUpdate(t,x,u, data)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Update the filter covariance matrix and state etsimates here.
% example: sys=x+u(1), means that the state vector after
% the update equals the previous state vector + input nr one.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

P_priori = reshape(x(11:35), 5, 5);
L = P_priori*(data.C_d)'*(data.C_d*P_priori*(data.C_d)' + data.R)^(-1);

x_priori = x(1:5);
x_posteriori = x_priori + L*(u(2) - data.C_d*x_priori); %Input number 2 =y

I = eye(5);
P_posteriori = (I - L*data.C_d)*P_priori*(I - L*data.C_d)' + L*data.R*(L)';

x_predict = data.A_d*x_posteriori + data.B_d*u(1); %u(1) is first input u
P_predict = data.A_d*P_posteriori*(data.A_d)' + data.E_d*data.Q*(data.E_d)';

sys=[x_predict; x_posteriori; P_predict(:)];

function sys = mdlOutputs(t,x,u,data)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculate the outputs here
% example: sys=x(1)+u(2), means that the output is the first state+
% the second input. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sys=[x(7); x(10)];

function sys = mdlTerminate(t,x,u)
sys = [];


