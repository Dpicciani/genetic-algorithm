% Model Settings

global GPU_ON;
global CPU_PAR;
global SPARSE;
global LESS_MEMORY;
global TIME_VERBOSE;
global changes;

GPU_ON = false; % do calculations on GPU
CPU_PAR = true; % parallelize calculations on CPU
SPARSE = true; % do calculations with sparse matrix
LESS_MEMORY = true; % do calculations with less memory use
TIME_VERBOSE = false; % show time consuming of principal steps

changes = 0; % adaptation-step variable;

format SHORT;

if CPU_PAR
  pool = gcp('nocreate');
end

% set the randi generator as SIMD-oriented Fast Mersenne Twister 
rng('shuffle', 'simdTwister');

model.filename = filename;
filepath = strcat('./instances/', model.filename);

% instance loading
fprintf('- loading instance... ');
tic
[model.A, model.C] = load_instance(filepath);

% if SPARSE
%   load('sppaa04_SPARSE.mat');
% else
%   load('sppaa04_DOUBLE.mat');
% end

fprintf('OK | elapsed time: %d\n',toc);

% problem optimal
model.optimal = optimal;

% parameters
model.feasible_sol = [];
model.P_mut = 0.2;
model.P_cross = 1;
model.N_pop = 50;
model.C_n_pop = model.N_pop;
model.N_per_pop = 0.3; 
model.N_new_pop = round(model.N_pop * model.N_per_pop);
model.P_best = 0.30;
model.N_best = round(model.P_best * model.N_pop);
model.Sol_dim = size(model.A, 2);
model.N_const = size(model.A, 1);
model.cross_E{1} = 0.5;
model.mut_E = round(model.Sol_dim * model.P_mut);
model.lambda = 1;
model.generation = 1;
model.max_generation = 10000;

% rows covered by column j
for j = 1:model.Sol_dim, [model.beta{j},~,~] = find(model.A(:,j)== 1);end
  
% columns covered by row i
for i = 1:model.N_const, [~,model.alpha{i},~] = find(model.A(i,:)== 1);end
  
if GPU_ON
  tic
  model.A = gpuArray(model.A);
  model.P = gpuArray(model.P);
  model.C = gpuArray(model.C);
  fprintf('- loading GPU arrays elapsed time: %d,\n',toc);
end

% all functions

% generate population
model.rand_P = @generate_random_population;

% parent selection
% model.parent_selection = @random_parent_selection;
model.parent_selection = @parent_matching_selection;

% crossover
% model.crossover = @crossover_simple;
model.crossover = @crossover_full_random;

% mutation
model.mutation = @mutation;

% objective function with lagrangean penalization
model.f = @evaluation_function;

% update population with childrens
% model.update_P = @update_population;
model.update_P = @update_population_without_copies;

% a sort of ranking
% model.update_best = @update_best_individuals;
model.update_best = @update_best_penalty;
% model.update_best = @update_best_objective;

% selection of individuals for next generation
% model.i_selection = @tournament_method;
% model.i_selection = @tournament_method_without_rep;
% model.i_selection = @roulette_method;
model.i_selection = @ranking_replacement_scheme;

% adaptative step
model.adapt = @adaptative_step;

% algorithm of metaheuristic
if CPU_PAR
% model.run = @genetic_algorithm_CPU;
model.run = @genetic_algorithm_improved_CPU;
else
% model.run = @genetic_algorithm;
model.run = @genetic_algorithm_improved;
end

% save default parameters
model = generate_default_par(model);
