function updated_model = update_population_without_copies(new_P, model)

new_P_costs = model.f(new_P, model);

penalty_copies = ismember(new_P_costs(:,2), model.P_costs(:,2));
objective_copies = ismember(new_P_costs(:,1), model.P_costs(:,1));

penalty_pos = find(penalty_copies == 1);
objective_pos = find(objective_copies == 1);

copies = ismember(penalty_pos, objective_pos);
copies = penalty_pos(copies);

new_P(copies,:) = [];
new_P_costs(copies,:) = [];

model.P = [model.P; new_P()];
model.P_costs = [model.P_costs; new_P_costs];
model.C_n_pop = model.C_n_pop + size(new_P,1);

updated_model = model;
end