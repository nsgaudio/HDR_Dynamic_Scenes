clearvars; clearvars -global; clc; close all; warning off;

%% Initialization
addpath('Functions');
addpath(genpath('./Libraries'));

sceneFolder = './Scenes';
resultFolder = './Results';

vl_setupnn();
InitParam();

v = ver;
havePar = any(strcmp('Parallel Computing Toolbox', {v.Name}));

if (havePar && isempty(gcp('nocreate')))
    parpool;
end

%%% load the pre-trained network
net = TRANSFERLoadNetwork();

%% Generate novel views for each scene

[sceneNames, scenePaths, numScenes] = GetFolderContent(sceneFolder);

% for ns = 1 : numScenes
for ns = 2 : numScenes
    
    fprintf('**********************************\n');
    fprintf('Working on the "%s" dataset\n', sceneNames{ns});
    
    resultPath = [resultFolder, '/', sceneNames{ns}];
    MakeDir(resultPath);
    
    curExpo = ReadExpoTimes(scenePaths{ns});
    [curImgsLDR, curLabel] = ReadImages(scenePaths{ns});
    
    TRANSFERGenerateHDR(net, curImgsLDR, curExpo, curLabel, resultPath);
    fprintf('\n\n\n');
    
end

if (havePar && ~isempty(gcp('nocreate')))
    delete(gcp('nocreate'));
end

warning on;