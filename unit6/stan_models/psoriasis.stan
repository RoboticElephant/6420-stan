// Psoriasis: Two Sample Problem - Paired Data
data {
  int<lower=0> N;
  vector[N] baseline;
  vector[N] after;
}

transformed data {
  vector[N] diff = baseline - after;
}

parameters {
  real mu;
  real prec;
}

transformed parameters {
  real sigma = 1 / sqrt(prec);
  real ph1;
  ph1 = (mu >= 0 ? 1 : 0);
}

model {
  mu ~ normal(0, 316);
  prec ~ gamma(0.001, 0.001);

  diff ~ normal(mu, sigma);
}
