function P = polymer_dynamics_1d(f_app, T, L, n)
    % Simulates a 1D freely-jointed polymer  
    %
    %   Params:
    %       f_app: applied force in x and y 
    %       T: temperature [K]
    %       L: length of individual link [m]
    %       n: number of links in chain 

    % Constants
    kB = 1.38;              % Boltzmann constant [J/K]
    
    % Chain setup
    P = zeros(1,n);
    P(:,1) = 0;             % Starting value
    
    F = f_app; 
    
    % Calculating probabilities of moving left and right 
    A = 1/(2*cosh(F*L/(kB*T)));    % Normalization factor
    p_left = A*exp(-F*L/(kB*T));
    p_right = A*exp(F*L/(kB*T));
    
    % Performing random walk 
    for i=2:n    % i is the number of steps from 1 to 10
        R = rand;
        S = 0; 

        if R < p_left
            S = -1;
        else
            S = 1;
        end

        P(i) = S+P(i-1); % Gives the next random walk from the new position P every time
    end     
end



