function results = genetic_algorithm_improved_CPU(model)

% generate population and population costs
model.P = model.rand_P( model );
model.P_costs = model.f( model.P, model );

model.generation = 1;
while (model.generation < model.max_generation) &&...
      (model.optimal ~= model.P_costs(1,1) ||... % it is not optimal
       model.P_costs(1,2) ~= 0)                  % it is not feasible

  tic; children = [];
  parfor i = 1:model.N_new_pop
    % parent selection
    child = model.parent_selection(model);
    
    % crossover between individuals
    child = model.crossover(model, child);
    
    % mutation
    child = model.mutation(model, child);
    
    % heuristic improvement operator
    child = spp_heuristic_improvement(child, model);
    
    children = [children ; child];
  end
  model.C_n_pop = model.C_n_pop + size(children, 1);

  % individual selection for new generation
  model = model.i_selection(children, model);
 
  % adaptative step
  model = model.adapt(model);
  
  % plot based on evaluation function
  show_P_costs(1, model.P_costs, model.optimal, 'r*');
  
  print_state(model)
  model.generation = model.generation+1;
end

results = model;

end



%%
function print_state(model)

if model.P_costs(1,2) == 0  
    fprintf('- generation: %.4d/%d | feasible solutions: true | generation time: %d | no progress: %3d | best: [%d %d] | best total cost: [%d %d] \n',...
            model.generation, model.max_generation, toc,...
            model.no_progress, model.P_costs(1,1), model.P_costs(1,2),...
            sum(model.P_costs(1:model.N_best,1)),...
            sum(model.P_costs(1:model.N_best,2)));
else
    fprintf('- generation: %.4d/%d | feasible solutions: false | generation time: %d | no progress: %3d | best: [%d %d] | best total cost: [%d %d] \n',...
            model.generation, model.max_generation, toc,...
            model.no_progress, model.P_costs(1,1), model.P_costs(1,2),...
            sum(model.P_costs(1:model.N_best,1)),...
            sum(model.P_costs(1:model.N_best,2)));
end
end


% this part substitutes the parfor
%
%   while model.C_n_pop < (model.N_pop + model.N_new_pop)
%     % crossover between individuals
%     child = model.crossover(model);
% 
%     % mutation
%     child = model.mutation(model, child);
%           
%     % heuristic improvement operator
%     child = spp_heuristic_improvement(child, model);
%     
%     children = [children ; child];
%     if ~isempty(child), model.C_n_pop = model.C_n_pop + 2; end
%   end