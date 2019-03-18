function error = TestDuringTraining(net)

global param;

sceneNames = param.testNames;
fid = fopen([param.trainNet, '/error.txt'], 'at');

numScenes = length(sceneNames);
error = 0;

for k = 1 : numScenes
    
    %%% read input data
    [inputs, reference] = ReadTrainingData(sceneNames{k}, false);
    
    %%% evaluate the network and accumulate error
    [estImg, ~, ~] = EvaluateSystem(net, inputs, reference, false);
    
    curError = ComputePSNR(estImg, reference);    
    error = error + curError / numScenes;
end

fprintf(fid, '%f\n', error);
fclose(fid);

error = gather(error);
