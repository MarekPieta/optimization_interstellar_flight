close all
clear all
clc

%test script

max_iter = 3;
t0 = 0; %start time
T = 1; % end time
x0 = [0.2; 0;0;0];
h = 0.01; %step
u1 = [1 -1 1 -1]; %control 1
u2 = [-1 -1 1 1]; %control 2

decision_vector_len = 12; % has to be divisible by 4

x_set = [0; 0; 0; 0];
ro = 20000;


lb = zeros(1,decision_vector_len);
ub = T * ones(1,decision_vector_len);

tau0 = linspace(t0, 0.99*T, decision_vector_len);
u = [repmat(u1, 1, decision_vector_len/4); repmat(u2, 1, decision_vector_len/4)];

RK4_h = @(tau)RK4_multicontrol(tau, u, @dxdt, T, t0, x0, h, x_set, ro);


A = -eye(decision_vector_len) + diag(ones(1,decision_vector_len-1), -1);

options=optimset('fmincon');
options=optimset(options,...
                'Display', 'iter', ...
                 'TolX',1e-20,...%12
                 'TolFun',1e-12,...%6
                 'TolCon',1e-10,...%6
                 'DiffMinChange',1e-20,...
                 'MaxFunEvals',5000);
res = fmincon(RK4_h, tau0, A, zeros(1,decision_vector_len), [], [], lb, ub, [] , options);
tau = res;

for i = 1:max_iter
    [tau0, u] = drop_times(tau, u, 0.001);
    decision_vector_len = length(tau0);
    lb = zeros(1,decision_vector_len);
    ub = T * ones(1,decision_vector_len);
    A = -eye(decision_vector_len) + diag(ones(1,decision_vector_len-1), -1);
    RK4_h = @(tau)RK4_multicontrol(tau, u, @dxdt, T, t0, x0, h, x_set, ro);
    res = fmincon(RK4_h, tau0, A, zeros(1,decision_vector_len), [], [], lb, ub, [] , options);
    tau = res;

end

[t, x] = RK4_multicontrol_sim(tau, u, @dxdt, tau(end), t0, x0, h, x_set, ro);
x = x';
t = t';
x_abs = absolute_coords(x, t);

print_trajectory(x,t,0)



%coupled differential equations
psi_T = - ro*(x_set' - x(end, :));
[t, psi] = RK4(@dpsidt, tau(end), t0, psi_T, -h, fliplr(x)');
figure
hold on
plot(t,psi)
plot(tau,0,'r*')
legend('psi1','psi2','psi3','psi4')
grid on;