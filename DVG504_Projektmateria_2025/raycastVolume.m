function img = raycastVolume(volume, imageSize, stepSize, cameraAngle)
    % Förenklad DVR med ray casting och sampling
    volSize = size(volume);
    img = zeros(imageSize(1), imageSize(2), 3);
    
    % Kamera i Z-riktning
    [X, Y] = meshgrid(linspace(1, volSize(2), imageSize(2)), ...
                      linspace(1, volSize(1), imageSize(1)));

    for i = 1:imageSize(1)
        for j = 1:imageSize(2)
            % Initiera färg och opacitet
            C_acc = [0, 0, 0];
            alpha_acc = 0;
            
            % Startpunkt för ray (från framsidan av volymen)
            x = X(i,j);
            y = Y(i,j);
            
            for z = 1:stepSize:volSize(3)
                % Interpolera (enkel nearest neighbor här)
                xi = round(x); yi = round(y); zi = round(z);
                if xi < 1 || yi < 1 || zi < 1 || ...
                   xi > volSize(2) || yi > volSize(1) || zi > volSize(3)
                    continue;
                end
                
                val = volume(yi, xi, zi);
                
                [C_sample, alpha_sample] = transferFunction(val);
                
                % Front-to-back kompositing
                C_acc = C_acc + (1 - alpha_acc) * alpha_sample * C_sample;
                alpha_acc = alpha_acc + (1 - alpha_acc) * alpha_sample;
                
                if alpha_acc > 0.99
                    break;  % Tidig terminering
                end
            end
            img(i, j, :) = C_acc;
        end
    end
end