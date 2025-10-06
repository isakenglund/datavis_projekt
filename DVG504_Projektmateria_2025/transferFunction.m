function [color, alpha] = transferFunction(value)
    % Enkel tröskelbaserad överföringsfunktion
    if value < 0.2
        alpha = 0;
        color = [0, 0, 0];
    elseif value < 0.5
        alpha = 0.1;
        color = [0.7, 0.7, 0.9];
    else
        alpha = 0.4;
        color = [1, 1, 1];
    end
end
