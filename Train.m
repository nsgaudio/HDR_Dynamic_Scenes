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

net = LoadNetwork(true);

TrainSystem(net);

warning on;