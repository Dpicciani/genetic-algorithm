function [A, C] = load_instance(filepath)
% create sparse matrix from instance file

global SPARSE;

opt.filepath = filepath;
opt.delimiter = ' ';

data = get_data(opt, 0, 0, 0, 1);

n_rows = data(1); n_cols = data(2);

C = get_data(opt, 1, 0, n_cols, 1);
s_rows = C(:,2); % sparse rows
C = C(:,1)'; k = 1;
for j = 1:n_cols
  data = get_data(opt, j, 2, j, s_rows(j)+1);
  for i = 1:(s_rows(j))
    I(k,1) = data(i);
    J(k,1) = j;
    V(k,1) = 1;
    k = k + 1;
  end
end

A = sparse(I, J, V, n_rows, n_cols);

if ~SPARSE
  A = full(A);  
end

end

function data = get_data(opt, ul1, ul2, dr1, dr2)
% this function gets a certain part of a file
%
% opt properties:
%     opt.filepath
%     opt.delimiter
% ranges:
%     ul1 - upper left row
%     ul2 - upper left column
%     dr1 - down right row 
%     dr2 - down right column

  range = [ul1 ul2 dr1 dr2];
  data = dlmread(opt.filepath, opt.delimiter, range);
end