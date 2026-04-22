# gamboostLSS Project

## 📌 Project Overview

This project demonstrates the use of **gradient boosting for distributional regression** using the **gamboostLSS** framework in R.

Unlike traditional regression models that only estimate the mean, **gamboostLSS** allows modeling of multiple distribution parameters such as:

* **Location (mean, μ)**
* **Scale (variance, σ)**
* **Shape parameters**

This makes it especially useful for complex real-world datasets where variability and distributional characteristics change with predictors.

---

## 🎯 Objectives

* Understand and implement distributional regression using gamboostLSS
* Apply boosting techniques for variable selection
* Evaluate model performance using cross-validation
* Visualize model behavior and results

---

## ✅ Tasks Completed

### 🔹 Easy Task

* Dataset: `mtcars`
* Objective: Predict **mpg (miles per gallon)** using:

  * `wt` (weight)
  * `hp` (horsepower)

#### ✔ Method:

* Fitted a **GaussianLSS model**
* Performed **cross-validation** to determine optimal boosting iterations

#### 📊 Results:

* Optimal boosting iterations:

  * μ (mean) = 100
  * σ (variance) = 60
* Model coefficients extracted for both parameters

#### 📈 Visualization:

* Cross-validation risk vs boosting iterations
* Demonstrates convergence and optimal stopping point

![Cross Validation Plot](plots/easy_plot.png)

This plot shows the cross-validation risk across boosting iterations.
The optimal stopping point corresponds to the minimum risk.

---

### 🔹 Hard Task

#### 📊 Data Simulation:

* Generated dataset with:

  * 500 observations
  * 20 predictor variables
* Only first **7 variables were informative**, rest were noise

#### ⚙️ Model Design:

* Two response variables: **Y1 and Y2**
* Each had:

  * Different mean (μ) functions
  * Different variance (σ) functions
* Dependency introduced using a **Gaussian copula**

#### 🧠 Model Fitting:

* Separate **GaussianLSS models** fitted for Y1 and Y2
* Applied **10-fold cross-validation** to determine optimal stopping

#### 📊 Results:

* **Y1 important variables:** X1, X2, X5
* **Y2 important variables:** X3, X4, X6
* Noise variables (X8–X20) were mostly ignored

#### 📈 Visualizations:

* Cross-validation plots
* Sigma (variance) behavior plots
* Demonstrates how variance changes with predictors

![Sigma Plot](plots/hard_sigma_plot.png)

This plot illustrates how the variance (sigma) changes with predictors,
highlighting the model’s ability to capture heteroscedasticity.

---

## 🧠 Key Takeaways

- The model successfully captures both mean (μ) and variance (σ)
- Important variables were correctly identified, while noise variables were ignored
- Variance changes with predictors, indicating heteroscedasticity
- Demonstrates advantage of distributional regression over traditional models

👉 Detailed analysis available in `notes/analysis.md`

---

## ▶️ How to Run

1. Install required packages:

```r
install.packages("gamboostLSS")
```

2. Run scripts:

```r
source("scripts/easy_task.R")
source("scripts/hard_task.R")
```

---

## 📁 Project Structure

```
gamboostLSS-project/
│
├── examples/
│ └── basic_example.R
│
├── experiments/
│ └── gaussian_lss_analysis.R
│
├── notes/
│ └── analysis.md
│
├── plots/
│ ├── easy_plot.png
│ └── hard_sigma_plot.png
│
├── scripts/
│ ├── easy_task.R
│ └── hard_task.R
│
├── README.md
└── gamboostLSS_project.Rproj
```

---

## 🔗 Repository Contents

* Easy Task R Script
* Hard Task R Script
* Visualizations and outputs

---

## 📚 Learning Outcome

Through this project, I learned:
- How gamboostLSS models multiple distribution parameters (μ and σ)
- How boosting helps in variable selection
- How variance (sigma) can change with predictors (heteroscedasticity)

This project helped me build a strong foundation in distributional regression.

---

## 🚀 Future Improvements

* Extend to copula-based dependency modeling
* Design and implement CopulaFamily() interface
* Integrate copula likelihood into boosting framework
* Apply model to multivariate real-world datasets

---

## 🙌 Acknowledgment

* This project was completed as part of preparation for **Google Summer of Code (GSoC)**, demonstrating understanding of distributional regression and boosting techniques.

---

## 🔗 Related Discussion

GitHub Issue:
https://github.com/boost-R/gamboostLSS/issues/62
