# 📊 Loan Portfolio Risk & Profitability Analysis

## 🔍 Key Results
- Reduced default rate from **13.8% → ~12.3% (~11% relative reduction)** by excluding high-risk segments  
- Maintained **~8% return**, avoiding aggressive profit erosion  
- Identified **Grades B–C as optimal risk-return segments**  
- Demonstrated that removing E–G borrowers improves stability at the cost of ~20% profit reduction  

---

## 📊 Dashboard Preview

### Portfolio Overview
<img width="1287" height="722" alt="Risk Overview" src="https://github.com/user-attachments/assets/49567444-0c10-46f1-867c-beb1eaa74d01" />

### Strategy & Decision
<img width="1281" height="717" alt="Strategy and Decision" src="https://github.com/user-attachments/assets/a5bd8539-e342-41a6-862a-6737990058f0" />

---

## 📌 Overview
Analyzed a consumer loan portfolio using **PostgreSQL and Power BI** to identify high-risk borrower segments and optimize lending strategy through scenario-based analysis.

---

## 🎯 Business Problem
Loan defaults are reducing portfolio profitability.  
The objective is to **minimize default risk without significantly reducing returns or loan volume**.

---

## 🧠 Approach

### 1. Data Preparation
- Cleaned and transformed data using **PostgreSQL**
- Standardized key fields (interest rate, term, loan status)
- Created derived features:
  - Profit = Total Payment − Loan Amount  
  - Term (numeric)  
  - DTI Buckets  

---

### 2. KPI Development
- Default Rate  
- Total Profit  
- Return Rate (Profit / Loan Amount)  
- Loan Volume  

---

### 3. Risk Segmentation
- Borrower grade (A–G)  
- Debt-to-Income (DTI)  
- Loan term (36 vs 60 months)  

---

### 4. Scenario Analysis

| Scenario | Profit | Return | Default Rate | Insight |
|----------|--------|--------|--------------|--------|
| Baseline | 37M | 8.56% | 13.82% | High profit but elevated risk |
| No 60-month | 21.7M | 7.94% | 10.71% | Strong risk reduction but major profit loss |
| No E–G | 29.3M | 8.00% | 12.29% | Best balance of risk and return |
| Combined | 20.3M | 7.89% | 10.25% | Lowest risk but overly restrictive |

---

## 🛠️ Tools & Technologies
- **PostgreSQL** → Data cleaning, feature engineering, and analytical queries  
- **Power BI** → Interactive dashboards, DAX-based KPI modeling, scenario comparison  

## Recommendation:

Focus on mid-grade borrowers (B–C) while reducing exposure to high-risk segments (E–G) to improve risk-adjusted returns without overly restricting the portfolio.
---
