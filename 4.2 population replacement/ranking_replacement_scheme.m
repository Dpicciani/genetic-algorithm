function model_updated = ranking_replacement_scheme(children, model)

% get P_costs unmodified to compare at the end
old_P_costs = model.P_costs((1:model.N_best),:);

% cut the best solutions off to prevent changes
P_best = model.P(1:model.N_best, :);
P_best_costs = model.P_costs(1:model.N_best,:);

% update model without best solutions
model.P = model.P((model.N_best+1):end, :);
model.P_costs = model.P_costs((model.N_best+1):end,:);

% load internal function variables
P = model.P;
P_costs = [model.P_costs , (1:(model.N_pop - model.N_best))'];
C_costs = model.f(children, model);

% get feasible solutions 
if ~isempty(find((C_costs(:,2)==0),1))
  x=1;
end
f_sol = C_costs((C_costs(:,2) == 0), 1);
model.feasible_sol = [model.feasible_sol();...
                      f_sol(~ismember(f_sol,model.feasible_sol()))];

% delete copies on children
[C_costs,idx,~] = unique(C_costs,'rows','stable');
children = children(idx,:);

% delete children already on population
try
idx = ismember(C_costs, [P_best_costs; model.P_costs], 'rows');
C_costs(idx,:) = [];
children(idx,:) = [];
catch
display('error in ranking replacement scheme');
end

% plot P_costs
try
clf; show_P_costs(1, [P_best_costs; model.P_costs; C_costs], model.optimal, 'og');
catch
display('error in ranking replacement scheme');
end

% ranking replacement scheme
n_children = size(children, 1);
if n_children > (model.N_pop - model.N_best)
  N = (model.N_pop - model.N_best);
else
  N = n_children;
end
for i = 1:N
  % divide population in 4 groups based on a child
  G1 = []; G2 = []; G3 = []; G4 = [];
  for j = 1:size(P)
    if     P_costs(j,1) >= C_costs(i,1) && ...
           P_costs(j,2) >= C_costs(i,2)
      G1 = [G1; j];
      
    elseif P_costs(j,1)  < C_costs(i,1) && ...
           P_costs(j,2) >= C_costs(i,2)
      G2 = [G2; j];
      
    elseif P_costs(j,1) >= C_costs(i,1) && ...
           P_costs(j,2)  < C_costs(i,2)
      G3 = [G3; j];
      
    elseif P_costs(j,1)  < C_costs(i,1) && ...
           P_costs(j,2)  < C_costs(i,2)
      G4 = [G4; j];
      
    end
  end

  % substitute the worst individual of a non-empty group by a child using 
  % this priority:
  % G1 -> G2 -> G3 -> G4
  if ~isempty(G1)
    [~, I] = max(P_costs(G1,1)); if ~isempty(I), I = I(1); end
    model.P(P_costs(G1(I),3),:) = children(i,:);
    model.P_costs(P_costs(G1(I),3),:) = C_costs(i,:);
    P(G1(I),:) = []; P_costs(G1(I),:) = [];
  elseif ~isempty(G2)
    [~, I] = max(P_costs(G2,1)); if ~isempty(I), I = I(1); end
    model.P(P_costs(G2(I),3),:) = children(i,:);
    model.P_costs(P_costs(G2(I),3),:) = C_costs(i,:);
    P(G2(I),:) = []; P_costs(G2(I),:) = [];
  elseif ~isempty(G3)
    [~, I] = max(P_costs(G3,1)); if ~isempty(I), I = I(1); end
    model.P(P_costs(G3(I),3),:) = children(i,:);
    model.P_costs(P_costs(G3(I),3),:) = C_costs(i,:);
    P(G3(I),:) = []; P_costs(G3(I),:) = [];
  elseif ~isempty(G4)
    [~, I] = max(P_costs(G4,1)); if ~isempty(I), I = I(1); end
    model.P(P_costs(G4(I),3),:) = children(i,:);
    model.P_costs(P_costs(G4(I),3),:) = C_costs(i,:);
    P(G4(I),:) = []; P_costs(G4(I),:) = [];
  end
end

% replace best solutions back on model again
model.P = [P_best; model.P];
model.P_costs = [P_best_costs; model.P_costs];

% sort by unfitness
[model.P_costs(:,2), I] = sort(model.P_costs(:,2));
model.P_costs(:,1) = model.P_costs(I,1);
model.P = model.P(I,:);

% sort feasible solutions by fitness
fesible = model.P_costs(:,2) == 0;
[model.P_costs(fesible,1), I] = sort(model.P_costs(fesible,1));
model.P(fesible,:) = model.P(I,:);

% verify progress
if isequal(old_P_costs,model.P_costs((1:model.N_best),:))
  model.no_progress = model.no_progress+1;
else
  model.no_progress = 0;
end

model_updated = model;
end