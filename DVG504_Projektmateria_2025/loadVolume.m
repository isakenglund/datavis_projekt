function volume = loadVolume(filename,dx,dy,dz)
    fin=fopen(filename,'r');
    I=fread(fin,dx*dy*dz,'uint8=>uint8'); 
    volume=reshape(I,dx,dy,dz);
    volume = double(volume);    % Säkerställ flyttal
    volume = volume / max(volume(:));  % Normalisera till [0,1]
end
