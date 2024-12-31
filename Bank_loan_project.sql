SELECT * FROM bank_loan.finance_1;
select * from finance_2;

-- Total count of row
select count(*) from finance_1;

select count(*) from finance_2;


-- Question 1 : Calculate Total Loan Amount by Purpose

select purpose ,sum(loan_amnt) as total_loan_amnt from finance_1
group by purpose
order by total_loan_amnt desc;


-- Question 2: Find the Average Interest Rate by Grade

select grade, round(avg(int_rate),2) as avg_int_rate from finance_1
group by grade
order by grade;

-- Question 3: Identify the Top 5 States with the Highest Loan Amounts

select addr_state,loan_amnt from finance_1 order by addr_state desc limit 5;


-- Question 4: Calculate the Default Rate by Grade
SELECT grade,COUNT(CASE WHEN loan_status = 'Charged Off' THEN 1 END) * 100.0 / COUNT(*) AS default_rate
FROM finance_1
GROUP BY grade
ORDER BY default_rate DESC;

-- Question 5: Find Borrowers with More than 10 Open Accounts

select id,open_acc from finance_2
where open_acc > 10;

-- Question 6: Calculate Total Payments and Recoveries
select round(sum(total_pymnt),2) as total_pymnt , 
	   round(sum(recoveries),2) as total_recoveries from finance_2;


-- Question 7: Calculate Debt-to-Income Ratio (DTI) by State
select addr_state , round(avg(dti),2) as Debt_to_Income from finance_1
group by addr_state
order by Debt_to_Income desc;

-- Question 8: List Borrowers with the Highest Installment Amounts

SELECT member_id, loan_amnt, installment
FROM finance_1
ORDER BY installment DESC
LIMIT 10;

-- Question 9: Join Tables to Find Total Payments by Loan Purpose

SELECT f1.purpose, ROUND(SUM(f2.total_pymnt), 2) AS total_payments
FROM finance_1 f1
JOIN finance_2 f2 ON f1.member_id = f2.id
GROUP BY f1.purpose
ORDER BY total_payments DESC;

-- Question 10: Find Total Recoveries by Loan Grade
select finance_1.grade ,sum( finance_2.recoveries) as total_recoveries from finance_1
join finance_2 
on finance_1.member_id = finance_2.id
group by grade;

-- Question 11 : Grade -Subcategory wise revolution balance

select finance_1.grade,finance_1.sub_grade, sum(finance_2.revol_bal) as total_revol_bal from finance_1
inner join finance_2
on finance_1.member_id = finance_2.id
group by grade,sub_grade
order by grade,sub_grade;

-- Question 12 total paymnet for verified status Vs Non verified status

select finance_1.verification_status ,round(sum(finance_2.total_pymnt),2) as total_pymnt from finance_1
inner join finance_2
on finance_1.member_id = finance_2.id
group by verification_status;






