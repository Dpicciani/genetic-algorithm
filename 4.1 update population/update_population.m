function updated_model = update_population(new_P, model)

model.P = [model.P; new_P];
model.P_costs = [model.P_costs; model.f(new_P, model)];
model.C_n_pop = model.C_n_pop + size(new_P,1);

updated_model = model;
end