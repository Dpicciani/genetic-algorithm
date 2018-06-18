function [children] = crossover_full_random(model, s)

PROBABILITY_TO_CHANGE = 0.5;

s1 = s(1,:);
s2 = s(2,:);

if rand >= model.P_cross
%   children = zeros(2, model.Sol_dim);
%   children(1,:) = s1; children(2,:) = s2;
  children = [];
  return;
end

N = model.Sol_dim;
for i = 1:N
    if rand >= PROBABILITY_TO_CHANGE
    aux = s1(i);
    s1(i) = s2(i);
    s2(i) = aux;
    end
end

children = zeros(2, model.Sol_dim);
children(1,:) = s1; children(2,:) = s2;

model.C_n_pop = model.C_n_pop + 2;
end