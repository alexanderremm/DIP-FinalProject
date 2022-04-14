function [sr_image] = spectral_residual(img, n)
%SPECTRAL_RESIDUAL Function to compute Spectral Residual saliency map
%   Computes the Spectral Residual saliency map based on the following
%   paper: Saliency Detection: A Spectral Residual Approach (Hou and
%   Zhang).

% Prepare the input image
img = im2double(rgb2gray(img));
[rows,cols] = size(img);
img = imresize(img, [64,64]);
[rrows,rcols] = size(img);

% Pad image for Fourier transform
P = 2*rrows;
Q = 2*rcols;
im_pad = padarray(img, [P/2,Q/2], 0, 'post');

% Zero-frequency centering
for r = 1:P
    for c = 1:Q
        im_pad(r,c) = im_pad(r,c) * (-1)^(r+c);
    end
end

% Create local-mean filter
H = 1/(n^2) * ones([3,3]);

% Perform Fourier transform
F = fft2(im_pad);
F_mag = log(abs(F));
F_phase = angle(F);

% Filter input image with average filter
specRes = F_mag - imfilter(F_mag, H);

% Generate saliency map
specRes = exp(specRes + 1i*F_phase);

% Perform inverse Fourier transform
g_p = abs(ifft2(specRes));
for r = 1:P
    for c = 1:Q
        g_p(r,c) = g_p(r,c) * (-1)^(r+c);
    end
end
g_p = g_p.^2;

% Remove padding from filtered image
g_p = imfilter(g_p, fspecial('disk', 3));
g_p = g_p(1:64, 1:64);
g_p = imresize(g_p, [rows, cols]);

% Output image
sr_image = g_p;

end

