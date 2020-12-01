% Obtained from: https://www.mathworks.com/matlabcentral/answers/430248-how-do-i-plot-a-1-d-random-walk-that-generate-1-and-1-with-equal-probability-i-am-struggling-to-pl
% From user Torsten 

n = 10;
P = zeros(n,1);
P(1) = 0; % Starting value
for i=2:n    % i is the number of steps from 1 to 10
  R = rand;
  if R < 0.5
    S = -1;
  elseif R > 0.5
     S = 1;
  end
  P(i) = S+P(i-1) % Gives the next random walk from the new position P every time
end
ylabel('Position')
xlabel('Step Count')
title('1-D Random Walk')
plot(1:n,P)