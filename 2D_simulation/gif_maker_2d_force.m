close all;
clear all;

load("Results_2D_Simulation_Force.mat");

% Finding max value 
max_x = max(P_2d_dynamics(1,:,:),[],'all');
max_y = max(P_2d_dynamics(2,:,:),[],'all');

% Finding max value 
min_x = min(P_2d_dynamics(1,:,:),[],'all');
min_y = min(P_2d_dynamics(2,:,:),[],'all');

h = figure;
axis tight manual % this ensures that getframe() returns a consistent size
filename = 'polymer_2d_simulation_force.gif';

interest_frames = [1:23:7200];

for i=1:length(interest_frames)
    t = interest_frames(i);
    plot(P_2d_dynamics(1,:,t), P_2d_dynamics(2,:,t), 'bo-');
    axis([min_x, max_x, min_y, max_y]);
    
    % Plotting the polymer movement 
    title("2D Polymer Position Force Change (Fx = " + num2str(t) + "*10^{-23} N; Fy = 0 N)");
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
    
    drawnow
    % Capture the plot as an image 
    frame = getframe(h); 
    im = frame2im(frame); 
    [imind,cm] = rgb2ind(im,256); 
    % Write to the GIF File 
    if t == 1 
      imwrite(imind,cm,filename,'gif', 'Loopcount',inf); 
    else 
      imwrite(imind,cm,filename,'gif','WriteMode','append','DelayTime',0.001); 
    end 
end
