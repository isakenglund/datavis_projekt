% Voxels data set 1: "mri_head.raw", 256, 256, 256
% Voxels data set 2: "vismale.raw", 128,256, 256 

clear; clc; close all;

% === Ladda volymdata ===
volume = loadVolume('mri_head.raw',256,256,256);  
% volume = loadVolume('vismale.raw',128,256,256);  

% === Inställningar ===
imageSize = [256, 256];
stepSize = 1.0;
volumeSize = size(volume);
cameraAngle = 0;  % För rotation (valfritt)

% === Rendera bild med DVR ===
renderedImage = raycastVolume(volume, imageSize, stepSize, cameraAngle);

% === Visa resultat ===
imshow(renderedImage);
title('Direct Volume Rendering (DVR)');
