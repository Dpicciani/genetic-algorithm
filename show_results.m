% genetic algorithm script
clear all; close all; clc;

i = 1;
filename_vec{i} = 'sppnw09.txt'; optimal_vec{i} = 67760; i = i+1;
filename_vec{i} = 'sppnw10.txt'; optimal_vec{i} = 68271; i = i+1;
filename_vec{i} = 'sppnw12.txt'; optimal_vec{i} = 14118; i = i+1;
filename_vec{i} = 'sppnw15.txt'; optimal_vec{i} = 67743; i = i+1;
filename_vec{i} = 'sppnw20.txt'; optimal_vec{i} = 16812; i = i+1;
filename_vec{i} = 'sppnw21.txt'; optimal_vec{i} = 7408; i = i+1;
filename_vec{i} = 'sppnw22.txt'; optimal_vec{i} = 6984; i = i+1;
filename_vec{i} = 'sppnw23.txt'; optimal_vec{i} = 12534; i = i+1;
filename_vec{i} = 'sppnw24.txt'; optimal_vec{i} = 6314; i = i+1;
filename_vec{i} = 'sppnw25.txt'; optimal_vec{i} = 5960; i = i+1;
filename_vec{i} = 'sppnw26.txt'; optimal_vec{i} = 6796; i = i+1;
filename_vec{i} = 'sppnw27.txt'; optimal_vec{i} = 9933; i = i+1;
filename_vec{i} = 'sppnw28.txt'; optimal_vec{i} = 8298; i = i+1;
filename_vec{i} = 'sppnw29.txt'; optimal_vec{i} = 4274; i = i+1;
filename_vec{i} = 'sppnw30.txt'; optimal_vec{i} = 3942; i = i+1;
filename_vec{i} = 'sppnw31.txt'; optimal_vec{i} = 8038; i = i+1;
filename_vec{i} = 'sppnw32.txt'; optimal_vec{i} = 14877; i = i+1;
filename_vec{i} = 'sppnw33.txt'; optimal_vec{i} = 6678; i = i+1;
filename_vec{i} = 'sppnw34.txt'; optimal_vec{i} = 10488; i = i+1;
filename_vec{i} = 'sppnw35.txt'; optimal_vec{i} = 7216; i = i+1;
filename_vec{i} = 'sppnw36.txt'; optimal_vec{i} = 7314; i = i+1;
filename_vec{i} = 'sppnw37.txt'; optimal_vec{i} = 10068; i = i+1;
filename_vec{i} = 'sppnw38.txt'; optimal_vec{i} = 5558; i = i+1;
filename_vec{i} = 'sppnw39.txt'; optimal_vec{i} = 10080; i = i+1;
filename_vec{i} = 'sppnw40.txt'; optimal_vec{i} = 10809; i = i+1;
filename_vec{i} = 'sppnw41.txt'; optimal_vec{i} = 11307; i = i+1;
filename_vec{i} = 'sppnw42.txt'; optimal_vec{i} = 7656; i = i+1;
filename_vec{i} = 'sppnw43.txt'; optimal_vec{i} = 8904;


foldername = strcat('.\results\');
%fprintf('[problem] [n rows] [n cols] [real optimal] [optimal found] [gap de optimalidade] [penalty] [time] [n feasible sol] [n iterations]\n');
fprintf('[problem] [real optimal] [optimal found] [gap de optimalidade]   [time]   [CPU time]   [feasible sol qtt] [n iterations] [feasible percentage]\n');
for idx = 1:i
  filename = filename_vec{idx}; optimal = optimal_vec{idx};

  % save results
  result_file = strcat(foldername, filename_vec{idx}(1:(end-4)),...
                       '_results.mat');
  load(result_file, 'model');
  
  % printf to display results in command line    
  fprintf('   %s        %05d          %05d             %.4f          %s   %08.3f           %04d            %05d             %07.4f \n',...
          upper(model.filename(4:7)),...
          model.optimal, model.P_costs(1,1), abs( model.optimal - model.P_costs(1,1))*100/model.optimal,...
          model.time, model.cpu_time, length(model.feasible_sol), model.generation, length(model.feasible_sol)*100/(model.generation*model.N_per_pop*model.N_pop));

        
  % printf for latex document
%   fprintf('\\multicolumn{1}{|c|}{%s} & \\multicolumn{1}{c|}{%05d} & \\multicolumn{1}{c|}{%05d} & %05d &  %.4f   &  %s   &  %08.3f  &  %04d   &   %05d & %06.3f \\\\\n',...
%           upper(model.filename(4:7)),...
%           model.optimal, model.optimal, model.P_costs(1,1), abs( model.optimal - model.P_costs(1,1))*100/model.optimal,...
%           model.time, model.cpu_time, length(model.feasible_sol), model.generation, length(model.feasible_sol)*100/(model.generation*model.N_per_pop*model.N_pop));
end
