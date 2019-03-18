function net = TRANSFERLoadNetwork(isTraining, initial)

if(~exist('isTraining', 'var') || isempty(isTraining))
    isTraining = false;
end

global param;

if (isTraining)
    netFolder = param.trainNet;
    [netName, ~, ~] = GetFolderContent(netFolder, '.mat');

    param.continue = false;
    net = TRANSFERCreateNet(initial);
else
    netFolder = param.testNet;
    load([netFolder, '/Net']);
end


if (param.useGPU)
    net = vl_simplenn_move(net, 'gpu');
    net = ConvertLayers(net, 'gpu');
else
    net = vl_simplenn_move(net, 'cpu');
    net = ConvertLayers(net, 'cpu');
end