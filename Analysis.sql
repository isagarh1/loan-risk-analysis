

SELECT *FROM financial_loan LIMIT 50;


-- Handle missing values
SELECT 
    COUNT(*) FILTER (WHERE annual_income IS NULL) AS missing_income,
    COUNT(*) FILTER (WHERE dti IS NULL) AS missing_dti
FROM financial_loan

-- Distinct Check
SELECT DISTINCT loan_status FROM financial_loan;

--CREATE VIEW loan_clean AS
CREATE VIEW loan_clean AS
SELECT 
	id,
	loan_amount,
	annual_income,
	issue_date,
	ROUND((dti)*100,2) AS dti,
	ROUND((int_rate)*100,2) AS int_rate,
	grade,
	sub_grade,
	CAST(REPLACE(term, ' months', '') AS INT) AS term_months,
	total_payment,
	(total_payment - loan_amount) AS Profit,
	loan_status
FROM financial_loan
WHERE annual_income IS NOT NULL
  AND dti IS NOT NULL;


SELECT 
	MIN(loan_amount) AS Min_loan,
	MAX(loan_amount) AS Max_loan,
	ROUND(AVG(loan_amount),2) AS Avg_loan
FROM loan_clean

-- Build Core KPIs
SELECT 
    COUNT(*) AS total_applications,
    SUM(loan_amount) AS total_funded,
    Round(AVG(loan_amount),2) AS avg_loan_size
FROM loan_clean;


-- Default rate
SELECT 
	COUNT(*) FILTER (WHERE loan_status = 'Charged Off') *1.0 / COUNT(*) AS Default_rate
FROM loan_clean;

--Profit
SELECT
	SUM(profit) AS total_profit
FROM loan_clean


--Return rate
SELECT 
    ROUND(SUM(profit) * 100 / SUM(loan_amount),2) AS return_rate
FROM loan_clean;

-- Health portfolio
SELECT 
    loan_status,
    COUNT(*) AS loans,
    SUM(loan_amount) AS exposure
FROM loan_clean
GROUP BY loan_status
ORDER BY exposure DESC;


-- Profit vs loss
SELECT 
	SUM(CASE WHEN loan_status ='Charged Off' THEN 1 ELSE 0 END) AS loss_from_default,
	SUM(CASE WHEN loan_status ='Fully Paid' THEN 1 ELSE 0 END) AS gain_from_good_loan
FROM loan_clean

-- Segmentation
SELECT 
    grade,
    COUNT(*) AS loans,
    SUM(profit) AS total_profit
FROM loan_clean
GROUP BY grade
ORDER BY total_profit DESC;


-- Segments 
SELECT 
    loan_status,
    COUNT(*) AS loans,
    SUM(loan_amount) AS total_exposure,
    SUM(profit) AS total_profit
FROM loan_clean
GROUP BY loan_status


-- Start with Grade (highest signal feature)
SELECT 
    grade,
    COUNT(*) AS loans,
    SUM(loan_amount) AS exposure,
    SUM(profit) AS total_profit,
    SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END) * 1.0 / COUNT(*) AS default_rate
FROM loan_clean
GROUP BY grade
ORDER BY default_rate DESC;


--Add DTI
SELECT 
    CASE 
        WHEN dti < 10 THEN 'low'
        WHEN dti < 20 THEN 'medium'
        ELSE 'high'
    END AS dti_bucket,
    COUNT(*) AS loans,
    SUM(loan_amount) AS exposure,
    SUM(profit) AS total_profit,
    SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END) * 1.0 / COUNT(*) AS default_rate
FROM loan_clean
GROUP BY dti_bucket
ORDER BY default_rate DESC;


--Term analysis 
SELECT 
    term_months,
    COUNT(*) AS loans,
    SUM(loan_amount) AS exposure,
    SUM(profit) AS total_profit,
    SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END) * 1.0 / COUNT(*) AS default_rate
FROM loan_clean
GROUP BY term_months;


-- Combine grade and term 
SELECT 
    grade,
    term_months,
    COUNT(*) AS loans,
    SUM(profit) AS total_profit,
    SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END) * 1.0 / COUNT(*) AS default_rate
FROM loan_clean
GROUP BY grade, term_months
ORDER BY total_profit ASC;


-- Turn Insights into Decisions + Simulate Impact 
-- Baseline
SELECT 
    SUM(profit) AS total_profit,
    SUM(profit) * 1.0 / SUM(loan_amount) AS return_rate,
    COUNT(*) FILTER (WHERE loan_status = 'Charged Off') * 1.0 / COUNT(*) AS default_rate
FROM loan_clean;

-- Scenario A Decision 1: Remove 60-month loans
SELECT 
    SUM(profit) AS total_profit,
    SUM(profit) * 1.0 / SUM(loan_amount) AS return_rate,
    COUNT(*) FILTER (WHERE loan_status = 'Charged Off') * 1.0 / COUNT(*) AS default_rate
FROM loan_clean
WHERE term_months = 36;

-- Decision 2 : Remove high-risk grades (E, F, G)
SELECT 
    SUM(profit) AS total_profit,
    SUM(profit) * 1.0 / SUM(loan_amount) AS return_rate,
    COUNT(*) FILTER (WHERE loan_status = 'Charged Off') * 1.0 / COUNT(*) AS default_rate
FROM loan_clean
WHERE grade IN ('A','B','C','D');

-- Decision 3 : Combine both
SELECT 
    SUM(profit) AS total_profit,
    SUM(profit) * 1.0 / SUM(loan_amount) AS return_rate,
    COUNT(*) FILTER (WHERE loan_status = 'Charged Off') * 1.0 / COUNT(*) AS default_rate
FROM loan_clean
WHERE term_months = 36
  AND grade IN ('A','B','C','D');



SELECT 
    SUM(profit) AS total_profit,
    SUM(profit) * 1.0 / SUM(loan_amount) AS return_rate,
    COUNT(*) FILTER (WHERE loan_status = 'Charged Off') * 1.0 / COUNT(*) AS default_rate
FROM loan_clean
WHERE term_months = 36
  AND grade IN ('A','B','C','D')
  AND dti < 20;

















  