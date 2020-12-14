% Max value of f_app component is 7200
f_app = [7200, 0]';
T = ;
L = 1; 
n = 10;

P = polymer_dynamics_2d(f_app, T, L, n);

% Creating a plot 
plot(P(1,:), P(2,:), 'bo-');
title('2D Random Walk');
xlabel('X Position');
ylabel('Y Position');

% Keep the tick sizes the same 
axis equal; 

% Mark the first point in red.
hold on;
plot(P(1,1), P(2,1), 'go',...
    'MarkerFaceColor', 'g',...
    'MarkerSize', 5);
text(P(1,1), P(2,1), 'start');

% Mark the end point in red.
hold on;
plot(P(1,n), P(2,n), 'ro',...
    'MarkerFaceColor', 'r',...
    'MarkerSize', 5);
text(P(1,n), P(2,n), 'end');