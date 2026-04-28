# 📊 Loan Portfolio Risk & Profitability Analysis

## 🔍 Key Results
- Reduced default rate from **13.8% → ~12.3% (~11% relative reduction)**
- Maintained **~8% portfolio return**
- Identified **Grades B–C as optimal risk-return segments**
- Recommended reducing exposure to **high-risk borrowers (E–G)**

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

| Scenario | Description |
|----------|------------|
| Baseline | Current portfolio |
| No 60-month loans | Remove long-term loans |
| No E–G grades | Remove high-risk borrowers |
| Combined | Apply both restrictions |

---

## 💡 Recommendation
Focus on **mid-grade borrowers (B–C)** while reducing exposure to **high-risk segments (E–G)** to improve risk-adjusted returns without overly restricting the portfolio.

---
