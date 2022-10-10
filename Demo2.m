clear; close all;
% Reconstructing a single image and show with animation
% By Arash Rabbani, www.Arashrabbani.com

A=imread('Data/Input.png');
[A2]=AugmentPattern(A,A.*0,8,1);

% A=imread('Data/Input2.png');
% [A2]=AugmentPattern(A,A.*0,8,1);

