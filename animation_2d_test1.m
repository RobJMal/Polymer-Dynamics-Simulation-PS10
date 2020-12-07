close all;
clear all;

load("Results_2D_Simulation.mat");

% Finding max value 
max_x = max(P_2d_dynamics(1,:,:),[],'all');
max_y = max(P_2d_dynamics(2,:,:),[],'all');

% Finding max value 
min_x = min(P_2d_dynamics(1,:,:),[],'all');
min_y = min(P_2d_dynamics(2,:,:),[],'all');

for t=1:size(P_2d_dynamics,3)
    plot(P_2d_dynamics(1,:,t), P_2d_dynamics(2,:,t), 'bo-');
    axis([min_x, max_x, min_y, max_y]);
    
    % Plotting the polymer movement 
    title("Polymer Position " + num2str(t) + " N");
    xlabel("X Position");
    ylabel("Y Position");
    
    % Mark the start point in green.
    hold on;
    plot(P_2d_dynamics(1,1,t), P_2d_dynamics(2,1,t), 'go',...
        'MarkerFaceColor', 'g',...
        'MarkerSize', 5);
    text(P_2d_dynamics(1,1,t), P_2d_dynamics(2,1,t), 'start');

    % Mark the end point in red.
    hold on;
    plot(P_2d_dynamics(1,10,t), P_2d_dynamics(2,10,t), 'ro',...
        'MarkerFaceColor', 'r',...
        'MarkerSize', 5);
    text(P_2d_dynamics(1,10,t), P_2d_dynamics(2,10,t), 'end');
    
    hold off; 
    
    pause(0.00001);
end


