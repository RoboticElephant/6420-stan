data {
  int<lower=0> N;
  int<lower=0> M;
  vector[N] y_type1;
  vector[M] y_type2;
}

parameters {
  real mu_type1;
  real mu_type2;
  real prec;
}

transformed parameters {
  real mudiff = mu_type1 - mu_type2;
  real sigma = 1 / sqrt(prec);
  real probint = ((mudiff + 2) >= 0 ? 1 : 0) * ((2 - mudiff) >= 0 ? 1 : 0);
}

model {
  mu_type1 ~ normal(10, 1 / sqrt(1e-5));
  mu_type2 ~ normal(10, 1 / sqrt(1e-5));
  prec ~ gamma(0.001, 0.001);
  
  y_type1 ~ normal(mu_type1, sigma);
  y_type2 ~ normal(mu_type2, sigma);
}

