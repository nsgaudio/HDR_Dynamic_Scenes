clear; clc;

% Creates the static HDR image using the method used in Deep High Dynamic Range Imaging of Dynamic Scenes

for s = 1:16
    if s <=9
        sceneName = ['00', num2str(s)];
    else
        sceneName = ['0', num2str(s)];
    end
    
    I1 = im2double(imread(['Scenes_ours/', sceneName, '/s1.tif']));
    I2 = im2double(imread(['Scenes_ours/', sceneName, '/s2.tif']));
    I3 = im2double(imread(['Scenes_ours/', sceneName, '/s3.tif']));
    
    I1 = I1.^(1/2.2);
    I2 = I2.^(1/2.2);
    I3 = I3.^(1/2.2);

    G1 = @(x) ((x <= 0.5) + (x>0.5).*(-2*x + 2));
    G2 = @(x) ((x <= 0.5).*(2*x) + (x>0.5).*(-2*x + 2));
    G3 = @(x) ((x <= 0.5).*(2*x) + (x>0.5));
    alpha1 = 1 - G1(I2);
    alpha2 = G2(I2);
    alpha3 = 1 - G3(I2);
    
    alpha_total = alpha1 + alpha2 + alpha3;

    H_1 = (I1/1).^(2.2);
    H_2 = (I2/4).^(2.2);
    H_3 = (I3/16).^(2.2);

    H = (alpha1 .* H_1 + alpha2 .* H_2 + alpha3 .* H_3) ./ alpha_total;
    
    mu = 5000;
    T = log(1 + mu * H)/log(1 + 5000);
    
    imshow(T)
    hdrwrite(T,['Scenes_ours/', sceneName, '/HDRImg.hdr']);
    imshow(hdrread(['Scenes_ours/', sceneName, '/HDRImg.hdr']));
end



