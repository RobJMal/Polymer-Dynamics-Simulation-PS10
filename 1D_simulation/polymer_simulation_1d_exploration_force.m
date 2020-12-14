tic

close all;
clear all; 

% Slowly increasing the applied force to the right 
F_app = [0:25:6700];

% Setup of conditions and polymer chain
T = 298;
L = 1; 
n = 10;

num_trials = 100; 

P_1d_dynamics_force = zeros(1,n,size(F_app,2));

for i=1:length(F_app)       % Increasing the applied force value 
    f_app = F_app(i);
    
    P_f_app_i = zeros(1,n);
    
    for j=1:num_trials       % Running each trial 
        P_trial_j = polymer_dynamics_1d(f_app, T, L, n);
        P_f_app_i = P_f_app_i + P_trial_j; 
    end
    
    % Taking the average positions of polymer
    P_1d_dynamics_force(:,:,i) = P_f_app_i./num_trials;
    
    disp("On the " + num2str(i) + " iteration");
end

save('Results_1D_Simulation_Force_plot2', 'P_1d_dynamics_force'); 

toc
