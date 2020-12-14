close all;
clear all;

load("Results_3D_Simulation_Force.mat");

n = 10; % Number of points on chain

% Finding max value 
max_x = max(P_3d_dynamics(1,:,:),[],'all');
max_y = max(P_3d_dynamics(2,:,:),[],'all');
max_z = max(P_3d_dynamics(3,:,:),[],'all');

% Finding max value 
min_x = min(P_3d_dynamics(1,:,:),[],'all');
min_y = min(P_3d_dynamics(2,:,:),[],'all');
min_z = min(P_3d_dynamics(3,:,:),[],'all');

% max_temp = 10^5;
% T_vals = [298:402:max_temp];

Fz = [0:25:6700];

h = figure;
axis tight manual % this ensures that getframe() returns a consistent size
filename = 'polymer_3d_simulation_temp.gif';

for t=1:length(Fz)
    % Creating a plot 
    plot3(P_3d_dynamics(1,:,t), P_3d_dynamics(2,:,t),...
                            P_3d_dynamics(3,:,t), 'bo-');
    grid on; 
    title("3D Polymer Position Force Change (Fx=0; Fy=0; Fz=" + num2str(Fz(t)) + "*10^{-23}N)");
    xlabel('X Position');
    ylabel('Y Position');
    zlabel('Z Position');
    axis([min_x, max_x, min_y, max_y, min_z, max_z]);

    % Mark the first point in green.
    hold on;
    plot3(P_3d_dynamics(1,1,t), P_3d_dynamics(2,1,t), P_3d_dynamics(3,1,t),...
        'go',...
        'MarkerFaceColor', 'g',...
        'MarkerSize', 5);
    text(P_3d_dynamics(1,1,t), P_3d_dynamics(2,1,t), P_3d_dynamics(3,1,t), 'start');

    % Mark the end point in red.
    hold on;
    plot3(P_3d_dynamics(1,n,t), P_3d_dynamics(2,n,t), P_3d_dynamics(3,n,t), 'ro',...
        'MarkerFaceColor', 'r',...
        'MarkerSize', 5);
    text(P_3d_dynamics(1,n,t), P_3d_dynamics(2,n,t), P_3d_dynamics(3,n,t), 'end');
    
    hold off; 
    
%     % Creates the gif
%     drawnow
%     % Capture the plot as an image 
%     frame = getframe(h); 
%     im = frame2im(frame); 
%     [imind,cm] = rgb2ind(im,256); 
%     % Write to the GIF File 
%     if t == 1 
%       imwrite(imind,cm,filename,'gif', 'Loopcount',inf); 
%     else 
%       imwrite(imind,cm,filename,'gif','WriteMode','append','DelayTime',0.001); 
%     end 
end
