% Model Settings

global GPU_ON;
global SPARSE;
global LESS_MEMORY;

GPU_ON = true; % do calculations on GPU
SPARSE = false; % do calculations with sparse matrix
LESS_MEMORY = true; % do calculations with less memory use

format SHORT;

% set the randi generator as SIMD-oriented Fast Mersenne Twister 
rng('shuffle', 'simdTwister');

filepath = './instances/sppaa04';
% filepath = './instances/ex04';
%filepath = './instances/ex05';

% instance loading
tic
[model.A, model.C] = load_instance(filepath);
fprintf('- loading instance elapsed time: %d,\n',toc);
% load('matlab.mat');

% parameters
model.P_mut = 0.05;
model.P_cross = 0.30;
model.N_pop = 200;
model.N_new_pop = 0.3; 
model.P_best = 0.20;
model.Sol_dim = size(model.A, 2);
model.N_const = size(model.A, 1);
model.cross_E{1} = 0.5;
model.mut_E = 2;
model.lambda = 10;
model.stop = 100;

if GPU_ON
  tic
  model.A = gpuArray(model.A);
  model.P = gpuArray(model.P);
  model.C = gpuArray(model.C);
  fprintf('- loading GPU arrays elapsed time: %d,\n',toc);
end


% functions
model.par_selection = @roulette_method;
model.rand_P = @generate_random_population;
model.crossover = @crossover;
model.mutation = @mutation;
model.f = @evaluation_function;

% algorithm of metaheuristic
model.run = @genetic_algorithm;