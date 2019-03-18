% Dataset figure


clear; clc;

% Creates the static HDR image

s1 = imread('Scenes_ours/007/s1.tif');
s2 = imread('Scenes_ours/007/s2.tif');
s3 = imread('Scenes_ours/007/s3.tif');

d1 = imread('Scenes_ours/007/d1.tif');
d2 = imread('Scenes_ours/007/d2.tif');
d3 = imread('Scenes_ours/007/d3.tif');

hdr = hdrread('Scenes_ours/007/HDRImg.hdr');

s1 = s1(200:900,600:1000,:);
s2 = s2(200:900,600:1000,:);
s3 = s3(200:900,600:1000,:);
d1 = d1(200:900,600:1000,:);
d2 = d2(200:900,600:1000,:);
d3 = d3(200:900,600:1000,:);
hdr = hdr(200:900,600:1000,:);

static = [s1, s2, s3];
dynamic = [d1, d2, d3];
input = [d1, s2, d3];

figure()
imshow(static)
title('Static Set');

figure()
imshow(dynamic)
title('Dynamic Set');

figure()
imshow(input)
title('Input LDR Images');

figure()
imshow(hdr);
title('Ground Truth HDR Image');






