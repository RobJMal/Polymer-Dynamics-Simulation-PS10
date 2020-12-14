tic

% Slowly increasing the applied force upward 
Fx = 0;
Fy = 0;
Fz = 6700;

F_app = [Fx;Fy;Fz];

% Setup of conditions and polymer chain
max_temp = 10^4;
T_vals = [298:50:max_temp];
L = 1; 
n = 10;

num_trials = 100; 

P_3d_dynamics_temp = zeros(3,n,size(T_vals,2));

parfor i=1:length(T_vals)      % Increasing the temperature
    T = T_vals(i);
    
    P_temp_i = zeros(3,n);
    
    for j=1:num_trials           % Running each trial 
        P_trial_j = polymer_dynamics_3d(F_app, T, L, n);
        P_temp_i = P_temp_i + P_trial_j; 
    end
    
    % Taking the average positions of polymer
    P_3d_dynamics_temp(:,:,i) = P_temp_i./num_trials;
    
    disp("On the " + num2str(i) + " iteration");
end

save('Results_3D_Simulation_Temp_plot2', 'P_3d_dynamics_temp'); 
toc

