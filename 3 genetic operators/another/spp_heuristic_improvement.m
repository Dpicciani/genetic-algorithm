function S_improved = spp_heuristic_improvement(solutions, model)

S_improved = [];

if isempty(solutions), return; end

alpha = model.alpha; beta = model.beta;

n_sol = size(solutions,1);
for s_idx = 1:n_sol
  S = solutions(s_idx,:);
  
  % load parameter w
  for i = 1:model.N_const, w(i) = sum(S(alpha{i})); end
  
  T = find(S == 1); t = length(T);
  while t ~= 0 %~isempty(T)
    idx = randi(t); j = T(idx); T(idx) = []; t = t-1;
    
    i = find((w(beta{j}) >= 2) == 0, 1);
    if isempty(i)
      S(j) = ~S(j);
      w(beta{j}) = w(beta{j}) - 1;
    end
  end
  
  U = find(w == 0); V = U;
  while ~isempty(V)
    idx = randi(length(V)); i = V(idx); V(idx) = [];
    
    j = search_column(alpha{i}, beta, U, model);
    
    if ~isempty(j)
      S(j)=~S(j);
      w(beta{j}) = w(beta{j})+1;
      U(ismember(U,beta{j})) = [];
      V(ismember(V,beta{j})) = [];
    end
  end
  
  S_improved = [ S_improved; S];
end

end

function j = search_column(alpha_i, beta, U, model)
% search column j in alpha{i} that satisfies beta{j} belonging to U, and
% minimises c(j)/|beta{j}|

j = []; norm_beta_j = 0; k = 1;
j_len = length(alpha_i);
for i = 1:j_len
  aux = find( ismember(beta{alpha_i(i)}, U) == 0, 1);
  if isempty(aux)
    j = [j ; alpha_i(i)];
    norm_beta_j(k) = sum(beta{alpha_i(i)});
    k = k+1;
  end
end

if isempty(find(norm_beta_j == 0,1)) && ~isempty(j)
  [~, pos] = min(model.C(j)./norm_beta_j);
  j = j(pos);
  j = j(1);
end
end