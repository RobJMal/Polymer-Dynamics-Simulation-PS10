close all;
clear all; 

% Constants
kB = 1.38*10^(-23);             % Boltzmann constant [J/K]

% Setup and conditions 
Fx = 1*10^(-21);                % Applied force [Newtons], scaled for micro purposes 
Fy = 0;
F = [Fx, Fy]';

T = 298;                        % Temperature [K]

% Chain setup
L = 1;                          % Length of link [m]
n = 10;                         % Number of units 
P = zeros(2,n);
P(:,1) = 0;                     % Starting value

%% Performing 2D random walk 
for i=2:n    % i is the number of steps from 1 to 10
    
    L_unit = L*[cos(theta), sin(theta)]';
    
    
    theta = 0;
    
    theta = Boltzmann_Dist.random();
    
    dx = L*cos(theta);
    dy = L*sin(theta); 
    
    P(:,i) = [dx, dy]' + P(:,i-1); % Gives the next random walk from the new position P every time
end


% Creating a plot 
plot(P(1,:), P(2,:), 'bo-');
title('2D Random Walk (Realistic)');
xlabel('X Position');
ylabel('Y Position');
% 
% % Mark the first point in red.
% hold on;
% plot(P(1,1), P(2,1), 'go',...
%     'MarkerFaceColor', 'g',...
%     'MarkerSize', 5);
% text(P(1,1), P(2,1), 'start');
% 
% % Mark the end point in red.
% hold on;
% plot(P(1,n), P(2,n), 'ro',...
%     'MarkerFaceColor', 'r',...
%     'MarkerSize', 5);
% text(P(1,n), P(2,n), 'end');

%% Numerical integration
close all;
clear all; 

kB = 1.38*10^(-23);             % Boltzmann constant [J/K]
T = 298;                        % Temperature [K]

Fx = 1*10^(-18);                
Fy = 0; %1*10^(-20);  
F = [Fx, Fy]';

L = 1; 


fun = @(theta) exp((L*cos(theta)*Fx + L*sin(theta)*Fy)/(kB*T));
A = 1/integral(fun, 0, 2*pi);

theta = linspace(0, 2*pi, 1000);
CDF = zeros(size(theta));

% O(n^2)
% for i = 1:length(theta)
%     CDF(i) = A*integral(fun, 0, theta(i));
% end

CDF2 = [0 cumsum(A*fun(theta)*(theta(2)-theta(1)))];
CDF2 = CDF2(1:end-1);



plot(theta, fun(theta));

rand_vals = rand(1000, 1);
% To create a map from random numbers [0, 1] to theta vals [0, 2pi] while
% maintaing the Boltzmann distribution 
rand_theta = interp1(CDF2, theta, rand_vals);

polarscatter(rand_theta, ones(length(rand_theta), 1));

