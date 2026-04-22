library(gamboostLSS)

data("bodyfat", package = "TH.data")

model <- gamboostLSS(
  DEXfat ~ age + waistcirc + hipcirc,
  data = bodyfat,
  families = GaussianLSS()
)

summary(model)
