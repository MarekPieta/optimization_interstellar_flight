%removal of times of control value changes which are too close to each other
function[tau, u] = drop_times( tau0, u0, epsilon)
    indexes_to_remove = [];
    tau = tau0;
    u = u0;
    for i = 2:length(tau)
        if (abs(tau(i) - tau(i-1)) < epsilon)
            indexes_to_remove = [indexes_to_remove i-1];
        end
    end
    
    for i = length(indexes_to_remove):-1:1
        if (i+1 >= 2)
            tau = [tau(1:indexes_to_remove(i)-1) tau(indexes_to_remove(i)+1:end)];
            u = [u(:, 1:indexes_to_remove(i)-1) u(:, indexes_to_remove(i)+1:end)];
        else
            tau = tau(2:indexes_to_remove(i));
            u = u(:, 2:indexes_to_remove(i));
        end
    end
end

