tic

close all;
clear all; 

F_app = 6700;   % Applied force 

% Setup of conditions and polymer chain
max_temp = 10^4;
T_vals = [298:50:max_temp];
L = 1; 
n = 10;

num_trials = 100; 

P_1d_dynamics_temp = zeros(1,n,size(F_app,2));

num_trials = 100; 

for i=1:length(T_vals)       % Increasing the applied force value 
    T = T_vals(i); 
    
    P_temp_i = zeros(1,n);
    
    for j=1:num_trials       % Running each trial 
        P_trial_j = polymer_dynamics_1d(F_app, T, L, n);
        P_temp_i = P_temp_i + P_trial_j; 
    end
    
    % Taking the average positions of polymer
    P_1d_dynamics_temp(:,:,i) = P_temp_i./num_trials;
    
    disp("On the " + num2str(i) + " iteration");
end

save('Results_1D_Simulation_Temp_plot2', 'P_1d_dynamics_temp'); 

toc