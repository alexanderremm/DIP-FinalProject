function normed = MinMaxNorm(im)
    % Function to normalize image between 0 and 1
    normed = (im-min(min(im))) / (max(max(im)) - min(min(im)));
end

