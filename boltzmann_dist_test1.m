% Calculating probabilities of moving in certain angle direction
Boltzmann_Dist = makedist('Exponential', 'mu', 1).truncate(0, 2*pi);
sample = Boltzmann_Dist.random(10000, 1);
hist(sample, 10000);