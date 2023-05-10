data {
  int<lower=0> N_obs;
  int<lower=0> N_mis;
  array[N_obs] int<lower=1, upper=N_obs + N_mis> iy_obs;  // index of obs y's
  array[N_mis] int<lower=1, upper=N_obs + N_mis> iy_mis;  // index of mis y's
  vector[N_obs + N_mis] X;
  vector[N_obs] y_obs;    // actual y values that were observed
}

transformed data {
  int<lower=0> N = N_obs + N_mis;  // total size of the input
}

parameters {
  real alpha;
  real beta;
  real gamma;
  real sigma;
  vector[N_mis] y_mis;  // account for missing y
}

transformed parameters {
  vector[N] Y;         // Imputed Y values
  Y[iy_obs] = y_obs;   // actual y values
  Y[iy_mis] = y_mis;   // missing y values
}

model {
  // priors
  alpha ~ uniform(0, 100);
  beta ~ uniform(0, 100);
  gamma ~ uniform(0, 1);
  sigma ~ uniform(-10, 10);
  
  Y ~ normal(alpha - beta * pow(gamma, X), sigma);
}

