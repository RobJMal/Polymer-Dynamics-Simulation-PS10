close all;
clear all;

load("Results_1D_Simulation_Force_plot2.mat");

n = 10; % Number of points on chain

% Finding max value 
max_val = max(P_1d_dynamics_force(1,:,:),[],'all');

% Finding min value 
min_val = min(P_1d_dynamics_force(1,:,:),[],'all');


% max_temp = 10^5;
% T_vals = [298:402:max_temp];

F_app = [0:25:6700];

h = figure;
axis tight manual % this ensures that getframe() returns a consistent size
filename = 'polymer_1d_simulation_force.gif';

for t=1:length(F_app)
    % Creating a plot 
    plot(P_1d_dynamics_force(:,:,t), [1:n], 'bo-');
    grid on; 
    title("1D Polymer Position Force Change (F_{app}=" + num2str(F_app(t)) + "*10^{-23}N)");
    xlabel('Position');
    ylabel('Chain Element');
    axis([min_val, max_val, 0, n]);

    % Mark the first point in red.
    hold on;
    plot(P_1d_dynamics_force(1), 1, 'go',...
        'MarkerFaceColor', 'g',...
        'MarkerSize', 5);
    text(P_1d_dynamics_force(1), 1, 'start');

    % Mark the end point in red.
    hold on;
    plot(P_1d_dynamics_force(1,10,t), n, 'ro',...
        'MarkerFaceColor', 'r',...
        'MarkerSize', 5);
    text(P_1d_dynamics_force(1,10,t), n, 'end');

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
