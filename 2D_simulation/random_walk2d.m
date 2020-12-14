% Obtained from: https://www.mathworks.com/matlabcentral/answers/430248-how-do-i-plot-a-1-d-random-walk-that-generate-1-and-1-with-equal-probability-i-am-struggling-to-pl
% From user Torsten 

n = 10;
P = zeros(2,n);
P(:,1) = 0; % Starting value

%% Performing 2D random walk 
% Steps are size 1
for i=2:n    % i is the number of steps from 1 to 10
    % Issue: projection into the x 
    % Test: plot thousands of times 
    % Randomly select from 0 to 2 pi 
  dx = rand; 
  dy = sqrt(1-(dx^2));
  
  disp(dx^2 + dy^2);
  
  % Determing if step should be positive (right, up) or negative (left,
  % down)
  sign_x = rand;
  sign_y = rand; 
  
  if sign_x < 0.5
      dx = -1*dx;
  end
  
  if sign_y < 0.5
      dy = -1*dy;
  end

  P(:,i) = [dx, dy]' + P(:,i-1); % Gives the next random walk from the new position P every time
end

%% Plotting results of 2D random walk 
figure(1); 
plot(P(1,:), P(2,:), '-bo');
ylabel('Position');
xlabel('Step Count');
title('2-D Random Walk');

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