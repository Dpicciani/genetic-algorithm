function updated_model = update_best_individuals(model)

old_P_costs = model.P_costs((1:model.N_best),:);

[model.P_costs(:,1), I] = sort(model.P_costs(:,1));
model.P_costs(:,2) = model.P_costs(I,2);
model.P = model.P(I,:);

% feasible solutions
I = find(model.P_costs(:,2) == 0);
if ~isempty(I)
  P_aux = model.P_costs(I,:);
  model.P_costs(I,:) = [];
  model.P_costs = [P_aux ; model.P_costs];
  
  P_aux = model.P(I,:);
  model.P(I,:) = [];
  model.P = [P_aux ; model.P];
  
  n_I = length(I);
  for i = 1:n_I
%     if isempty(model.feasible_sol)
%       model.feasible_sol = [model.P_costs(I(i),1) , model.P(I(i),:)];
%     elseif ~ismember(model.P_costs(I(i),1), model.feasible_sol(:,1))
%       model.feasible_sol = [model.feasible_sol; ...
%                             model.P_costs(I(i),1) , model.P(I(i),:)];
%     end
    if ~ismember(model.P_costs(I(i),1), model.feasible_sol(:,1))
      model.feasible_sol = model.feasible_sol + 1;
    end
  end  
end

if isequal(old_P_costs,model.P_costs((1:model.N_best),:))
  model.no_progress = model.no_progress+1;
else
  model.no_progress = 0;
end

updated_model = model;
end