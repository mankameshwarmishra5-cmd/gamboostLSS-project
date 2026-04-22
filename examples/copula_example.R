# ------------------------------------------------------------
# Copula-based Example with gamboostLSS
# ------------------------------------------------------------

# Load libraries
library(gamboostLSS)
library(MASS)

set.seed(123)

# ------------------------------------------------------------
# Step 1: Simulate correlated data using Gaussian copula idea
# ------------------------------------------------------------

n <- 300

# Generate correlated predictors
Sigma <- matrix(c(1, 0.7, 0.7, 1), 2, 2)
X <- mvrnorm(n, mu = c(0, 0), Sigma = Sigma)

x1 <- X[, 1]
x2 <- X[, 2]

# Additional noise variables
x3 <- rnorm(n)
x4 <- rnorm(n)

# ------------------------------------------------------------
# Step 2: Generate responses with different distributions
# ------------------------------------------------------------

# Mean functions
mu1 <- 2 + 1.5 * x1 - x2
mu2 <- -1 + x1 + 2 * x2

# Variance functions (heteroscedastic)
sigma1 <- exp(0.5 * x1)
sigma2 <- exp(0.3 * x2)

# Responses
y1 <- rnorm(n, mean = mu1, sd = sigma1)
y2 <- rnorm(n, mean = mu2, sd = sigma2)

# ------------------------------------------------------------
# Step 3: Fit gamboostLSS models
# ------------------------------------------------------------

data1 <- data.frame(y1, x1, x2, x3, x4)
data2 <- data.frame(y2, x1, x2, x3, x4)

model_y1 <- gamboostLSS(
  y1 ~ x1 + x2 + x3 + x4,
  data = data1,
  families = GaussianLSS()
)

model_y2 <- gamboostLSS(
  y2 ~ x1 + x2 + x3 + x4,
  data = data2,
  families = GaussianLSS()
)

# ------------------------------------------------------------
# Step 4: Cross-validation
# ------------------------------------------------------------

cv_y1 <- cvrisk(model_y1)
cv_y2 <- cvrisk(model_y2)

model_y1 <- model_y1[mstop(cv_y1)]
model_y2 <- model_y2[mstop(cv_y2)]

# ------------------------------------------------------------
# Step 5: Results
# ------------------------------------------------------------

cat("Selected variables for Y1:\n")
print(coef(model_y1, which = 1))   # mu
print(coef(model_y1, which = 2))   # sigma

cat("\nSelected variables for Y2:\n")
print(coef(model_y2, which = 1))
print(coef(model_y2, which = 2))

# ------------------------------------------------------------
# Step 6: Interpretation
# ------------------------------------------------------------

cat("\nInterpretation:\n")
cat("Model captures variable importance and handles heteroscedasticity.\n")
cat("Correlation between predictors mimics dependency (copula-like behavior).\n")

# ------------------------------------------------------------
# Step 7: Visualizations
# ------------------------------------------------------------

# -----------------------------
# 1. Cross-validation plots
# -----------------------------
par(mfrow = c(1,2))
plot(cv_y1, main = "CV Risk (Y1)")
plot(cv_y2, main = "CV Risk (Y2)")


# -----------------------------
# 2. Coefficient paths (mu ONLY)
# -----------------------------
par(mfrow = c(1,2))
plot(model_y1, parameter = "mu", main = "Coeff Paths (Y1 - mu)")
plot(model_y2, parameter = "mu", main = "Coeff Paths (Y2 - mu)")


# -----------------------------
# 3. Predictions (Actual vs Predicted)
# -----------------------------
pred_y1 <- predict(model_y1, parameter = "mu", newdata = data1)
pred_y2 <- predict(model_y2, parameter = "mu", newdata = data2)

par(mfrow = c(1,2))

plot(data1$y1, pred_y1,
     main = "Y1: Actual vs Predicted",
     xlab = "Actual",
     ylab = "Predicted")
abline(0, 1, col = "red")

plot(data2$y2, pred_y2,
     main = "Y2: Actual vs Predicted",
     xlab = "Actual",
     ylab = "Predicted")
abline(0, 1, col = "red")


# -----------------------------
# 4. Sigma (variance behavior)
# -----------------------------
sigma_y1 <- predict(model_y1, parameter = "sigma", newdata = data1)
sigma_y2 <- predict(model_y2, parameter = "sigma", newdata = data2)

par(mfrow = c(1,2))

plot(data1$x1, sigma_y1,
     main = "Sigma vs X1 (Y1)",
     xlab = "x1",
     ylab = "sigma")

plot(data2$x2, sigma_y2,
     main = "Sigma vs X2 (Y2)",
     xlab = "x2",
     ylab = "sigma")


# ============================================================
#  SAVE IMPORTANT PLOTS 
# ============================================================

# Save CV plots
png("plots/copula_cv_plot.png")
par(mfrow = c(1,2))
plot(cv_y1, main = "CV Risk (Y1)")
plot(cv_y2, main = "CV Risk (Y2)")
dev.off()

# Save Sigma plot 
png("plots/hard_sigma_plot.png")
plot(data1$x1, sigma_y1,
     main = "Sigma vs X1 (Y1)",
     xlab = "x1",
     ylab = "sigma")
dev.off()
