// The data that is input into the model
data {
  int<lower=0> N;
  vector[N] acetic;
  vector[N] h2s;
  vector[N] lactic;
  vector[N] y;
}

parameters {
  real b0;               // Intercept coefficient
  real b1;               // Slope coefficient
  real b2;
  real b3;
  real tau;
}

model {
  b0 ~ normal(0, 1 / sqrt(1e-5));
  b1 ~ normal(0, 1 / sqrt(1e-5));
  b2 ~ normal(0, 1 / sqrt(1e-5));
  b3 ~ normal(0, 1 / sqrt(1e-5));
  tau ~ gamma(0.001, 0.001);
  
  y ~ normal(b0 + b1 * acetic + b2 * h2s + b3 * lactic, 1 / sqrt(tau));
}

generated quantities {
  array[N] real y_hat;
  y_hat = normal_rng(b0 + b1 * acetic + b2 * h2s + b3 * lactic, 1 / sqrt(tau));
}
