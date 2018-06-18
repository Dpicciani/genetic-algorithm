function results = evaluation_function(S, model)
% This function calculates the evaluation function, i.e., the objective
% function with a penalty for infeasible solutions based on lagrangean
% multiplier. 
%
% s - it must be an horizontal vector

global GPU_ON;
global LESS_MEMORY

if isempty(S)
  results = [];
  return;
end

rep_shape = [size(S,1),1];
N = model.N_const;

% calculates objective function
if LESS_MEMORY
%   val = zeros(rep_shape(1), model.Sol_dim);
  for i = 1:rep_shape(1)
    val(i,:) = bsxfun(@times, model.C, S(i,:));
  end
  val = sum(val, 2);
else
  val = sum(bsxfun(@times, repmat(model.C, rep_shape), S), 2);
end

% sums a penalty for infeasible solutions
if LESS_MEMORY
%   for i = 1:rep_shape(1)
%     for j = 1:N
%       penalty(i, j) = 1 - sum(bsxfun(@times, model.A(j,:), S(i,:)), 2);
%     end
%   end
  
  if GPU_ON, penalty = zeros(N,rep_shape(1), 'gpuArray');
  else penalty = zeros(N,rep_shape(1)); end
  for i = 1:rep_shape(1)
    penalty(:, i) = ones(N,1) - sum(bsxfun(@times, model.A, kron(S(i,:), ones(N,1))), 2);
  end
  penalty = arrayfun(@abs,penalty);
  penalty = sum(penalty);
  penalty = model.lambda.*penalty';
  
else
  penalty = sum(bsxfun(@times, repmat(model.A, rep_shape), kron(S, ones(N,1))), 2);
  penalty = reshape(ones(model.N_const*rep_shape(1),1) - penalty, [N, rep_shape(1)]);
  penalty = arrayfun(@abs,penalty);
  penalty = sum(penalty);
  penalty = model.lambda.*penalty';
end

results = [val, penalty];
end