% all variables

global GPU_ON;
global SPARSE;

model.P = [];             % population
model.P_costs = [];       % population costs
model.new_P = [];         % new population
model.best_P = [];        % index vector for best individuals
model.C = [];             % costs
model.A = [];             % constraints
model.N_const = 0;        % number of constraints
model.P_best = 0;         % percentage of population best individuals 
model.P_cross = 0;        % crossover probability
model.P_mut = 0;          % mutation probability
model.N_pop = 0;          % population quantity
model.N_new_pop = 0;      % percentage for new population quantity
model.Sol_dim = 0;        % solution dimension
model.cross_E = {};       % crossover edges
model.mut_E = 0;          % number of genes for mutation
model.lambda = 0;         % lagrangean multiplier (negative)
model.no_progress = 0;    % generations without improvement
model.stop = 0;           % maximum number of iterations
model.par = {};           % parents
model.par_selection = {}; % parents selection function
model.crossover = {};     % crossover function adopted
model.mutation = {};      % mutation function adopted
model.rand_P = {};        % function to generate random population
model.f = {};             % evaluation function
model.run = {};           % metaheuristic algorithm (genetic algorithm) 