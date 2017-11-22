function s_m = mutation(s, model)

I = []; i = 1;
while i <= model.mut_E
  r = randi([1 model.Sol_dim]);
  if ~ismember(r, I)
    I(i) = r;
    i = i+1;
  else
    if i > 1, i = i-1;
    end
  end
end

s_m = s;
s_m(I) = ~s_m(I);
end