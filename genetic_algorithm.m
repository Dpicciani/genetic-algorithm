function results = genetic_algorithm(model)

model.P = model.rand_P( model );
model.P_costs = model.f( model.P, model );

k = 1;
while k < model.stop
  
  model.par = model.par_selection(model);
  
  if rand < model.P_cross
    model.par = model.crossover(model.par, model);
  elseif rand < model.P_mut
    model.par(1) = model_mutation(model.par(1));
    model.par(2) = model_mutation(model.par(2)); 
  end
  
  model.new_P(end+1:end+2, :) = model.par;
  
  
  k = k+1;
end




results = model;

end