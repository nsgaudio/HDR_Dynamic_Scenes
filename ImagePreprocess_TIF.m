clear; clc;

% Resizes the .tif files in the scene folders to the proper sizes

%%% Parameters ---------------
newWidth = 1500;
newHeight = 1000;
numScenes = 16;
%%% --------------------------

for s = 1:numScenes
    if s <=9
        sceneName = ['00', num2str(s)];
    else
        sceneName = ['0', num2str(s)];
    end

    inputSceneFolder = 'Scenes';

    sceneFolder = sprintf('%s/%s', inputSceneFolder, sceneName);

    if (~exist(sceneFolder, 'dir'))
        error('Scene folder does not exist');
    end

    listOfFiles = dir(sprintf('%s/*.tif', sceneFolder));
    numImages = size(listOfFiles, 1);
    inputLDRs = cell(1, numImages);

    for i = 1 : numImages
        Path = sprintf('%s/%s/%s', inputSceneFolder, sceneName, listOfFiles(i).name);
        inputLDRs{i} = imread(Path);

        % Resizing
        inputLDRs{i} = imresize(inputLDRs{i}, [newHeight  newWidth], 'bicubic');

        % Saving the resized image and deleting the old tif file
        imwrite(inputLDRs{i}, sprintf('%s/%s/%s.tif', inputSceneFolder, sceneName, listOfFiles(i).name(1:end-4)));
    end
end
