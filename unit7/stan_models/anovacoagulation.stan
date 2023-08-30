data {
  int<lower=0> N1;
  int<lower=0> N2;
  int<lower=0> N3;
  int<lower=0> N4;
  vector[N1] y1;
  vector[N2] y2;
  vector[N3] y3;
  vector[N4] y4;
}

parameters {
  real mu0;
  real<lower=0> tau;
  
  real alpha4;
  real alpha3;
  real alpha2;
}

transformed parameters {
  real alpha1 = -(alpha2 + alpha3 + alpha4);
  real mu1 = mu0 + alpha1;
  real mu2 = mu0 + alpha2;
  real mu3 = mu0 + alpha3;
  real mu4 = mu0 + alpha4;
}

model {
  mu0 ~ normal(0, 1 / sqrt(0.0001));
  tau ~ gamma(0.001, 0.001);
  
  alpha4 ~ normal(0, 1 / sqrt(0.0001));
  alpha3 ~ normal(0, 1 / sqrt(0.0001));
  alpha2 ~ normal(0, 1 / sqrt(0.0001));
  
  y1 ~ normal(mu1, 1 / sqrt(tau));
  y2 ~ normal(mu2, 1 / sqrt(tau));
  y3 ~ normal(mu3, 1 / sqrt(tau));
  y4 ~ normal(mu4, 1 / sqrt(tau));
}

generated quantities {
  real onetwo = alpha1 - alpha2;
  real onethree = alpha1 - alpha3;
  real onefour = alpha1 - alpha4;
  real twothree = alpha2 - alpha3;
  real twofour = alpha2 - alpha4;
  real threefour = alpha3 - alpha4;
}

