clear all;
img = imread('MIT300/i188.jpg');

figure('Name','Original');
imshow(img);
%blur image with gaussian filter
gfrgb = imgaussfilt(img,'FilterSize',3);
%conversion to lab color space
lab = rgb2lab(gfrgb,'WhitePoint','d50');

%compute global statistics for mean of each channel
l = double(lab(:,:,1)); lm = mean(mean(l));
a = double(lab(:,:,2)); am = mean(mean(a));
b = double(lab(:,:,3)); bm = mean(mean(b));
%compute sum of MSE for all three channels
sm = (l-lm).^2 + (a-am).^2 + (b-bm).^2;

figure('Name','Saliency Map');
imshow(sm,[]);
fimg = uint8(255*MinMaxNorm(sm));
imwrite(fimg,'results/spectral_result_i188_single.jpg')

