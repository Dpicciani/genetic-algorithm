function child = parent_matching_selection(model)

% S1 selection - binary tournament based on fitness
k = 1;
while k <= model.N_pop
  r = randi(size(model.P_costs,1), 2, 1);
  [~,I] = max(model.P_costs(r,1)); I = I(1);
  S1 = model.P(r(I),:);
  k = k+1;
end

% P2 selection - selection based on maximum compatibility score
score = zeros(model.N_pop, 1);
for i = 1:model.N_pop
  score(i,1) = compatibility_score(S1, model.P(i,:));
end
[~, I] = max(score);
S2 = model.P(I,:);

child = [S1; S2];
end

function score = compatibility_score(S1,Si)

Cols_s1 = find(S1 == 1);
Cols_si = find(Si == 1);

I = unique([Cols_s1, Cols_si]);
term1 = length(I);

I = find(ismember(Cols_s1, Cols_si) == 1);
term2 = length(I);

score = term1 - term2;
end