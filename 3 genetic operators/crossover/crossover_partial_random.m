function [children] = crossover_partial_random(model)

global CPU_PAR;

if rand >= model.P_cross
    children = [];
    return;
end

N = model.Sol_dim;
e = model.cross_E{1};
n = round(N*e);

s1 = model.P(randi([1 model.N_pop]),:);
s2 = model.P(randi([1 model.N_pop]),:);

s3 = [s1(1:n) s2((n+1):end)];
s4 = [s2(1:n) s1((n+1):end)];

children = zeros(2, model.Sol_dim);
children(1,:) = s3; children(2,:) = s4;

model.C_n_pop = model.C_n_pop + 2;

end