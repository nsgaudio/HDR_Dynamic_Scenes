function TRANSFERGenerateHDR(net, curImgsLDR, curExpo, curLabel, resultPath)

global param;

[inputs, label] = PrepareInputFeatures(curImgsLDR, curExpo, curLabel, true);

if(param.useGPU)
    inputs = gpuArray(inputs);
    label = gpuArray(label);
end

[estImg, ~, estImgLinear] = TRANSFEREvaluateSystem(net, inputs, label, false);


if(~isempty(label))
    label = RangeCompressor(label);
    label = CropImg(label, 50); estImg = CropImg(estImg, 44); estImgLinear = CropImg(estImgLinear, 44);
    
    error = ComputePSNR(estImg, label);
    fid = fopen([resultPath, '/error.txt'], 'wt'); fprintf(fid, '%f\n', error); fclose(fid);
end

hdrwrite(gather(estImgLinear), [resultPath, '/finalHDR.hdr']);
