function [s3, s4] = crossover(s1, s2, model)

N = model.Sol_dim;
e = model.cross_E{1};

n = round(N*e);

s3 = [s1(1:n) s2((n+1):end)];
s4 = [s2(1:n) s1((n+1):end)];

end