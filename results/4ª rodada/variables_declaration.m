% all variables

global GPU_ON;
global CPU_PAR;
global SPARSE;
global LESS_MEMORY;

% constants
model.default = [];      % default configuration
model.optimal = 0;       % problem optimal, if it is known.

% matrices variables
model.P = [];             % population
model.P_costs = [];       % population costs
model.feasible_sol = [];  % feasible solutions
model.C = [];             % costs
model.A = [];             % constraints
model.alpha = {};         % beasley: columns which cover row i
model.beta = {};          % beasley: rows which cover column j

% vector variables
model.cpu_time = 0;       % cpu_time
model.N_const = 0;        % number of constraints
model.P_best = 0;         % percentage of population best individuals 
model.N_best = 0;         % number of best individuals
model.P_cross = 0;        % crossover probability
model.P_mut = 0;          % mutation probability
model.C_n_pop = 0;        % current population quantity
model.N_pop = 0;          % population quantity
model.N_per_pop = 0;      % percentage for new population quantity
model.N_new_pop = 0;      % new population quantity
model.Sol_dim = 0;        % solution dimension
model.cross_E = {};       % crossover ridge edges
model.mut_E = 0;          % number of genes for mutation
model.lambda = 0;         % lagrangean multiplier (negative)
model.no_progress = 0;    % generations without improvement
model.generation = 0;     % generation index
model.max_generation = 0; % maximum number of iterations

model.time = 0;           % time spent running the algorithm
model.time_init = 0;      % initial time
model.time_end = 0;       % end time

% functions variables
model.parent_selection = {}; % parent selection function
model.crossover = {};        % crossover function adopted
model.mutation = {};         % mutation function adopted
model.rand_P = {};           % function to generate random population
model.update_P = {};         % function to update population
model.update_best = {};      % function to update best solutions
model.i_selection = {};      % individual selection function
model.f = {};                % evaluation function
model.adapt = {};            % model adaptation function
model.run = {};              % metaheuristic algorithm (genetic algorithm) 