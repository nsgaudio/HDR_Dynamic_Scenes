function [estC, res, estHDR] = TRANSFEREvaluateSystem(net, inputs, refC, isTraining)

%% forward pass
res = TRANSFEREvaluateNet(net, inputs(:, :, 1:18, :), [], true, isTraining);
estHDR = WeightedAverage(res(end).x, inputs(:, :, 10:18, :));
estC = RangeCompressor(estHDR);

%% backward pass
if (isTraining)
    dzdx = vl_nnpdist(estC, refC, 2, 1, 'noRoot', true, 'aggregate', true);
    dzdx = RangeCompressor(estHDR, dzdx);
    dzdx = WeightedAverage(res(end).x, inputs(:, :, 10:18, :), dzdx);
    
    res(end).dzdx = dzdx;
    res = TRANSFEREvaluateNet(net, inputs, res, false, isTraining);
end