use dbo.fianacial_bank_loan
go
select * from dbo.Financial_Bank_Loan

/* TOTAL LOAM APPLICATIONS*/

select count(id) as Total_Loan_Applications from financial_bank_loan;

/* MONTH TO DATE - TOTAL FUNDED AMOUNT*/

SELECT COUNT(id) AS MTD_TOTAL_FUNDED_AMOUNT FROM DBO.Financial_Bank_Loan
WHERE MONTH(issue_date)= 12  AND YEAR(issue_date)= 2021;


/* PREVIOUS MONTH TO DATE - TOTAL FUNDED AMOUNT*/

SELECT COUNT(id) AS PMTD_TOTAL_FUNDED_AMOUNT FROM DBO.Financial_Bank_Loan
WHERE MONTH(issue_date)= 11  AND YEAR(issue_date)= 2021;

/* SOME OTHER QUERIES FOR UNDERSTANDING  THE DATA*/

SELECT SUM(total_payment) AS MTD_TOTAL_SUM_OF_LOAN_PAYMENTS  FROM DBO.Financial_Bank_Loan
WHERE MONTH(issue_date)=12 AND YEAR(issue_date)=2021

SELECT SUM(total_payment) AS PMTD_TOTAL_SUM_OF_LOAN_PAYMENTS  FROM DBO.Financial_Bank_Loan
WHERE MONTH(issue_date)=12 AND YEAR(issue_date)=2021




/* average intErest rate*/

SELECT ROUND(AVG(int_rate)*100,2) AS AVERAGE_INTEREST_RATE FROM DBO.Financial_Bank_Loan;

/* round the average interest for December month to two decimal places*/
SELECT ROUND(AVG(int_rate)*100,2) AS AVERAGE_MTD_INTEREST_RATE FROM DBO.Financial_Bank_Loan
WHERE MONTH(issue_date)= 12 AND YEAR(issue_date)=2021;

/* Round the avergae interest for two decimalpalces for the previous month*/
SELECT ROUND(AVG(int_rate)*100,2) AS AVERAGE_PMTD_INTEREST_RATE FROM DBO.Financial_Bank_Loan
WHERE MONTH(issue_date)= 11 AND YEAR(issue_date)=2021;


/* AVERAGE DEBT TO INCOME RATIO*/

SELECT ROUND(AVG(dti*100),2) AS AVG_DEBT_TO_INCOME_RATIO FROM DBO.Financial_Bank_Loan;

SELECT ROUND(AVG(dti*100),3) AS AVG_MTD_DEBT_TO_INCOME_RATIO FROM DBO.Financial_Bank_Loan
WHERE MONTH(issue_date)=12 AND YEAR(issue_date)= 2021;

SELECT ROUND(AVG(dti*100),4) AS AVG_PMTD_DEBT_TO_INCOME_RATIO FROM DBO.Financial_Bank_Loan
WHERE MONTH(issue_date)=11 AND YEAR(issue_date)= 2021;

/* */



/* GETTING TO UNDERSTAND THE  DATA FOR  FURTHER  DATA MANIPULATION */

SELECT   home_ownership FROM DBO.Financial_Bank_Loan;

SELECT  home_ownership, count(home_ownership) AS COUNT_OF_HOME_OWNERSHIP FROM DBO.Financial_Bank_Loan GROUP BY home_ownership;

SELECT  loan_status FROM DBO.Financial_Bank_Loan; 

SELECT  loan_status, COUNT(loan_status) as COUNT_OF_LOAN_STATUS FROM DBO.Financial_Bank_Loan GROUP BY loan_status;


/* GOOD LOAN PERCENTAGE*/

SELECT  ROUND((COUNT(CASE WHEN loan_status= 'Fully Paid' OR loan_status='Current' THEN id END ) *100.0)/ count(id),2 ) as percentage_good_loan_status 
FROM DBO.Financial_Bank_Loan

/*Good loan application count */

SELECT COUNT(id) FROM dbo.Financial_Bank_Loan as Count_good_loan_applications
WHERE loan_status = 'Fully Paid' or loan_status = 'Current';


/* Good loan funded amount */

SELECT  sum(loan_amount) AS TOTAL_GOOD_LOAN_FUNDED_AMOUNT  FROM DBO.Financial_Bank_Loan
WHERE loan_status= 'Fully Paid' OR loan_status ='Current'

/* Good loan total received amount */


SELECT  sum(total_payment) AS TOTAL_GOOD_LOAN_RECEIVED_AMOUNT  FROM DBO.Financial_Bank_Loan
WHERE loan_status= 'Fully Paid' OR loan_status ='Current'






/* BAD LOAN PERCENTAGE*/

SELECT  ROUND(((COUNT(CASE WHEN loan_status= 'Charged Off' THEN id END ) *100.0)/ count(id)),3)  as percentage_bad_loan_status 
FROM DBO.Financial_Bank_Loan


/* bad loan applictions count*/

SELECT COUNT(id) as Count_bad_loan_applications FROM DBO.Financial_Bank_Loan
WHERE loan_status = 'Charged Off'


/* BAD loan funded amount */

SELECT  sum(loan_amount) AS TOTAL_BAD_LOAN_FUNDED_AMOUNT  FROM DBO.Financial_Bank_Loan
WHERE loan_status = 'Charged Off';



/* BAD loan total received amount */


SELECT  sum(total_payment) AS TOTAL_BAD_LOAN_RECEIVED_AMOUNT  FROM DBO.Financial_Bank_Loan
WHERE loan_status = 'Charged Off';


/* Loan Status Grid */

SELECT loan_status, COUNT(id)as count_of_loan_application, SUM(loan_amount) as Total_loan_amount, SUM(total_payment) as total_loan_payments_received,
ROUND(AVG(int_rate*100),2) AS Average_interest_rate__for_loan_applications, ROUND(AVG(dti*100),2) AS AVERAGE_DEBT_TO_INCOME 
FROM DBO.Financial_Bank_Loan GROUP BY loan_status;

/* MONTH TO DATE (MTD) LOAN APPLICATIONS LEVIED AND RECEIVED */

SELECT loan_status, SUM(loan_amount) AS MTD_total_loan_amount, SUM(total_payment) AS MTD_total_loan_payment_recievd FROM DBO.Financial_Bank_Loan
WHERE MONTH(issue_date) = 12
GROUP BY loan_status;

/* PREVIOUS MONTH TO DATE (PMTD) LOAN APPLICATION LEVIED AND RECEIVED */

SELECT loan_status, SUM(loan_amount) AS PMTD_total_loan_amount, SUM(total_payment) AS PMTD_total_loan_payment_recievd FROM DBO.Financial_Bank_Loan
WHERE MONTH(issue_date) = 11
GROUP BY loan_status;

/* Month wise loan data from no of application to amount received*/ 

SELECT DATENAME(MONTH,issue_date) as Monthwise_loan_data, 
count(id) as Count_total_monthly_loan_application,
sum(loan_amount) as total_monthly_loan_amount, 
sum(total_payment) as total_monthly_loan_payments_received 
FROM DBO.Financial_Bank_Loan 
group by DATENAME(MONTH,issue_date) 
order by DATENAME(MONTH,issue_date)

/* MONTHLY DATE  */

SELECT MONTH(issue_date) AS MONTH_NUMBER,
DATENAME(MONTH,issue_date) as Monthwise_loan_data, 
count(id) as Count_total_monthly_loan_application,
sum(loan_amount) as total_monthly_loan_amount, 
sum(total_payment) as total_monthly_loan_payments_received 
FROM DBO.Financial_Bank_Loan 
group by MONTH(issue_date), DATENAME(MONTH,issue_date) 
order by MONTH(issue_date), DATENAME(MONTH,issue_date);

/* Term-wise data information*/

SELECT term,
count(id) as Count_total_monthly_loan_application,
sum(loan_amount) as total_monthly_loan_amount, 
sum(total_payment) as total_monthly_loan_payments_received
FROM DBO.Financial_Bank_Loan 
group by term
order by term

/* ADDRESS WISE LOAN DATA INFORMATION */


SELECT address_state,
count(id) as Count_total_monthly_loan_application,
sum(loan_amount) as total_monthly_loan_amount, 
sum(total_payment) as total_monthly_loan_payments_received
FROM DBO.Financial_Bank_Loan 
group by address_state
order by address_state

/* HOME OWNERSHIP TYPE OF LOAN APPLICANT DATA METRICS*/

SELECT home_ownership,
count(id) as Count_total_monthly_loan_application,
sum(loan_amount) as total_monthly_loan_amount, 
sum(total_payment) as total_monthly_loan_payments_received
FROM DBO.Financial_Bank_Loan 
group by home_ownership
order by home_ownership


/* HOME OWNERSHIP TYPE OF LOAN APPLICANT DATA METRICS- WHERE FETCH THE GRADE A AND ADDRESS STATE IS CA*/

SELECT home_ownership,
count(id) as Count_total_monthly_loan_application,
sum(loan_amount) as total_monthly_loan_amount, 
sum(total_payment) as total_monthly_loan_payments_received
FROM DBO.Financial_Bank_Loan 
WHERE grade = 'A' AND address_state= 'CA'
group by home_ownership
order by count(id) DESC

/* PURPOSE OF LOAN APPLICATION METRIC */

SELECT purpose,
count(id) as Count_total_monthly_loan_application,
sum(loan_amount) as total_monthly_loan_amount, 
sum(total_payment) as total_monthly_loan_payments_received
FROM DBO.Financial_Bank_Loan 
group by purpose
order by purpose

/*APPLICATION TYPE OF LOAN AND ITS METRICS*/

SELECT application_type as Application_Type,
count(id) as Count_total_monthly_loan_application,
sum(loan_amount) as total_monthly_loan_amount, 
sum(total_payment) as total_monthly_loan_payments_received
FROM DBO.Financial_Bank_Loan 
group by application_type
order by count(id) desc

/* EMPLOYEE LENGTH LOAN APPLICATION */

SELECT emp_length as Empoloyee_work_length,
count(id) as Count_total_monthly_loan_application,
sum(loan_amount) as total_monthly_loan_amount, 
sum(total_payment) as total_monthly_loan_payments_received
FROM DBO.Financial_Bank_Loan 
group by emp_length
order by count(id) desc

/* VERIFICATION STATUS OF OF LOAN APPLICATION DATA METRIC */

SELECT  verification_status as Verification_status,
count(id) as Count_total_monthly_loan_application,
sum(loan_amount) as total_monthly_loan_amount, 
sum(total_payment) as total_monthly_loan_payments_received
FROM DBO.Financial_Bank_Loan 
group by verification_status
order by count(id) desc

select * from dbo.Financial_Bank_Loan

 r
