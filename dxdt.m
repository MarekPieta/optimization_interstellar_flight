%differential equation to describe movement of rocket in relation to
%space station
function dxdt = dxdt ( t, x, u )
    r = ((x(1)+1).^ 2 + x(2).^2).^(1/2) ;
    dxdt(1) = x(3);
    dxdt(2) = x(4);
    dxdt(3) = 2.*x(4) + (1+x(1)).*(1-r.^(-3)) + u(1);
    dxdt(4) = -2.*x(3) + x(2).*(1-r.^(-3)) + u(2);
    dxdt = dxdt';
end

