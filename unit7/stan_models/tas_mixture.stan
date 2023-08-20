data {
  real df;
  real mu0;
  real tau1;
  real tau;
  real X;
  real Y;
}

parameters {
  real mu1;
  real mu2;
  real prec;
}

transformed parameters {
  real alpha = df / 2;
  real beta = df / (2.0 * tau);
}

model {
  mu1 ~ student_t(df, mu0, tau);
  X ~ normal(mu1, 1 / sqrt(tau1));
  
  prec ~ gamma(alpha, beta);
  mu2 ~ normal(mu0, 1 / sqrt(prec));
  Y ~ normal(mu2, 1 / sqrt(tau1));
}

