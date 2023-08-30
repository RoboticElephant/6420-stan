data {
  real y;
  real s;
}

transformed data {
  real precy = sqrt(80);
  real precth = 0.0083333;
  real mu = 110;
}

parameters {
  real<lower=0.000001> d;
  real theta;
}

transformed parameters {
  real lb = mu - (d / precth)^0.5;
  real ub = mu + (d / precth)^0.5;
}

model {
  d ~ gamma(1.5, s / 2);
  theta ~ uniform(lb, ub);
  y ~ normal(theta, 1/sqrt(precy));
}
