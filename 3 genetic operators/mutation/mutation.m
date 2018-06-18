function s_m = mutation(model, child)

s_m = child;

if isempty(child), return; end

n_child = size(child, 1);
for idx = 1:n_child
  if rand < model.P_mut
%     I = []; i = 1;
%     while i <= model.mut_E
%       r = randi([1 model.Sol_dim]);
%       if ~ismember(r, I)
%         I(i) = r;
%         i = i+1;
%       else
%         if i > 1, i = i-1;
%         end
%       end
%     end
    I = randi([1 model.Sol_dim], 1, model.mut_E);
%     unique(I);
    
    s_m(idx,I) = ~s_m(idx,I);
  end
end
end