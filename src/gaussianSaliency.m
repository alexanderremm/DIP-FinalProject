%visual saliency with gaussian
clear all;
img = imread('BenchmarkIMAGES/i104.jpg');
figure('Name','Original');
imshow(img);


lab_img = rgb2lab(img);



alpha = [.33,.33,.33];
a = 1;

%mu = [mean(lab_img(700:750,1:250,1)),mean(lab_img(700:750,1:250,2)),mean(lab_img(700:750,1:250,3))];
%delta = [std(lab_img(700:750,1:250,1)),std(lab_img(700:750,1:250,2)),std(lab_img(700:750,1:250,3))];
mu = [mean(mean(lab_img(:,1:275,1))),mean(mean(lab_img(:,1:275,2))),mean(mean(lab_img(:,1:275,3)))];
delta = [std(std(lab_img(:,1:275,1))),std(std(lab_img(:,1:275,2))),std(std(lab_img(:,1:275,3)))];

contrast_img = zeros(size(lab_img, 1),size(lab_img, 2));

for r = 1:size(lab_img, 1)    % for number of rows of the image
    for c = 1:size(lab_img, 2)    % for number of columns of the image
        for cha = 1:size(lab_img, 3)   % loop of (3 RGB colors)
        
        
        
        contrast_img(r,c) = contrast_img(r,c) + alpha(cha)*a*exp(-1.*((lab_img(r,c,cha)- mu(cha)).^2)/(2*delta(cha)));
        
        
        
        
        end
    end
end

saliency_img = 1 - contrast_img;
figure('Name','Map');
imshow(contrast_img);
