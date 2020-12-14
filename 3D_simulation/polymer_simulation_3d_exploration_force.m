tic

close all;
clear all;

% Slowly increasing the applied force upward 
Fz = [0:25:6700];
Fx = zeros(1,length(Fz));
Fy = zeros(1,length(Fz));

F_app = [Fx;Fy;Fz];

% Setup of conditions and polymer chain
T = 298;
L = 1; 
n = 10;

num_trials = 100; 

P_3d_dynamics_force = zeros(3,n,size(F_app,2));

parfor i=1:size(F_app,2)       % Increasing the applied force value 
    fx = F_app(1,i);
    fy = F_app(2,i);
    fz = F_app(3,i);
    f_app = [fx;fy;fz];
    
    P_f_app_i = zeros(3,n);
    
    for j=1:num_trials           % Running each trial 
        P_trial_j = polymer_dynamics_3d(f_app, T, L, n);
        P_f_app_i = P_f_app_i + P_trial_j; 
    end
    
    % Taking the average positions of polymer
    P_3d_dynamics_force(:,:,i) = P_f_app_i./num_trials;
    
    disp("On the " + num2str(i) + " iteration");
end

save('Results_3D_Simulation_Force_plot2', 'P_3d_dynamics_force'); 
toc
