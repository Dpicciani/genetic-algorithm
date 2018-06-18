function model_updated = generate_default_par(model)

model.default.P_mut = model.P_mut;
model.default.P_cross = model.P_cross;
model.default.N_pop = model.N_pop;
model.default.C_n_pop = model.C_n_pop;
model.default.N_per_pop = model.N_per_pop; 
model.default.N_new_pop = model.N_new_pop;
model.default.P_best = model.P_best;
model.default.N_best = model.N_best;
model.default.Sol_dim = model.Sol_dim;
model.default.N_const = model.N_const;
model.default.cross_E{1} = model.cross_E{1};
model.default.mut_E = model.mut_E;
model.default.lambda = model.lambda;
model.default.generation = model.generation;
model.default.max_generation = model.max_generation;


model.default.rand_P = model.rand_P;
model.default.crossover = model.crossover;
model.default.mutation = model.mutation;
model.default.f = model.f;
model.default.update_P = model.update_P;
model.default.update_best = model.update_best;
model.default.i_selection = model.i_selection;
model.default.adapt = model.adapt;

model_updated = model;
end