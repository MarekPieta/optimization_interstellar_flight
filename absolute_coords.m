%calculate absolute coords from coords in relation to space station
function [x_abs] = absolute_coords(x, t)
    x_abs(:, 1) = (x(:, 1) .* cos(t) - x(:, 2) .* sin(t)) + cos(t);
    x_abs(:, 2) = (x(:, 2) .* cos(t) + x(:, 1) .* sin(t)) + sin(t);
    x_abs(:, 3) = x(:, 3) - sin(t);
    x_abs(:, 4) = x(:, 4) + cos(t);