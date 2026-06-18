/* =========================================
   DATA EXPLORATION
   ========================================= */

SELECT * FROM bank_loan_data;

/* =========================================
   KPI - TOTAL APPLICATIONS
   ========================================= */

-- Total Loan Applications
SELECT COUNT(id) AS Total_Applications
FROM bank_loan_data;

-- MTD Loan Applications
SELECT COUNT(id) AS MTD_Applications
FROM bank_loan_data
WHERE MONTH(issue_date) = 12;

-- PMTD Loan Applications
SELECT COUNT(id) AS PMTD_Applications
FROM bank_loan_data
WHERE MONTH(issue_date) = 11;


/* =========================================
   KPI - FUNDED AMOUNT
   ========================================= */

-- Total Funded Amount
SELECT SUM(loan_amount) AS Total_Funded_Amount
FROM bank_loan_data;

-- MTD Funded Amount
SELECT SUM(loan_amount) AS MTD_Funded_Amount
FROM bank_loan_data
WHERE MONTH(issue_date) = 12;

-- PMTD Funded Amount
SELECT SUM(loan_amount) AS PMTD_Funded_Amount
FROM bank_loan_data
WHERE MONTH(issue_date) = 11;


/* =========================================
   KPI - AMOUNT RECEIVED
   ========================================= */

-- Total Amount Received
SELECT SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data;

-- MTD Amount Received
SELECT SUM(total_payment) AS MTD_Amount_Received
FROM bank_loan_data
WHERE MONTH(issue_date) = 12;

-- PMTD Amount Received
SELECT SUM(total_payment) AS PMTD_Amount_Received
FROM bank_loan_data
WHERE MONTH(issue_date) = 11;


/* =========================================
   KPI - INTEREST RATE
   ========================================= */

-- Average Interest Rate
SELECT AVG(int_rate) * 100 AS Avg_Interest_Rate
FROM bank_loan_data;

-- MTD Average Interest Rate
SELECT AVG(int_rate) * 100 AS MTD_Avg_Interest_Rate
FROM bank_loan_data
WHERE MONTH(issue_date) = 12;

-- PMTD Average Interest Rate
SELECT AVG(int_rate) * 100 AS PMTD_Avg_Interest_Rate
FROM bank_loan_data
WHERE MONTH(issue_date) = 11;


/* =========================================
   KPI - DTI
   ========================================= */

-- Average DTI
SELECT AVG(dti) * 100 AS Avg_DTI
FROM bank_loan_data;

-- MTD Average DTI
SELECT AVG(dti) * 100 AS MTD_Avg_DTI
FROM bank_loan_data
WHERE MONTH(issue_date) = 12;

-- PMTD Average DTI
SELECT AVG(dti) * 100 AS PMTD_Avg_DTI
FROM bank_loan_data
WHERE MONTH(issue_date) = 11;


/* =========================================
   GOOD LOAN ANALYSIS
   ========================================= */

-- Good Loan Percentage
SELECT
(
    COUNT(CASE
        WHEN loan_status IN ('Fully Paid', 'Current')
        THEN id
    END) * 100.0
) / COUNT(id) AS Good_Loan_Percentage
FROM bank_loan_data;

-- Good Loan Applications
SELECT COUNT(id) AS Good_Loan_Applications
FROM bank_loan_data
WHERE loan_status IN ('Fully Paid', 'Current');

-- Good Loan Funded Amount
SELECT SUM(loan_amount) AS Good_Loan_Funded_Amount
FROM bank_loan_data
WHERE loan_status IN ('Fully Paid', 'Current');

-- Good Loan Amount Received
SELECT SUM(total_payment) AS Good_Loan_Amount_Received
FROM bank_loan_data
WHERE loan_status IN ('Fully Paid', 'Current');


/* =========================================
   BAD LOAN ANALYSIS
   ========================================= */

-- Bad Loan Percentage
SELECT
(
    COUNT(CASE
        WHEN loan_status = 'Charged Off'
        THEN id
    END) * 100.0
) / COUNT(id) AS Bad_Loan_Percentage
FROM bank_loan_data;

-- Bad Loan Applications
SELECT COUNT(id) AS Bad_Loan_Applications
FROM bank_loan_data
WHERE loan_status = 'Charged Off';

-- Bad Loan Funded Amount
SELECT SUM(loan_amount) AS Bad_Loan_Funded_Amount
FROM bank_loan_data
WHERE loan_status = 'Charged Off';

-- Bad Loan Amount Received
SELECT SUM(total_payment) AS Bad_Loan_Amount_Received
FROM bank_loan_data
WHERE loan_status = 'Charged Off';


/* =========================================
   LOAN STATUS ANALYSIS
   ========================================= */

SELECT
    loan_status,
    COUNT(id) AS Loan_Count,
    SUM(total_payment) AS Total_Amount_Received,
    SUM(loan_amount) AS Total_Funded_Amount,
    AVG(int_rate * 100) AS Interest_Rate,
    AVG(dti * 100) AS DTI
FROM bank_loan_data
GROUP BY loan_status;

SELECT 
	loan_status, 
	SUM(total_payment) AS MTD_Total_Amount_Received, 
	SUM(loan_amount) AS MTD_Total_Funded_Amount 
FROM bank_loan_data
WHERE MONTH(issue_date) = 12 
GROUP BY loan_status



/* =========================================
   MONTHLY TREND
   ========================================= */

SELECT
    MONTH(issue_date) AS Month_Number,
    DATENAME(MONTH, issue_date) AS Month_Name,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY
    MONTH(issue_date),
    DATENAME(MONTH, issue_date)
ORDER BY Month_Number;


/* =========================================
   STATE ANALYSIS
   ========================================= */

SELECT
    address_state AS State,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY address_state
ORDER BY address_state;


/* =========================================
   TERM ANALYSIS
   ========================================= */

SELECT
    term,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY term
ORDER BY term;


/* =========================================
   EMPLOYEE LENGTH ANALYSIS
   ========================================= */

SELECT
    emp_length,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY emp_length
ORDER BY emp_length;


/* =========================================
   PURPOSE ANALYSIS
   ========================================= */

SELECT
    purpose,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY purpose
ORDER BY purpose;


/* =========================================
   HOME OWNERSHIP ANALYSIS
   ========================================= */

SELECT
    home_ownership,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY home_ownership
ORDER BY home_ownership;
