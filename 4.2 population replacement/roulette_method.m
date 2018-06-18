function  updated_model = roulette_method( model )

global GPU_ON;

% calculates distribution propability
P = model.P((model.N_best+1):end, :);
model.P = model.P(1:model.N_best, :);
P_costs = model.P_costs((model.N_best+1):end,:);
model.P_costs = model.P_costs(1:model.N_best,:);
inv_P_costs = P_costs(:,1).^(-1);
Prob = inv_P_costs/sum(inv_P_costs);

if GPU_ON, Prob = gather(Prob); end

% get samples and do selection
k = 1; N_pop_rand = (model.N_pop - model.N_best);
while k <= N_pop_rand
  r = mnrnd(1, Prob);
  model.P = [model.P ; P(r~=0,:)];
  model.P_costs = [model.P_costs ; P_costs(r~=0,:)];
  k = k+1;
end

model.C_n_pop = size(model.P,1);
updated_model = model;
end