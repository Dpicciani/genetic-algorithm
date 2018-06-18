function adapted_model = adaptative_step(model)

global changes;
global alternate_ranking;

level_1 = 20; max_changes = 20; adapt_step = 5;
no_progress = model.no_progress;
default = model.default;

if no_progress <= level_1
  % default model
    changes = 0;
    model.P_mut = default.P_mut;
    model.P_cross = default.P_cross;
    model.N_per_pop = default.N_per_pop; 
    model.N_new_pop =  default.N_new_pop;
    model.P_best = default.P_best;
    model.N_best = default.N_best;
    model.cross_E{1} = default.cross_E{1};
    model.mut_E = default.mut_E;
%     model.lambda = default.lambda;
%     model.update_best = @ranking_replacement_scheme;
    
elseif mod(no_progress, adapt_step) && changes < max_changes
  % model adaptation
    changes = changes+1;
    model.P_mut = default.P_mut + round((0.5 - default.P_mut)*(changes/max_changes), 3);
%     model.P_cross = default.P_cross + round((0.6 - default.P_cross)*(changes/max_changes), 3);
%     model.N_pop = default.N_pop + round( (250 - default.N_pop)*(changes/max_changes));
%     model.N_per_pop = default.N_per_pop + round((1 -  default.N_per_pop)*(changes/max_changes), 3); 
    model.N_new_pop = round(model.N_pop * model.N_per_pop);
%     model.P_best = 0.30;
%     model.N_best = round(model.P_best * model.N_pop);
    model.mut_E = round(model.Sol_dim * model.P_mut);
elseif mod(no_progress, adapt_step)
  if isempty(alternate_ranking)
    alternate_ranking = 0;
  end
  
%   if alternate_ranking == 0
%     model.update_best = @update_best_objective;
%     alternate_ranking = 1;
%   else
%     model.update_best = @update_best_penalty;
%     alternate_ranking = 0;
%   end
end

adapted_model = model;
end