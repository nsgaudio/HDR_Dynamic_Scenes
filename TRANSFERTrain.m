% clearvars; clearvars -global; clc; close all; warning off;
% 
% addpath(genpath('Functions'));
% addpath(genpath('./Libraries/'));
% 
% vl_setupnn();
% InitParam();
% 
% net = LoadNetwork(true);
% 
% TrainSystem(net);
% 
% warning on;

clearvars; clearvars -global; clc; close all; warning off;

addpath(genpath('Functions'));
addpath(genpath('./Libraries/'));

vl_setupnn();
InitParam();

initial = load('./TrainedNetwork/NetCPU.mat');

net = TRANSFERLoadNetwork(true, initial.net.layers);

TRANSFERTrainSystem(net);

warning on;