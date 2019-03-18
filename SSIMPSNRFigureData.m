% SSIM Figure
clear all; close all;

our_result = im2double(hdrread('OURNETResults/009/finalHDR.hdr'));
their_result = im2double(hdrread('THEIRNETResults/009/finalHDR.hdr'));
reference = im2double(hdrread('Scenes_ours/009/HDRImg.hdr'));
reference = reference(51:end-50, 51:end-50, :);

mu = 5000;
our_result = log(1 + mu * our_result)/log(1 + mu);
their_result = log(1 + mu * their_result)/log(1 + mu);

figure()
imshow([our_result their_result reference])

[ssim_our_val,ssim_our_map] = ssim(our_result,reference);
[ssim_their_val,ssim_their_map] = ssim(their_result,reference);

ssim_our_map = (ssim_our_map(:,:,1) + ssim_our_map(:,:,2) + ssim_our_map(:,:,3))/3;
ssim_their_map = (ssim_their_map(:,:,1) + ssim_their_map(:,:,2) + ssim_their_map(:,:,3))/3;

figure()
imshow([ssim_our_map ssim_their_map], []);

psnr_our = psnr(our_result, reference);
psnr_their = psnr(their_result, reference);

% Calculates the avarge PSNR and SSIM values
% mu = 5000;
% scene = [5, 12, 13, 14, 15, 16];
% % scene = [5, 16];
% S_our = 0;
% S_their = 0;
% P_our = 0;
% P_their = 0;
% for i = 1:numel(scene)
%     if scene(i) <=9
%         sceneName = ['00', num2str(scene(i))];
%     else
%         sceneName = ['0', num2str(scene(i))];
%     end
%     our_result = im2double(hdrread(['OURNETResults/', sceneName, '/finalHDR.hdr']));
%     their_result = im2double(hdrread(['THEIRNETResults/', sceneName, '/finalHDR.hdr']));
%     reference = im2double(hdrread(['Scenes_ours/', sceneName, '/HDRImg.hdr']));
%     reference = reference(51:end-50, 51:end-50, :);
%     
%     our_result = log(1 + mu * our_result)/log(1 + mu);
%     their_result = log(1 + mu * their_result)/log(1 + mu);
%     
%     [ssim_our_val,ssim_our_map] = ssim(our_result,reference);
%     [ssim_their_val,ssim_their_map] = ssim(their_result,reference);
%     
%     psnr_our = psnr(our_result, reference);
%     psnr_their = psnr(their_result, reference);
%     
%     S_our = S_our + ssim_our_val;
%     S_their = S_their + ssim_their_val;
%     P_our = psnr_our + psnr_our;
%     P_their = P_their + psnr_their;
% end
% 
% S_our = S_our / numel(scene);
% S_their = S_their / numel(scene);
% P_our = P_our / numel(scene);
% P_their = P_their / numel(scene);
% 
% 
