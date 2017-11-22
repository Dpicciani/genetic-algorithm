function P = generate_random_population( model )

rows = model.N_pop;
cols = model.Sol_dim;

P = randi( 0:1, rows, cols);

end