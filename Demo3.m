clear; close all;
% Reconstructing a series of images as well as their labels
% By Arash Rabbani, www.Arashrabbani.com
A=imread('Data/Input2.png');
B=imread('Data/Label2.png');
N=10; % desired number of realization and label pairs to be created at "Output" directory
for I=1:10
    disp(['Creating realization # ' num2str(I)])
    [A2,B2]=AugmentPattern(A,B,8);
    B2=uint8(B2.*255);
    imwrite(A2,['Output/Output_' num2str(I) '_Image.png']);
    imwrite(B2,['Output/Output_' num2str(I) '_Label.png']);
end
disp('Files are saved in Output directory.')
