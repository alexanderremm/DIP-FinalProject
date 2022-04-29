clear all;
close all;
imgT = imread('GT/i188_Truth.jpg');%Provide input image path
%gfrgb = imfilter(img, fspecial('gaussian', 3, 3), 'symmetric', 'conv');
figure('Name','truth');
imshow(imgT);
imgT = rgb2gray(imgT)


img = imread('results/spectral_result_i188_single.jpg');%Provide input image path
%gfrgb = imfilter(img, fspecial('gaussian', 3, 3), 'symmetric', 'conv');
numPix = (size(img,1)*size(img,2))

figure('Name','FT');

grayImage = uint8(255 * mat2gray(img))
imshow(img);

ssival = ssim(img,imgT);





