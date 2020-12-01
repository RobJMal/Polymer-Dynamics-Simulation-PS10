% Demo to do a random walk in 2 dimensions.
% User is asked for the number of steps to take.
clc;    % Clear the command window.
clearvars;
close all;  % Close all figures (except those of imtool.)
workspace;  % Make sure the workspace panel is showing.
fontSize = 20;
format compact;

% Ask user for a number of steps to take.
defaultValue = 15;
titleBar = 'Enter an integer value';
userPrompt = 'Enter the number of steps to take: ';
caUserInput = inputdlg(userPrompt, userPrompt, 1, {num2str(defaultValue)});
if isempty(caUserInput),return,end; % Bail out if they clicked Cancel.
integerValue = round(str2num(cell2mat(caUserInput)));
% Check for a valid integer.
if isnan(integerValue)
    % They didn't enter a number.  
    % They clicked Cancel, or entered a character, symbols, or something else not allowed.
    integerValue = defaultValue;
    message = sprintf('I said it had to be an integer.\nI will use %d and continue.', integerValue);
    uiwait(warndlg(message));
end
numberOfSteps = integerValue;
deltax = rand(numberOfSteps) - 0.5;
deltay = rand(numberOfSteps) - 0.5;
xy = zeros(numberOfSteps,2);
for step = 2 : numberOfSteps
	% Walk in the x direction.
	xy(step, 1) = xy(step, 1) + deltax(step);	
	% Walk in the y direction.
	xy(step, 2) = xy(step, 2) + deltay(step);
	% Now plot the walk so far.
	xCoords = xy(1:step, 1);
	yCoords = xy(1:step, 2);
	plot(xCoords, yCoords, 'bo-', 'LineWidth', 2);
	hold on;
	textLabel = sprintf('%d', step);
	text(xCoords(end), yCoords(end), textLabel, 'fontSize', fontSize);
end

% Plot x and y axes
line(xlim, [0,0], 'Color', 'k', 'LineWidth', 2);
line([0,0], ylim, 'Color', 'k', 'LineWidth', 2);

% Mark the first point in red.
hold on;
plot(xy(1,1), xy(1,2), 'rs', 'LineWidth', 2, 'MarkerSize', 25);
textLabel = '1';
text(xy(1,1), xy(1,2), textLabel, 'fontSize', fontSize);
grid on;

% Mark the last point in red.
plot(xCoords(end), yCoords(end), 'rs', 'LineWidth', 2, 'MarkerSize', 25);
title('Random Walk', 'FontSize', fontSize);
xlabel('X', 'FontSize', fontSize);
ylabel('Y', 'FontSize', fontSize);

% Enlarge figure to full screen.
set(gcf, 'units','normalized','outerposition',[0 0 1 1]);

% Calculate the distance from the origin.
distanceFromOrigin = hypot(xCoords(end), yCoords(end));
message = sprintf('Done with demo!\nDistance of endpoint from origin = %.3f', distanceFromOrigin);
msgbox(message);
