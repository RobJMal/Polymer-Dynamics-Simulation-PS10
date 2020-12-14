close all;
clear all;

% Loading in the files
load('Results_1D_Simulation_Temp_plot2.mat');
load('Results_2D_Simulation_Temp_plot2.mat');
load('Results_3D_Simulation_Temp_plot2.mat');

% Simulated temperature values for each case
max_temp = 10^4;
T_vals = [298:50:max_temp];

%% Extracting the final lengths at each force 
% 1D results
final_pos_1d = P_1d_dynamics_temp(1,10,:);
final_pos_1d = final_pos_1d(:)';

% 2D results
final_x_pos_2d = P_2d_dynamics_temp(1, 10, :);
final_x_pos_2d = final_x_pos_2d(:)';

final_y_pos_2d = P_2d_dynamics_temp(2, 10, :);
final_y_pos_2d = final_y_pos_2d(:)';

% Distance from origin to end point of chain 
final_dist_2d = sqrt(final_x_pos_2d.^2 + final_y_pos_2d.^2);

% 3D results
final_x_pos_3d = P_3d_dynamics_temp(1, 10, :);
final_x_pos_3d = final_x_pos_3d(:)';

final_y_pos_3d = P_3d_dynamics_temp(2, 10, :);
final_y_pos_3d = final_y_pos_3d(:)';

final_z_pos_3d = P_3d_dynamics_temp(3, 10, :);
final_z_pos_3d = final_z_pos_3d(:)';

% Distance from origin to end point of chain 
final_dist_3d = sqrt(final_x_pos_3d.^2 + final_y_pos_3d.^2 + final_z_pos_3d.^2);

%% Plotting 
plot(T_vals, final_pos_1d, 'b');
hold on;
plot(T_vals, final_x_pos_2d, 'r');
hold on;
plot(T_vals, final_z_pos_3d, 'color', [0 0.5 0]);
hold off; 

title("Final Lengths Comparison via Temperature Change");
xlabel("Temperature [K]");
ylabel("End chain position");
legend("1D", "2D", "3D");