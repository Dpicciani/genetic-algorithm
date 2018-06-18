function  show_P_costs( fig, P_costs, optimal, opt )

global max_Y;
global max_X;

if isempty(max_X) && isempty(max_Y)
  max_Y = max(P_costs(:,1));
  max_X = max(P_costs(:,2));
else
  if max(P_costs(:,1)) > max_Y, max_Y = 3*max(P_costs(:,1)); end
  if max(P_costs(:,2)) > max_X, max_X = 5*max(P_costs(:,2)); end
  
  if 6*max(P_costs(:,1)) < max_Y, max_Y = 3*max(P_costs(:,1)); end
  if 15*max(P_costs(:,2)) < max_X, max_X = 5*max(P_costs(:,2)); end
end
  

figure(fig);
hold on;
set(gcf,'position',[969 49 944 947])
plot(P_costs(:, 2), P_costs(:,1), opt);
plot([0 max_X], [optimal optimal], '-b')
xlabel('Inviabilidade', 'fontSize', 28);
ylabel('Função objetivo', 'fontSize', 28);
axis([0 max_X 0 max_Y]);

pause(0.00001);

end