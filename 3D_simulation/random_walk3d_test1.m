close all;
clear all; 

kB = 1.38*10^(-23);             % Boltzmann constant [J/K]
T = 298;                        % Temperature [K]

Fx = -50*10^(-21);                
Fy = 0;
Fz = 0;
F = [Fx, Fy, Fz]';

L = 1; 

num_values = 200; 
theta = linspace(0, 2*pi, num_values);
phi = linspace(0, pi, num_values);
[THETA,PHI] = meshgrid(theta, phi);

BOLTZMANN_2D = exp(...
            (L*sin(PHI).*cos(THETA)*Fx + L*sin(PHI).*sin(THETA)*Fy + L*cos(PHI)*Fz)/(kB*T));
        
% p(theta, phi)
BOLTZMANN_2D = BOLTZMANN_2D / sum(BOLTZMANN_2D(:));

% p(theta)
THETA_PDF = sum(BOLTZMANN_2D, 1);
% CDF of p(theta)
THETA_CDF = [0 cumsum(THETA_PDF)];

% Values range between 0 and 1 
rand_theta = rand(num_values, 1);
rand_phi = rand(num_values, 1);

sampled_theta = interp1(THETA_CDF, [0 theta], rand_theta);

% Sample from the marginal dist p(phi | theta)
sampled_phi = interp1([0; phi_cdf(sampled_theta, THETA, PHI, BOLTZMANN_2D, num_values, phi)], [0 phi], rand_phi);

x = L.*sin(sampled_phi).*cos(sampled_theta);
y = L.*sin(sampled_phi).*sin(sampled_theta);
z = L.*cos(sampled_phi);
plot3(x,y,z,'ko','MarkerSize',5,'MarkerFaceColor','k')
grid

hold on; 

[X,Y,Z] = sphere;
hs1 = surf(X, Y, Z); 
set(hs1, 'FaceColor', [1 1 1])

xlabel("X Position");
ylabel("Y Position");
zlabel("Z Position");

% % To create a map from random numbers [0, 1] to theta vals [0, 2pi] while
% % maintaing the Boltzmann distribution 
% rand_theta = interp1(CDF, theta, rand_vals);
% 
% % polarscatter(rand_theta, ones(length(rand_theta), 1));

%% Testing plotting on a sphere
[x,y,z] = sphere;
figure
hs1 = surf(x,y,z);
hold on
hs2 = surf(x+3,y-2,z); % centered at (3,-2,0)
hs3 = surf(x,y+1,z-3); % centered at (0,1,-3)
q1 = get(hs1);
set(hs1, 'FaceColor', [1 1 1])
set(hs2, 'FaceColor', [0 1 0])
set(hs3, 'FaceColor', [0 0 1])
axis equal
