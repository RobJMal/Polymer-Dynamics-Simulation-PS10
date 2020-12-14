function P = polymer_dynamics_3d(f_app, T, L, n)
    % Simulates a 2D freely-jointed polymer  
    %
    %   Params:
    %       f_app: applied force in x, y, and z <3x1 vector>
    %       T: temperature [K]
    %       L: length of individual link [m]
    %       n: number of links in chain 

    % Constants
    kB = 1.38;              % Boltzmann constant [J/K]

    % Chain setup
    P = zeros(3,n);
    P(:,1) = 0;             % Starting value
    
    % Applied force
    Fx = f_app(1);
    Fy = f_app(2);
    Fz = f_app(3);
    
    num_values = 500; 
    theta = linspace(0, 2*pi, num_values);
    phi = linspace(0, pi, num_values);
    [THETA,PHI] = meshgrid(theta, phi);

    % p(theta, phi)
    BOLTZMANN_2D = exp(...
                (L*sin(PHI).*cos(THETA)*Fx + L*sin(PHI).*sin(THETA)*Fy + L*cos(PHI)*Fz)/(kB*T));
    BOLTZMANN_2D = BOLTZMANN_2D / sum(BOLTZMANN_2D(:));

    THETA_PDF = sum(BOLTZMANN_2D, 1);   % P(theta)
    THETA_CDF = [0 cumsum(THETA_PDF)];  % CDF(P(theta))
    
    % Performing 3D random walk 
    for i=2:n    
        rand_theta = rand;
        rand_phi = rand;

        sampled_theta = interp1(THETA_CDF, [0 theta], rand_theta);

        % Sample from the marginal dist p(phi | theta)
        sampled_phi = interp1([0; phi_cdf(sampled_theta, THETA, PHI, BOLTZMANN_2D, num_values, phi)], [0 phi], rand_phi);

        dx = L.*sin(sampled_phi).*cos(sampled_theta);
        dy = L.*sin(sampled_phi).*sin(sampled_theta);
        dz = L.*cos(sampled_phi);

        P(:,i) = [dx, dy, dz]' + P(:,i-1); % Gives the next random walk from the new position P every time
    end    
end

