function [ca_image] = context_aware(img)
%CONTEXT AWARE Function to compute Context Aware saliency map
%   Computes the Context Aware saliency map based on the following
%   paper: Context-Aware Saliency Detection (Goferman et al.)

% Resize the image to 250px along the longest dimension
[M,N,~] = size(img);
if M > N
    img = imresize(img, [250,NaN]);
else
    img = imresize(img, [NaN,250]);
end

% Convert the image to CIELab color space
img = rgb2lab(img);
%img(:,:,1) = MinMaxNorm(img(:,:,1));
%img(:,:,2) = MinMaxNorm(img(:,:,2));
%img(:,:,3) = MinMaxNorm(img(:,:,3));

% Perform saliency detection
[P,Q,~] = size(img);
sal_map = zeros([P,Q]);
for r = 1:P
    for c = 1:Q
        sal_map(r, c) = salient(img, r, c);
    end
end

% Resize and normalize output image
ca_image = uint8(255*MinMaxNorm(imresize(sal_map, [M,N])));

end

function d = color_dist(img, r, c, i, j)
    c1 = img(r,c,:);
    c2 = img(i,j,:);
    d = sqrt(((c1(1)-c2(1))^2) + ((c1(2)-c2(2))^2) + ((c1(3)-c2(3))^2));
end

function d = dissimilarity(img, r, c, i, j)
    d_c = color_dist(img, r, c, i, j);
    d_pos = sqrt((r-i)^2 + (c-j)^2) / max(size(img));
    d = d_c / (1 + 3 * d_pos);
end

function S = salient(img, r, c)
    K = 64;
    diffs = [];
    s = 0;
    [P,Q,~] = size(img);
    for i = 1:P
        for j = 1:Q
            diffs(end+1) = dissimilarity(img, r, c, i, j);
        end
    end
    diffs = sort(diffs);
    for i = 1:K
        s = s + diffs(i);
    end
    S = 1 - exp(-s/K);
end

% function d = color_dist(pi, qk)
%     l = (pi(1) - qk(:,:,1)).^2;
%     a = (pi(2) - qk(:,:,2)).^2;
%     b = (pi(3) - qk(:,:,3)).^2;
%     d = sqrt(l + a + b);
% end
% 
% function d = position_dist(img)
%     [P,Q,~] = size(img);
%     xrange = linspace(1,Q,Q);
%     yrange = linspace(1,P,P);
%     [x, y] = meshgrid(xrange, yrange);
%     pts = [x(:), y(:)];
%     d = pdist2(pts, pts);
% end

