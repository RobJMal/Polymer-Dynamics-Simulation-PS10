function P = polymer_dynamics_2d(f_app, T, L, n)
    % Simulates a 2D freely-jointed polymer  
    %
    %   Params:
    %       f_app: applied force in x and y <2x1 vector>
    %       T: temperature [K]
    %       L: length of individual link [m]
    %       n: number of links in chain 

    % Constants
    kB = 1.38;              % Boltzmann constant [J/K]

    % Chain setup
    P = zeros(2,n);
    P(:,1) = 0;             % Starting value
    
    % Applied force
    Fx = f_app(1);
    Fy = f_app(2);
    
    % Solving for normalization constant 
    Boltzmann_dist = @(theta) exp((L*cos(theta)*Fx + L*sin(theta)*Fy)/(kB*T));
    Normalization_const = 1/integral(Boltzmann_dist, 0, 2*pi);

    % Creating distribution to sample from 
    num_values = 100; 
    theta_vals = linspace(0, 2*pi, num_values);
    CDF = zeros(size(theta_vals));
    for i = 1:length(theta_vals)
        CDF(i) = Normalization_const*integral(Boltzmann_dist, 0, theta_vals(i));
    end
    
    CDF = zeros(length(theta_vals));
    d_theta = theta_vals(2) - theta_vals(1); 

    CDF = [0 cumsum(Normalization_const*Boltzmann_dist(theta_vals)*d_theta)];
    CDF = CDF(1:end-1);
   
    % Performing 2D random walk 
    for i=2:n    
        rand_val = rand; 
        theta = interp1(CDF, theta_vals, rand_val);

        dx = L*cos(theta);
        dy = L*sin(theta); 
        
        % Gives the next random walk from the new position P every time
        P(:,i) = [dx, dy]' + P(:,i-1); 
    end
        
end