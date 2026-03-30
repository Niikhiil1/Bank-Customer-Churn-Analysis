# Bank-Customer-Churn-Analysis

# 📉 Customer Churn Analysis — SQL + Power BI

An end-to-end customer churn analysis project combining SQL Server for data processing & EDA, and Power BI for interactive dashboards. The goal is to identify why customers leave and which segments are most at risk.

---

## 📁 Project Structure

```
├── SQL_part.sql              # Full SQL pipeline (cleaning, feature engineering, EDA)
├── Churn_Modelling.csv       # Raw dataset (10,000 customers)
└── cust_churn.pbix           # Power BI dashboard
```

---

## 📌 Project Overview

Customer churn is one of the most critical metrics for any business. This project analyzes a bank's customer dataset to:
- Calculate the overall churn rate
- Identify which customer segments churn the most
- Engineer meaningful features for deeper analysis
- Visualize findings through an interactive Power BI dashboard

---

## 🗄️ Dataset

| Property | Details |
|----------|---------|
| Source | Churn Modelling Dataset |
| Rows | 10,000 customers |
| Columns | 14 |
| Target Variable | `Exited` (1 = Churned, 0 = Retained) |

### Column Description

| Column | Description |
|--------|-------------|
| `CustomerId` | Unique customer identifier |
| `CreditScore` | Customer's credit score |
| `Geography` | Country (France / Germany / Spain) |
| `Gender` | Male / Female |
| `Age` | Customer's age |
| `Tenure` | Years with the bank |
| `Balance` | Account balance |
| `NumOfProducts` | Number of bank products held |
| `HasCrCard` | Has a credit card (1 = Yes, 0 = No) |
| `IsActiveMember` | Active member status (1 = Yes, 0 = No) |
| `EstimatedSalary` | Estimated annual salary |
| `Exited` | Churned (1) or Retained (0) |

---

## 🛠️ SQL Pipeline

### Step 1 — Database Setup
- Created a new database `churnanalysis`
- Imported raw data into `dbo.ChurnModel`

### Step 2 — Initial Exploration
- Previewed data with `SELECT TOP`
- Counted total rows (10,000)
- Checked for NULL values across all key columns → **No nulls found**

### Step 3 — Churn Rate Calculation
```sql
SELECT 
    COUNT(*) AS total_customers,
    SUM(CAST(Exited AS INT)) AS customer_churn,
    ROUND(SUM(CAST(Exited AS INT)) * 100.0 / COUNT(*), 2) AS churn_rate
FROM dbo.ChurnModel
```

### Step 4 — Data Cleaning
- Removed irrelevant columns (`RowNumber`, `Surname`, `CustomerId`)
- Created a clean working table `dbo.newTable` using `SELECT INTO`
- Re-validated for NULLs and confirmed correct data types via `sp_help`

### Step 5 — Feature Engineering
Added two new derived columns:

**AgeGroup**
| Age Range | Label |
|-----------|-------|
| < 30 | Young |
| 30 – 60 | Middle Aged |
| > 60 | Senior |

**BalanceGroup**
| Balance Range | Label |
|---------------|-------|
| = 0 | No Balance |
| < 50,000 | Low |
| 50,000 – 150,000 | Medium |
| > 150,000 | High |

### Step 6 — EDA (Exploratory Data Analysis)

Churn was analyzed across 5 dimensions:

| Analysis | Key Finding |
|----------|-------------|
| Churn by Geography | Germany has the highest churn rate |
| Churn by Gender | Female customers churn more than males |
| Churn by Age Group | Senior customers have the highest churn rate |
| Churn by Active Member | Inactive members churn significantly more |
| Churn by No. of Products | Customers with 3–4 products churn at very high rates |

---

## 📊 Power BI Dashboard

The `.pbix` file contains an interactive dashboard built on top of the cleaned SQL data, visualizing:
- Overall churn KPIs (total customers, churned, churn rate)
- Churn breakdown by geography, gender, age group
- Balance and product-level churn analysis
- Active vs inactive member comparison

---

## 💡 Key Insights

- Overall churn rate is approximately **20%**
- **Germany** has the highest churn rate among all geographies
- **Female** customers are more likely to churn than male customers
- **Senior** customers (60+) are the highest-risk age segment
- **Inactive members** churn at nearly double the rate of active members
- Customers with **3 or more products** show a surprisingly high churn rate

---

## 🛠️ Tech Stack

| Tool | Purpose |
|------|---------|
| Microsoft SQL Server (T-SQL) | Data cleaning, feature engineering, EDA |
| SSMS | Query execution and database management |
| Power BI | Interactive dashboard and visualizations |

---

## 🚀 How to Use

1. Clone this repository
2. Import `Churn_Modelling.csv` into SQL Server as `dbo.ChurnModel`
3. Run `SQL_part.sql` top to bottom to recreate the full pipeline
4. Open `cust_churn.pbix` in Power BI Desktop
5. Update the data source connection to your SQL Server instance

---

## 👨‍💻 Author

**Nikhil Dubey**  
📧 nikhildubey17033@gmail.com  


---

## 📌 Status

✅ Complete — SQL pipeline + Power BI dashboard finished.  
🔜 Next step: Add a predictive churn model using Python (Logistic Regression / Random Forest).

---

*If you found this project helpful, feel free to ⭐ star the repository!*
