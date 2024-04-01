## 📌 Solution

### 1. What is the average income of borrowers in the dataset?

````sql

SELECT ROUND(AVG(income),2) AS avg_income
FROM credit_risk_analysis

````
**Answer:**

<img width="92" alt="image" src="https://github.com/ainurasyikin/SQL/assets/116057562/317bd51a-818b-4741-9051-0c5ed9804845">


### 2. How does the default status vary with age and income?

````sql

SELECT 
    CASE 
        WHEN Age BETWEEN 20 AND 29 THEN '20-29'
        WHEN Age BETWEEN 30 AND 39 THEN '30-39'
        WHEN Age BETWEEN 40 AND 49 THEN '40-49'
        WHEN Age BETWEEN 50 AND 59 THEN '50-59'
        WHEN Age BETWEEN 60 AND 69 THEN '60-69'
        WHEN Age BETWEEN 70 AND 79 THEN '70-79'
        WHEN Age BETWEEN 80 AND 94 THEN '80-94'
    END AS Age_Group,
    CASE 
        WHEN Income < 25000 THEN '0-25K'
        WHEN Income BETWEEN 25000 AND 49999 THEN '25K-50K'
        WHEN Income BETWEEN 50000 AND 74999 THEN '50K-75K'
        WHEN Income BETWEEN 75000 AND 99999 THEN '75K-100K'
        WHEN Income BETWEEN 100000 AND 199999 THEN '100K-200K'
        WHEN Income BETWEEN 200000 AND 299999 THEN '200K-300K'
        ELSE '300K+'
    END AS Income_Group,
    AVG(CASE WHEN `Default` = 'Y' THEN 1 ELSE 0 END) AS Default_Rate
FROM 
    credit_risk_analysis
GROUP BY 
    Age_Group, Income_Group
ORDER BY 
    Age_Group, Income_Group

````
**Answer:**


### 3. Are there any significant differences in default rates among different home ownership statuses?

````sql

SELECT
    Home,
    AVG(CASE WHEN `Default` = 'Y' THEN 1 ELSE 0 END) AS Default_Rate
FROM
    credit_risk_analysis
GROUP BY
    Home

````
**Answer:**

<img width="194" alt="image" src="https://github.com/ainurasyikin/SQL/assets/116057562/abd8e371-634c-44c3-90a1-ab3c245bb348">


### 4. What is the relationship between loan amount and default status?

````sql

SELECT
    CASE
        WHEN Amount < 5000 THEN '0-5000'
        WHEN Amount BETWEEN 5000 AND 10000 THEN '5000-10000'
        WHEN Amount BETWEEN 10001 AND 20000 THEN '10001-20000'
        WHEN Amount BETWEEN 20001 AND 30000 THEN '20001-30000'
        ELSE '30000+'
    END AS Loan_Amount_Range,
    AVG(CASE WHEN `Default` = 'Y' THEN 1 ELSE 0 END) AS Default_Rate
FROM
    credit_risk_analysis
GROUP BY
    Loan_Amount_Range
ORDER BY
    Loan_Amount_Range
    
````

**Answer:**

<img width="187" alt="image" src="https://github.com/ainurasyikin/SQL/assets/116057562/62e0bf89-ec5f-496c-b15f-8477c7a58bbb">


### 5. How does the length of employment (emp_length) correlate with default rates?

````sql

SELECT
    Emp_length,
    AVG(CASE WHEN `Default` = 'Y' THEN 1 ELSE 0 END) AS Default_Rate
FROM
    credit_risk_analysis
GROUP BY
    Emp_length
ORDER BY
    Emp_length

````

**Answer:**


### 6. What is the distribution of loan amounts among different loan intents?

````sql

SELECT Intent, ROUND(AVG(Amount),2) AS Avg_Loan_Amount, MAX(Amount) AS Max_Loan_Amount, MIN(Amount) AS Min_Loan_Amount
FROM credit_risk_analysis
GROUP BY Intent

````

**Answer:**

<img width="355" alt="image" src="https://github.com/ainurasyikin/SQL/assets/116057562/192c0b1c-00c3-4e0e-97e6-6a72a3266c87">


### 7. How does the interest rate vary with the length of credit history?

````sql

SELECT Cred_length, ROUND(AVG(Rate),2) AS Avg_Interest_Rate
FROM credit_risk_analysis
GROUP BY Cred_length

````

**Answer:**

### 8. What is the average percentage of income allocated to loan payments for borrowers in different age groups?

````sql

SELECT 
    CASE 
        WHEN Age BETWEEN 20 AND 29 THEN '20-29'
        WHEN Age BETWEEN 30 AND 39 THEN '30-39'
        WHEN Age BETWEEN 40 AND 49 THEN '40-49'
        WHEN Age BETWEEN 50 AND 59 THEN '50-59'
        WHEN Age BETWEEN 60 AND 69 THEN '60-69'
        WHEN Age BETWEEN 70 AND 79 THEN '70-79'
        WHEN Age BETWEEN 80 AND 94 THEN '80-94'
    END AS Age_Group, 
    ROUND(AVG(Percent_income),2) AS Avg_Percent_Income
FROM credit_risk_analysis
GROUP BY Age_Group

````

**Answer:**

<img width="180" alt="image" src="https://github.com/ainurasyikin/SQL/assets/116057562/5459e836-2e54-4916-a972-0f985bbcaad3">


### 9. What is the default rate among borrowers with different lengths of employment (emp_length)?

````sql

SELECT Emp_length, AVG('Default') AS Default_Rate
FROM credit_risk_analysis
GROUP BY Emp_length

````

**Answer:**

### 10. How does the loan amount vary between borrowers who own homes versus those who rent?

````sql

SELECT Home, ROUND(AVG(Amount),2) AS Avg_Loan_Amount
FROM credit_risk_analysis
GROUP BY Home

````

**Answer:**

<img width="162" alt="image" src="https://github.com/ainurasyikin/SQL/assets/116057562/b3cb6f63-4b04-49ce-a3a4-3d36b82544fc">

### 11. What is the distribution of loan intents among borrowers who have defaulted on their loans?

````sql

SELECT Intent, COUNT(*) AS Default_Count
FROM credit_risk_analysis
WHERE 'Default' = 'Y'
GROUP BY Intent
ORDER BY Default_Count DESC

````

**Answer:**

<img width="140" alt="image" src="https://github.com/ainurasyikin/SQL/assets/116057562/a4e333a0-4818-4778-910f-c117bc279d78">

### 12. What is the average income of borrowers who have defaulted on their loans?

````sql

SELECT AVG(Income) AS Avg_Income
FROM credit_risk_analysis
WHERE `Default` = 'Y'
````

**Answer:**

<img width="86" alt="image" src="https://github.com/ainurasyikin/SQL/assets/116057562/d8f3cd51-fd9c-4f79-8e1f-5d89352333fd">

