% Clear previous results
clear; close all; clc; commandwindow;

% Read in a test image
im = imread("MIT300\i1.jpg");

% Spectral Residual method
sr = spectral_residual(im, 3);
subplot(1, 2, 1);
imshow(im);
title('Original Image');
subplot(1, 2, 2);
imshow(uint8(255*MinMaxNorm(sr)));
title('Spectral Residual Saliency Map');

% Context Aware method

% Real-time Visual Saliency Detection method