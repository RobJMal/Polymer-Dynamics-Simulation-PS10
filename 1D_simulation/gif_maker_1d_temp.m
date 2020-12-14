close all;
clear all;

load("Results_1D_Simulation_Temp_plot2.mat");

n = 10; % Number of points on chain

% Finding max value 
max_val = max(P_1d_dynamics_temp(1,:,:),[],'all');

% Finding min value 
min_val = min(P_1d_dynamics_temp(1,:,:),[],'all');

% Setup of conditions and polymer chain
max_temp = 10^4;
T_vals = [298:50:max_temp];

h = figure;
axis tight manual % this ensures that getframe() returns a consistent size
filename = 'polymer_1d_simulation_temp.gif';

for t=1:length(T_vals)
    % Creating a plot 
    plot(P_1d_dynamics_temp(:,:,t), [1:n], 'bo-');
    grid on; 
    title("1D Polymer Position Temperature Change (T=" + num2str(T_vals(t)) + " K)");
    xlabel('Position');
    ylabel('Chain Element');
    axis([min_val, max_val, 0, n]);

    % Mark the first point in red.
    hold on;
    plot(P_1d_dynamics_temp(1), 1, 'go',...
        'MarkerFaceColor', 'g',...
        'MarkerSize', 5);
    text(P_1d_dynamics_temp(1), 1, 'start');

    % Mark the end point in red.
    hold on;
    plot(P_1d_dynamics_temp(1,10,t), n, 'ro',...
        'MarkerFaceColor', 'r',...
        'MarkerSize', 5);
    text(P_1d_dynamics_temp(1,10,t), n, 'end');

    hold off; 
    
    % Creates the gif
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