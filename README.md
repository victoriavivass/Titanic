# 🚢 Titanic — Exploratory Data Analysis & Supervised Machine Learning (R)

This repository unifies two projects based on the classic **Titanic Kaggle dataset**:  
- **EDA**: Exploratory Data Analysis of passengers and survival patterns.  
- **Supervised ML**: Decision Tree modeling, tuning, and validation.

All analysis and modeling were implemented in **R**, using:  
> `ggplot2`, `dplyr`, `ggridges`, `car`, `Hmisc`, `caTools`, `rpart`, `rpart.plot`, `caret`, `randomForest`.

---

## Repository Structure

├── EDA/ # R scripts for exploratory analysis
├── supervised-ml/ # R scripts for supervised learning
├── .gitignore
└── README.md # (this file)


---

## Data

The dataset used is **`titanic_train.Rdata`**, which contains the training subset of the Titanic passenger data.

- The file is **not versioned** (ignored in `.gitignore`).  
- To reproduce results, place your `titanic_train.Rdata` file in the same directory used in your R scripts and adjust `setwd()` accordingly.

---

## Exploratory Data Analysis (EDA)

The EDA focuses on the **dependent variable `Survived`**, exploring its relationship with other features such as:
- **Fare**, **Pclass**, **Sex**, **Parch**, and **SibSp** (family/companionship).

### Key Analytical Steps

- Recoded `Survived` into a factor with labels `"Yes"` / `"No"`.
- Explored distributions of **Fare** by survival outcome using:
  - Histograms + density overlays (`geom_histogram`, `geom_density`).
  - Ridgelines (`ggridges`) to visualize **Fare** by **Passenger Class** and **Survival**.
- Created subsets to analyse **families and men traveling alone**:
  - Males with children: `Parch > 0 & Sex == "male"`.
  - Males traveling alone: `Parch == 0 & Sex == "male"`.
- Generated **violin + boxplots** and **violin + dotplots** of **Age** vs. **Survived**.
- Built a new binary variable **`travelingpartner`** based on `Parch + SibSp` to classify passengers as:
  - “With Partner” or “Without Partner”.
- Visualized survival rates:
  - Normalized stacked bars for overall survival rate.
  - Bar plots by **Sex**, faceted for comparison.

> The EDA suggests strong relationships between survival and **Sex**, **Class**, **Fare**, and whether the passenger traveled alone or with family.

---

## Preprocessing for Modeling

```r
# Convert Survived to a labeled factor
titanic.train$Survived <- factor(titanic.train$Survived, levels = c(0,1), labels = c("Died", "Survived"))

# Create hasCabin as a binary feature
titanic.train$hasCabin <- as.factor(ifelse(titanic.train$Cabin == "", 0, 1))

# Remove less informative columns
titanic.train[,"Ticket"] <- NULL
titanic.train[,"Cabin"] <- NULL
```

## Decision Tree Modeling
### 1. Initial Model — Hold-out Split (80/20)
Used `caTools::sample.split` to create training and test sets:
Evaluated with a confusion matrix and computed:
- Accuracy
- Sensitivity / Precision
- Specificity

Visualised variable importance using:

```r
firstTree$variable.importance
```

### 2. Hyperparameter Tuning — Grid Search + Cross Validation

Using manual folds created via `caret::createFolds`:

Explored parameter grid:
- `minsplit`: 2 → 40 (step = 2)
- `maxdepth`: 1 → 5
- `cp`: 10^-2 → 10^-4

For each combination:

Built a model, predicted on the held-out fold, and computed mean accuracy/sensitivity/specificity across folds.

### 3. Best Model

Trained with optimal parameters (example from your code):

```r
besttree <- rpart(
  Survived ~ .,
  data = trainingbest_set,
  method = "class",
  control = rpart.control(maxdepth = 5, minsplit = 18, cp = 0.001)
)
```

Visualised using:

```r
rpart.plot::prp(besttree)
```

Performance (test set):
- Accuracy ≈ 0.85–0.86
- Sensitivity and specificity vary depending on the random split.

### 4. Repeated Hold-out Validation (100 Repetitions)

Repeated 80/20 splits 100 times to estimate model stability.
- Metrics (accuracy, sensitivity, specificity) visualized via boxplots (ggplot2).
- Maximum accuracy ≈ 0.859.

### 5. K-fold Cross Validation (10 Folds)

Reused the best hyperparameters in 10-fold CV.
Boxplot visualizations show:
- Maximum accuracy ≈ 0.910
- Consistent performance across folds.

## Key Insights

Sex, Pclass, Fare, and hasCabin are the most influential predictors.
Passengers in higher classes, with cabin records, or traveling with companions had higher survival probabilities.

The final Decision Tree achieved:
- Repeated Hold-out: max accuracy ≈ 0.859
- 10-Fold CV: max accuracy ≈ 0.910

## How to Reproduce

### 1. Open R or RStudio
Set your working directory:
```r
setwd("C:/Users/Victoria/OneDrive/Escritorio/Intro a datos")
```
### 2. Load the dataset:
```r
load("titanic_train.Rdata")
```
### 3. Install required packages (first time only):
```r
pkgs <- c(
  "ggplot2","dplyr","ggridges","car","Hmisc",
  "caTools","rpart","rpart.plot","caret","randomForest"
)
to_install <- setdiff(pkgs, rownames(installed.packages()))
if (length(to_install)) install.packages(to_install, dependencies = TRUE)
lapply(pkgs, library, character.only = TRUE)
```
### 4. Run your EDA and modeling scripts:

- `EDA/` → visual and descriptive analysis
- `supervised-ml/` → model training, tuning, and validation

## Visual Outputs (examples)

- Histogram + density of Fare by survival outcome
- Ridgelines of Fare by Pclass
- Violin + boxplots of Age vs. Survived
- Survival rate bars (by companionship and Sex)
- Variable importance line plots
- Decision tree visualization (rpart.plot::prp)

## 👩‍💻 Author

Victoria Vivas
