img = imread('MIT300/i188.jpg')
n=11;

img = im2double(rgb2gray(img));
[rows,cols] = size(img);
img = imresize(img, [64,64]);
[rrows,rcols] = size(img);

% Pad image
P = 2*rrows;
Q = 2*rcols;
im_pad = padarray(img, [P/2,Q/2], 0, 'post');


for r = 1:P
    for c = 1:Q
        im_pad(r,c) = im_pad(r,c) * (-1)^(r+c);
    end
end

%local-mean filter
H = 1/(n^2) * ones([3,3]);

%Fourier transform
F = fft2(im_pad);
F_mag = log(abs(F));
F_phase = angle(F);

%average filter on input
specRes = F_mag - imfilter(F_mag, H);

%saliency map
specRes = exp(specRes + 1i*F_phase);

%inverse Fourier transform
g_p = abs(ifft2(specRes));
for r = 1:P
    for c = 1:Q
        g_p(r,c) = g_p(r,c) * (-1)^(r+c);
    end
end
g_p = g_p.^2;

% Remove padding
g_p = imfilter(g_p, fspecial('disk', 3));
g_p = g_p(1:64, 1:64);
g_p = imresize(g_p, [rows, cols]);

% Output image
sr_image = g_p;

fimg = uint8(255*MinMaxNorm(sr_image));
imwrite(fimg,'results/spectral_result_i188_single.jpg')





