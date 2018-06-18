function  updated_model = tournament_method( model )

P = model.P((model.N_best+1):end, :);
model.P = model.P(1:model.N_best, :);
P_costs = model.P_costs((model.N_best+1):end,:);
model.P_costs = model.P_costs(1:model.N_best,:);

% tournament selection by fitness
k = 1; N_pop_rand = (model.N_pop - model.N_best);
while k <= N_pop_rand
  r = randi(size(P_costs,1), 2, 1);
  [~,I] = max(P_costs(r,1)); I = I(1);
  model.P = [model.P ; P(r(I),:)];
  model.P_costs = [model.P_costs ; P_costs(r(I),:)];
  k = k+1;
end

model.C_n_pop = size(model.P,1);
updated_model = model;
end