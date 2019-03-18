function TrainSystem(net)

global param;

testError = GetTestError(param.trainNet);
count = 0;
it = param.startIter + 1;

while (1)
    
    if (mod(it, param.printInfoIter) == 0)
        fprintf(repmat('\b', [1, count]));
        count = fprintf('Performing iteration %d', it);
    end
    
    %% main optimization
    [inputs, reference] = ReadTrainingData(param.trainingNames{1}, [], it);
    [~, res] = EvaluateSystem(net, inputs, reference, true);
    
    net = UpdateNet(net, res, it);
    
    
    if (mod(it, param.testNetIter) == 0)
        %% save network
        [~, curNetName, ~] = GetFolderContent(param.trainNet, '.mat');
        fileName = sprintf('/Net-%06d.mat', it);
        save([param.trainNet, fileName], 'net');
        
        if (~isempty(curNetName))
            curNetName = curNetName{1};
            delete(curNetName);
        end
    
    
        %% perform validation
        countTest = fprintf('\nStarting the validation process\n');
        
        curError = TestDuringTraining(net);
        testError = [testError; curError];
        plot(1:length(testError), testError);
        title(sprintf('Current PSNR: %f', curError));
        drawnow;
        
        fprintf(repmat('\b', [1, countTest]));
    end
    
    it = it + 1;
end