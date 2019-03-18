function [inputs, label] = ComputeTrainingExamples(curImgsLDR, curExpo, curLabel)

global param;

patchSize = param.patchSize;
cropSize = param.cropSizeTraining;
stride = param.stride;
numAugment = param.numAugment;
numTotalAugment = param.numTotalAugment;

%%% prepare input features
[curInputs, curLabel] = PrepareInputFeatures(curImgsLDR, curExpo, curLabel);

%%% crop boundaries
curInputs = CropImg(curInputs, cropSize);
curLabel = CropImg(curLabel, cropSize);

%%% initialize arrays
[h, w, ~] = size(curInputs);
numPatches = GetNumPatches(h, w);
inputs = zeros([patchSize, patchSize, 18, numPatches * numAugment], 'single');
label =  zeros([patchSize, patchSize, 3,  numPatches * numAugment], 'single');


augInds = randperm(numTotalAugment);

for i = 1 : numAugment
    
    curInd = augInds(i);
    [curAugInputs, curAugLabel] = AugmentData(curInputs, curLabel, curInd);

    curInputPatch = GetPatches(curAugInputs, patchSize, stride);
    curLabelPatch = GetPatches(curAugLabel, patchSize, stride);

    inputs(:, :, :, (i-1)*numPatches+1:i*numPatches) = curInputPatch;
    label (:, :, :, (i-1)*numPatches+1:i*numPatches) = curLabelPatch;
    
end

selInds = SelectSubset(inputs(:, :, 4:6, :));

inputs = inputs(:, :, :, selInds);
label = label(:, :, :, selInds);

