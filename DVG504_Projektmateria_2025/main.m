% Voxels data set 1: "mri_head.raw", 256, 256, 256
% Voxels data set 2: "vismale.raw", 128,256, 256

clear; clc; close all;

% ladda egen bild
load mri;
test_volume = uint8(squeeze(D));  % eller uint16 / single beroende på krav
volumePerm = permute(test_volume, [2, 1, 3]);  % Från [Y, X, Z] → [X, Y, Z]
fid = fopen('test_mri_volume.raw', 'w');
fwrite(fid, volumePerm, 'uint8');  % eller annan typ om du ändrat
fclose(fid);

% === Ladda volymdata ===
 volume = loadVolume('test_mri_volume.raw',128,128,27); 
% volume = loadVolume('mri_head.raw',256,256,256);  
% volume = loadVolume('vismale.raw',128,256,256);  

% slica volymen på mitten i olika plan
xy = volume(:, :, round(end/2));
xz = volume(:, round(end/2), :);
yz = volume(round(end/2), :, :);

% === Inställningar ===
imageSize = [256, 256];
stepSize = 1.0;
volumeSize = size(volume);
cameraAngle = 0;  % För rotation (valfritt)

% === Rendera bild med DVR ===
renderedImage = raycastVolume(volume, imageSize, stepSize, cameraAngle);

% === Visa resultat ===
subplot(1,4,1);imshow(renderedImage);title('Direct Volume Rendering (DVR)');
subplot(1,4,2); imshow(squeeze(xy), []); title('XY');
subplot(1,4,3); imshow(squeeze(xz)', []); title('XZ');
subplot(1,4,4); imshow(squeeze(yz)', []); title('YZ');
