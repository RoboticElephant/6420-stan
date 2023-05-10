data {
  int<lower=0> N_obs;
  int<lower=0> N_cens;
  array[N_obs] real y_obs;
  real<lower=max(y_obs)> U;
}

transformed data {
  real alpha = 0.01;
  real beta = 0.1;
}

parameters {
  array[N_cens] real<lower=U> y_cens;
  real lambda;
}

transformed parameters {
  real mu = 1 / lambda;
}

model {
  lambda ~ gamma(alpha, beta);
  y_obs ~ exponential(lambda);
  y_cens ~ exponential(lambda);
}

