function  updated_model = tournament_method_without_rep( model )

[~, I, ~] = unique(model.P_costs, 'rows', 'stable');
model.P = model.P(I,:);
model.P_costs = model.P_costs(I,:);

P = model.P((model.N_best+1):end, :);
model.P = model.P(1:model.N_best, :);
P_costs = model.P_costs((model.N_best+1):end,:);
model.P_costs = model.P_costs(1:model.N_best,:);

% % delete copies
% [res, idx] = isCopy(P_costs, model.P_costs);
% if res == 1
%   P_costs(idx,:) = [];
%   P(idx,:) = [];
% end


k = 1; N_pop_rand = (model.N_pop - model.N_best);
while k <= N_pop_rand
  r = randi(size(P_costs,1), 2, 1);
  [~,I] = max(P_costs(r,1)); I = I(1);
  model.P = [model.P ; P(r(I),:)];
  model.P_costs = [model.P_costs ; P_costs(r(I),:)];
  P(r(I),:) = []; P_costs(r(I),:) = [];
  k = k+1;
end

model.C_n_pop = size(model.P,1);
updated_model = model;
end

%%
function [result, idx] = isCopy(P_costs1, P_costs2)

result = 0;
idx = [];

obj_copies = ismember(P_costs1(:,1), P_costs2(:,1));
pen_copies = ismember(P_costs1(:,2), P_costs2(:,2));

obj_copies = find(obj_copies == 1);
pen_copies = find(pen_copies == 1);

if ~isempty(obj_copies) && ~isempty(pen_copies)
  copies = ismember(obj_copies, pen_copies);
  copies = obj_copies(copies);
  
  if ~isempty(copies)
    result = 1; 
    idx = copies;
  end
end
end