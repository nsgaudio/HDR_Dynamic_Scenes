function [augInput, augLabel] = AugmentData(input, label, ind)

numColorAug = 6;

gInd = ceil(ind / numColorAug);
cInd = mod((ind-1), numColorAug) + 1;

augInput = [];

for i = 1 : 6
    curRange = (i-1)*3+1:i*3;
    
    curInput = input(:, :, curRange);
    curInput = ColorAugmentation(curInput, cInd);
    augInput = cat(3, augInput, GeometricAugmentation(curInput, gInd));
end

augLabel = ColorAugmentation(label, cInd);
augLabel = GeometricAugmentation(augLabel, gInd);

