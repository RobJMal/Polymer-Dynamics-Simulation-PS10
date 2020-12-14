function cdf_slice = phi_cdf(theta, THETA, PHI, BOLTZMANN_2D, num_values, phi)
    % PDF of phi's that correspond to given theta 
    pdf_slice = interp2(THETA, PHI, BOLTZMANN_2D, theta.*ones(num_values, 1), phi');
    pdf_slice = pdf_slice / sum(pdf_slice);
    cdf_slice = cumsum(pdf_slice);
end