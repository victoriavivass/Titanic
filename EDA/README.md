# Titanic-EDA
A comprehensive Exploratory Data Analysis (EDA) of the Titanic dataset to explore trends and relationships within the data.  

# Titanic EDA Project
This repository contains an Exploratory Data Analysis (EDA) performed on the famous Titanic dataset. The goal of this analysis is to better understand the characteristics of the passengers and uncover patterns that might be associated with survival.

## Table of Contents
1. [Project Description](#project-description)
2. [Dataset Summary](#dataset-summary)
3. [Files in the Repository](#files-in-the-repository)
4. [Installation and Usage](#installation-and-usage)
5. [Results](#results)

## Project Description
This exploratory analysis was implemented to inspect and understand the main variables in the Titanic dataset, with a special focus on the target variable `Survived`. R and various libraries were used for data visualization and manipulation.

## Dataset Summary
The Titanic dataset contains the following variables that describe characteristics of the passengers and their survival status:

- **PassengerId**: Unique identifier for each passenger.
- **Survived**: Indicates if the passenger survived (`1`) or not (`0`).
- **Pclass**: Passenger class (1 = 1st, 2 = 2nd, 3 = 3rd).
- **Name**: Full name of the passenger.
- **Sex**: Gender of the passenger.
- **Age**: Age of the passenger in years.
- **SibSp**: Number of siblings and/or spouses aboard the Titanic.
- **Parch**: Number of parents and/or children aboard the Titanic.
- **Ticket**: Ticket number.
- **Fare**: Fare paid by the passenger.
- **Cabin**: Cabin number where the passenger stayed.
- **Embarked**: Port of embarkation (C = Cherbourg; Q = Queenstown; S = Southampton).

These variables are analyzed in detail to explore relationships and trends, particularly focusing on how they relate to the likelihood of survival.

## Files in the Repository
- **`script titanic.R`**: Main R script containing the exploratory data analysis.
- **`README.md`**: This file, which describes the project.
- **`EDA_Titanic_IntroDSProject1.pdf`**: PDF report with the final results of the exploratory analysis.

## Installation and Usage
1. **Clone the repository**:
   ```bash
   git clone https://github.com/victoriavivass/Titanic-EDA.git
   cd Titanic-EDA
## Results
The results of this EDA are documented in the [**EDA_Titanic_IntroDSProject1.pdf**](./results/EDA_Titanic_IntroDSProject1.pdf) file. This report includes insights and visualizations based on the analysis, covering:

- [**Survival Rates**](./results/EDA_Titanic_IntroDSProject1.pdf): Overall survival rates and breakdown by class, gender, and age.
- [**Passenger Demographics**](./results/EDA_Titanic_IntroDSProject1.pdf): Age distributions and gender ratios among the different classes.
- [**Fare and Class**](./results/EDA_Titanic_IntroDSProject1.pdf): Fare distributions across passenger classes and their correlation with survival.
- [**Family Relationships**](./results/EDA_Titanic_IntroDSProject1.pdf): Analysis of `SibSp` and `Parch` variables to understand family size impact on survival.
- [**Port of Embarkation**](./results/EDA_Titanic_IntroDSProject1.pdf): Trends related to embarkation points and their influence on passenger survival.

This comprehensive report provides a visual and statistical summary of the key findings from the Titanic dataset.
