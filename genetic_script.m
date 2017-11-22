% genetic algorithm script
clear all; close all; clc;

variables_declaration;

model_settings;

tic
model = model.run(model);
fprintf('- genetic algorithm elapsed time: %d,\n',toc);

display(model.best_P);

