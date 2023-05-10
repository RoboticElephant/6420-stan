data {
  int<lower=0> N_smoker;
  int<lower=0> N_nonsmoker;
  vector[N_smoker] plasma_smoker;
  vector[N_nonsmoker] plasma_nonsmoker;
}

parameters {
  real<lower=0> tau_nonsmoker;
  real mu_nonsmoker;
  real<lower=0> tau_smoker;
  real mu_smoker;
}

model {
  tau_nonsmoker ~ gamma(0.0001, 0.0001);
  tau_smoker ~ gamma(0.0001, 0.0001);
  mu_nonsmoker ~ normal(0, 100); // equivalent to BUGS tau = 0.0001
  mu_smoker ~ normal(0, 100);
  
  plasma_smoker ~ normal(mu_smoker, 1 / sqrt(tau_smoker));
  plasma_nonsmoker ~ normal(mu_nonsmoker, 1 / sqrt(tau_nonsmoker));
}

generated quantities {
  real testmu;
  real r;
  
  testmu = (mu_smoker >= mu_nonsmoker ? 1 : 0);
  r = tau_nonsmoker / tau_smoker;
}