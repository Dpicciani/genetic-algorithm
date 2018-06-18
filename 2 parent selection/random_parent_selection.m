function child = random_parent_selection(model)

s1 = model.P(randi([1 model.N_pop]),:);
s2 = model.P(randi([1 model.N_pop]),:);

child = [s1; s2];
end