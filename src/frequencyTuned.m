

%---------------------------------------------------------
% Read image and blur it with a 3x3 or 5x5 Gaussian filter
%---------------------------------------------------------
clear all;
img = imread('MIT300/i188.jpg');%Provide input image path
%gfrgb = imfilter(img, fspecial('gaussian', 3, 3), 'symmetric', 'conv');
figure('Name','Original');
imshow(img);

gfrgb = imgaussfilt(img,'FilterSize',3);
%---------------------------------------------------------
% Perform sRGB to CIE Lab color space conversion (using D65)
%---------------------------------------------------------
lab = rgb2lab(gfrgb,'WhitePoint','d50');

%---------------------------------------------------------
% Compute Lab average values (note that in the paper this
% average is found from the unblurred original image, but
% the results are quite similar)
%---------------------------------------------------------
l = double(lab(:,:,1)); lm = mean(mean(l));
a = double(lab(:,:,2)); am = mean(mean(a));
b = double(lab(:,:,3)); bm = mean(mean(b));
%---------------------------------------------------------
% Finally compute the saliency map and display it.
%---------------------------------------------------------
sm = (l-lm).^2 + (a-am).^2 + (b-bm).^2;

figure('Name','Saliency Map');
imshow(sm,[]);
fimg = uint8(255*MinMaxNorm(sm));
imwrite(fimg,'results/spectral_result_i188_single.jpg')

%---------------------------------------------------------