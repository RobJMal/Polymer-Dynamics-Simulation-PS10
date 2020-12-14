tic

close all;
clear all; 

% Slowly increasing the applied force to the right 
Fx = [0:25:6700];
Fy = zeros(1,length(Fx));
F_app = [Fx; Fy];

% Setup of conditions and polymer chain
T = 298;
L = 1; 
n = 10;

num_trials = 100; 

P_2d_dynamics_force = zeros(2,n,size(F_app,2));

parfor i=1:size(F_app,2)       % Increasing the applied force value 
    fx = F_app(1,i);
    fy = F_app(2,i);
    f_app = [fx;fy];
    
    P_f_app_i = zeros(2,n);
    
    for j=1:num_trials       % Running each trial 
        P_trial_j = polymer_dynamics_2d(f_app, T, L, n);
        P_f_app_i = P_f_app_i + P_trial_j; 
    end
    
    % Taking the average positions of polymer
    P_2d_dynamics_force(:,:,i) = P_f_app_i./num_trials;
    
    disp("On the " + num2str(i) + " iteration");
end

save('Results_2D_Simulation_Force_plot2', 'P_2d_dynamics_force'); 
