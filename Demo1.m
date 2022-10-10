clear; close all;
% Augmenting labeled images
% This code generates reconstructed images and labels based on an original
% set of image and label
% By Arash Rabbani, www.Arashrabbani.com
A=imread('Data/Input.png');
B=imread('Data/Label.png');
figure; hold on; set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
n=3;
subplot(2,4,1);imshow(A)
title('Original Image')
subplot(2,4,2+n);imshow(B)
title('Original Label')
for I=1:n
    [A2,B2]=AugmentPattern(A,B,8);
    subplot(2,4,I+1);imshow(A2); title(['Reconstructed Image #' num2str(I)])
    subplot(2,4,I+1+n+1);imshow(B2); title(['Reconstructed Label #' num2str(I)])
    drawnow;
end
