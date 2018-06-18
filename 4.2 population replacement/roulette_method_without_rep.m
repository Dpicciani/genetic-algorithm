function  updated_model = roulette_method_without_rep( model )

global GPU_ON;

P = model.P((model.N_best+1):end, :);
model.P = model.P(1:model.N_best, :);
P_costs = model.P_costs((model.N_best+1):end,:);
model.P_costs = model.P_costs(1:model.N_best,:);
Prob = get_prob(P_costs);

if GPU_ON, Prob = gather(Prob); end

k = 1; N_pop_rand = (model.N_pop - model.N_best);
while k <= N_pop_rand
  r = mnrnd(1, Prob);
  model.P = [model.P ; P(r~=0,:)];
  model.P_costs = [model.P_costs ; P_costs(r~=0,:)];
  P(r~=0,:) = [];
  P_costs(r~=0,:) = [];
  Prob = get_prob(P_costs);
  k = k+1;
end

model.C_n_pop = size(model.P,1);
updated_model = model;
end

function Prob =  get_prob(P_costs)

inv_P_costs = P_costs(:,1).^(-1);
Prob = inv_P_costs/sum(inv_P_costs);

end