%Visualize trajectory x in relative and absolute coordinates.
%For flag==1 points with matching colors (locally) corresponds to
%the same moment in time (in absolute coords graph).

function print_trajectory(x,t,flag)
x_s = zeros(length(t), 4);
x_s = absolute_coords(x_s, t);
x_abs = absolute_coords(x, t);

figure(1);
plot(t, x);
grid on;
xlabel('t');
legend('position x', 'position y', 'velocity x', 'velocity y')
 
figure(2);
hold on;
plot(x(:,1), x(:,2));
plot(x(1,1), x(1,2), 'g*');
plot(x(end,1), x(end,2), 'r*');

grid on;
xlabel('position x');
ylabel('position y'); 
title('Relative coords');

color = 'rgby';
figure(3);
hold on;
if (flag)
    for i=50:50:length(t)
        plot(x_abs(i,1), x_abs(i,2),strcat('-',color(mod(i/50,4)+1),'*'));
        plot(x_s(i,1), x_s(i,2),strcat('-',color(mod(i/50,4)+1),'*'));
    end
else
    plot(x_abs(1,1), x_abs(1,2), 'g*');
    plot(x_abs(end,1), x_abs(end,2), 'r*');
    plot(x_s(1,1), x_s(1,2), 'b*');
    plot(x_s(end,1), x_s(end,2), 'b*');
    plot(x_abs(:,1), x_abs(:,2));
    plot(x_s(:,1), x_s(:,2));
end
grid on;
xlabel('position x');
ylabel('position y');
title('Absolute coords')

