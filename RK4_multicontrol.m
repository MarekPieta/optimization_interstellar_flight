%calculate quality index for given conditions and control signal
function [quality] = RK4_multicontrol(tau, u, f, T, t0, x0, h, x_set, ro)
    x = x0;
    t = [0];
    tau = [0 tau];
    u = [[0; 0], u];

    for j = 1:length(tau)-1
        [t_temp, x_temp] = RK4(f, tau(1, j+1), tau(1,j), x(:, end), h, u(1:2,j));
        t = [t t_temp(2:end)];
        x = [x x_temp(:, 2:end)];
    end   
    quality = J(tau(end), x(:,end), x_set, ro);
end