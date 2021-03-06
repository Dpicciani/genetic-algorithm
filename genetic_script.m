% genetic algorithm script
clear all; close all; clc; addpath(genpath('.\'));


i = 1;
% filename_vec{i} = 'sppnw08.txt'; optimal_vec{i} = 35894; i = i+1; % arquivo mal identado
filename_vec{i} = 'sppnw09.txt'; optimal_vec{i} = 67760; i = i+1;
filename_vec{i} = 'sppnw10.txt'; optimal_vec{i} = 68271; i = i+1;
filename_vec{i} = 'sppnw12.txt'; optimal_vec{i} = 14118; i = i+1;
filename_vec{i} = 'sppnw15.txt'; optimal_vec{i} = 67743; i = i+1;
% filename_vec{i} = 'sppnw19.txt'; optimal_vec{i} = 10898; i = i+1; % arquivo mal identado
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

foldername = datestr(datetime); foldername(foldername ==  ':') = ' ';
foldername = strcat('.\results\', foldername, '\');
mkdir(foldername);
for idx = 1:i
  filename = filename_vec{idx}; optimal = optimal_vec{idx};

  variables_declaration;
  
  % set all parameters
  model_settings;
    
  % run model
  model.time_init = datetime;
  model.cpu_time = cputime;
  try
    model = model.run(model); 
  catch
    save('flushed_results.mat');
  end

  % get time information
  model.cpu_time = cputime - model.cpu_time;
  model.time_end = datetime;
  model.time = model.time_end - model.time_init; 

  fprintf('\n- genetic algorithm elapsed time: %s,\n', model.time);
  display(model.P_costs(1:model.N_best, :));
  
  % save results
  output_file = strcat(foldername, filename_vec{idx}(1:(end-4)),...
                       '_results.mat');
  save(output_file);
end
