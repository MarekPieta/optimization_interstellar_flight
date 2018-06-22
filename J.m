%quality index
function J = J(T, x_end, x_set, ro)
    J = T + 1/2.* ro * sum((x_set - x_end).^2); 
end

