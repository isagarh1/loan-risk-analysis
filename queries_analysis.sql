-- Bank Loan Analysis :


SELECT * FROM financial_loan;

SELECT COUNT(*) FROM financial_loan; -- Total loan Applications


-- MTD loan applications -(4314)
SELECT 
	COUNT(id) AS MTD_loan_applications
FROM financial_loan
WHERE EXTRACT(MONTH FROM issue_date)= 12 
AND EXTRACT(YEAR FROM issue_date)= 2021;


-- PMTD loan applications -(4035)
SELECT 
	COUNT(id) AS PMTD_loan_applications
FROM financial_loan
WHERE EXTRACT(MONTH FROM issue_date)= 11 
AND EXTRACT(YEAR FROM issue_date)= 2021;


-- Calculate MoM_growth_loan - (6.91)
WITH CTE_MTD AS
(
SELECT 
	COUNT(id) AS MTD_loan_applications
FROM financial_loan
WHERE EXTRACT(MONTH FROM issue_date)= 12 
AND EXTRACT(YEAR FROM issue_date)= 2021
),
CTE_PMTD AS
(
SELECT 
	COUNT(id) AS PMTD_loan_applications
FROM financial_loan
WHERE EXTRACT(MONTH FROM issue_date)= 11 
AND EXTRACT(YEAR FROM issue_date)= 2021
)
SELECT 
	ROUND(((CTE_MTD. MTD_loan_applications - CTE_PMTD. PMTD_loan_applications)
	::numeric / CTE_PMTD. PMTD_loan_applications * 100),2) AS MoM_growth_loan
FROM CTE_MTD,CTE_PMTD


-- Calculate Total funded amount -(435757075)
SELECT 
	SUM(loan_amount) AS Total_funded_amount
FROM financial_loan


-- Calculate MTD Total funded amount -(53981425)
SELECT 
	SUM(loan_amount) AS Total_funded_amount_MTD
FROM financial_loan
WHERE EXTRACT(MONTH FROM issue_date) = 12


-- Calculate PMTD Total funded amount -(47754825)
SELECT 
	SUM(loan_amount) AS Total_funded_amount_PMTD
FROM financial_loan
WHERE EXTRACT(MONTH FROM issue_date) = 11


-- MoM growth_funded -(13.4)
WITH CTE_mtd AS
(
SELECT 
	SUM(loan_amount) AS Total_funded_amount_MTD
FROM financial_loan
WHERE EXTRACT(MONTH FROM issue_date) = 12
),
CTE_pmtd AS
(
SELECT 
	SUM(loan_amount) AS Total_funded_amount_PMTD
FROM financial_loan
WHERE EXTRACT(MONTH FROM issue_date) = 11
)
SELECT 
	ROUND(((Total_funded_amount_MTD - Total_funded_amount_PMTD)
	::numeric / Total_funded_amount_PMTD * 100),2) AS MoM_funded_growth
FROM CTE_mtd,CTE_pmtd


-- Calculate Total received amount -(473070933)
SELECT 
	SUM(total_payment) AS Total_received_amount
FROM financial_loan


-- Calculate MTD Total received amount -(58074380)
SELECT 
	SUM(total_payment) AS Total_received_amount_MTD
FROM financial_loan
WHERE EXTRACT(MONTH FROM issue_date) = 12


-- Calculate PMTD Total received amount -(50132030)
SELECT 
	SUM(total_payment) AS Total_received_amount_PMTD
FROM financial_loan
WHERE EXTRACT(MONTH FROM issue_date) = 11


-- MoM growth_received -(15.84)
WITH CTE_mtd AS
(
SELECT 
	SUM(total_payment) AS  Total_received_amount_MTD
FROM financial_loan
WHERE EXTRACT(MONTH FROM issue_date) = 12
),
CTE_pmtd AS
(
SELECT 
	SUM(total_payment) AS Total_received_amount_PMTD
FROM financial_loan
WHERE EXTRACT(MONTH FROM issue_date) = 11
)
SELECT 
	ROUND(((Total_received_amount_MTD - Total_received_amount_PMTD)
	::numeric / Total_received_amount_PMTD * 100),2) AS MoM_funded_growth
FROM CTE_mtd,CTE_pmtd


-- Calculate Average interest rate -(12.05%)
SELECT
	ROUND(AVG(int_rate)*100,2) AS average_int_rate
FROM financial_loan


-- Average interest rate MTD -(12.36)
SELECT
	ROUND(AVG(int_rate)*100,2) AS average_int_rate
FROM financial_loan
WHERE EXTRACT(MONTH FROM issue_date) = 12


-- Average interest rate PMTD -(11.94)
SELECT
	ROUND(AVG(int_rate)*100,2) AS average_int_rate
FROM financial_loan
WHERE EXTRACT(MONTH FROM issue_date) = 11


-- MoM Average_interest_rate
WITH CTE_mtd AS
(
SELECT 
	AVG(int_rate) AS average_int_rate_MTD
FROM financial_loan
WHERE EXTRACT(MONTH FROM issue_date) = 12
),
CTE_pmtd AS
(
SELECT 
	AVG(int_rate) AS average_int_rate_PMTD
FROM financial_loan
WHERE EXTRACT(MONTH FROM issue_date) = 11
)
SELECT 
	ROUND(((average_int_rate_MTD - average_int_rate_PMTD)
	::numeric / average_int_rate_PMTD * 100),2) AS MoM_funded_growth
FROM CTE_mtd,CTE_pmtd


-- Calculate DTI interest rate -(13.33%)
SELECT
	ROUND(AVG(dti)*100,2) AS dti_int_rate
FROM financial_loan


-- Average DTI rate MTD -(13.67)
SELECT
	ROUND(AVG(dti)*100,2) AS dti_int_rate_MTD
FROM financial_loan
WHERE EXTRACT(MONTH FROM issue_date) = 12


-- Average DTI rate PMTD -(13.3)
SELECT
	ROUND(AVG(dti)*100,2) AS dti_int_rate_PMTD
FROM financial_loan
WHERE EXTRACT(MONTH FROM issue_date) = 11


-- MoM DTI rate -(2.73)
WITH CTE_mtd AS
(
SELECT 
	AVG(dti) AS dti_int_rate_MTD
FROM financial_loan
WHERE EXTRACT(MONTH FROM issue_date) = 12
),
CTE_pmtd AS
(
SELECT 
	AVG(dti) AS dti_int_rate_PMTD
FROM financial_loan
WHERE EXTRACT(MONTH FROM issue_date) = 11
)
SELECT 
	ROUND(((dti_int_rate_MTD - dti_int_rate_PMTD)
	::numeric / dti_int_rate_PMTD * 100),2) AS MoM_dti
FROM CTE_mtd,CTE_pmtd

----------------------------------------------------------------------------
----------------------------------------------------------------------------
-- Good loan applications -(33243)
SELECT COUNT(id) as Good_loans
FROM financial_loan
WHERE loan_status ='Fully Paid' OR loan_status = 'Current'


-- Good Loan % -(86.18)
SELECT 
    ROUND(AVG(CASE WHEN loan_status IN ('Fully Paid', 'Current') 
	THEN 100 ELSE 0 END),2
    ) AS Good_loan_pct
FROM financial_loan;


-- Good loan Funded Amount - (370224850)
SELECT 	
	SUM(loan_amount) AS good_loan_funded
FROM financial_loan
WHERE loan_status IN ('Fully Paid', 'Current')


-- Good loan Received Amount -(435786170)
SELECT 	
	SUM(total_payment) AS good_loan_funded
FROM financial_loan
WHERE loan_status IN ('Fully Paid', 'Current')

----------------------------------------------------------------------------
----------------------------------------------------------------------------

-- Bad loan applications -(5333)
SELECT COUNT(id) as Bad_loan
FROM financial_loan
WHERE loan_status ='Charged Off'


-- Bad Loan % -(13.82)
SELECT 
    ROUND(AVG(CASE WHEN loan_status = 'Charged Off'
	THEN 100 ELSE 0 END),2
    ) AS Good_loan_pct
FROM financial_loan;


-- Bad loan Funded Amount - (65532225)
SELECT 	
	SUM(loan_amount) AS Bad_loan_funded
FROM financial_loan
WHERE loan_status = 'Charged Off'


-- Bad loan Received Amount -(37284763)
SELECT 	
	SUM(total_payment) AS good_loan_funded
FROM financial_loan
WHERE loan_status = 'Charged Off'


-- Calculate loan count, Total amount funded, Total received amount, Interest Rate DTI on the basis of loan status
SELECT 
	loan_status,
	SUM(loan_amount) AS Total_amount_funded,
	SUM(total_payment) AS Total_amount_received,
	ROUND(AVG(dti)*100,2) AS Average_dti_rate,
	ROUND(AVG(int_rate)*100,2) AS Average_interest_rate
FROM financial_loan
GROUP BY loan_status


-- Calculate Monthly Total_applications, Total amount funded, Total received amount
-- Monthly bank loan report | Overview
SELECT 
	EXTRACT(MONTH FROM issue_date) AS monthly,
	TO_CHAR(issue_date,'MONTH') AS month_name,
	COUNT(id) AS total_applications,
	SUM(loan_amount) AS Total_amount_funded,
	SUM(total_payment) AS Total_amount_received
FROM financial_loan
GROUP BY EXTRACT(MONTH FROM issue_date), TO_CHAR(issue_date,'MONTH')
ORDER BY COUNT(id) DESC


-- Calculate Total_applications, Total amount funded, Total received amount on the basis of Terms
SELECT 
	term,
	COUNT(id) AS total_applications,
	SUM(loan_amount) AS Total_amount_funded,
	SUM(total_payment) AS Total_amount_received
FROM financial_loan
GROUP BY term


-- Calculate Total_applications, Total amount funded, Total received amount on the basis of Emp_length
SELECT 
	emp_length,
	COUNT(id) AS total_applications,
	SUM(loan_amount) AS Total_amount_funded,
	SUM(total_payment) AS Total_amount_received
FROM financial_loan
GROUP BY emp_length
ORDER BY COUNT(id) DESC















