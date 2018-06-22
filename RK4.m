% Runge Kutta Method 4th Order
% function @(x,y) e.g. f=@(x,y)(x+y);
% a = t span end
% t0 t span start
% y0 = initial condition of y
% for negative h and x0=x(T) solves equation from T to t0
% step size
function [t, x] = RK4(f,T,t0,x0,h,u0)
if (h<0) %switch T and t0
    T = T+t0;
    t0 = T-t0;
    T = (T-t0)/2;
end
number_of_steps = ceil((T-t0)/h);
t = t0:h:T;
if (number_of_steps*h ~= T-t0)
    t = [t T];
end
if (size(u0,2) == 1)
    u = repmat(u0,1,length(t));
else
    u = u0;
end
x(1:4, 1) = x0;


for i=1:(length(t)-2)
    k1 = f(t(i),x(:,i), u(:,i));
    k2 = f(t(i)+1/3*h,x(:,i)+1/3*h*k1, u(:,i));
    k3 = f((t(i)+2/3*h),(x(:,i)-1/3*h*k1+h*k2), u(:,i));
    k4 = f(t(i)+h,x(:,i)+k1*h-k2*h+k3*h, u(:,i));
    x(:, i+1) = x(:, i) + (1/8)*(k1+3*k2+3*k3+k4)*h;
end

if (length(t)<=1)
    return
end
h_last = t(end) - t(end-1); %length_of_last_step
i = length(t)-1;
k1 = f(t(i),x(:,i), u(:,i));
k2 = f(t(i)+1/3*h_last,x(:,i)+1/3*h_last*k1, u(:,i));
k3 = f((t(i)+2/3*h_last),x(:,i)-1/3*h_last*k1+k2*h_last, u(:,i));
k4 = f((t(i)+h_last),(x(:,i)+(k1-k2+k3)*h_last), u(:,i));
x(:, i+1) = x(:, i) + (1/8)*(k1+3*k2+3*k3+k4)*h_last;