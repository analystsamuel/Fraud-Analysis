-- Data Cleaning

-- Load The Data  by Creating a table

SHOW VARIABLES LIKE 'local_infile';

SET GLOBAL local_infile = 1;

create table retail_fraud_detection (
    transaction_id varchar(50),
    customer_id varchar(50),
    transaction_timestamp timestamp,
    transaction_amount decimal(10, 2),
    payment_method varchar(50),
    device_type varchar(50),
    location varchar(100),
    merchant_category varchar(100),
    is_international int,
    transaction_frequency_24h int,
    avg_transaction_amount_7d decimal(10, 2),
    failed_transaction_count_24h int,
    account_age_days int,
    previous_fraud_flag int,
    unusual_amount_flag int,
    unusual_location_flag int,
    multiple_transactions_short_time int,
    high_risk_device_flag int,
    velocity_flag int,
    fraud_flag int,
    fraud_risk decimal(5, 2));

load data local infile 'c:\\users\\samuel\\downloads\\retail_fraud_detection_100k.csv'
into table retail_fraud_detection
fields terminated by ',' 
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;

select *
from retail_fraud_detection rfd ;

create table retail_fraud_staging
as
select *
from retail_fraud_detection rfd ;

-- Remove duplicates

select *
from retail_fraud_staging rfs 

with cte_duplicates as 
(select transaction_id, row_number()over(partition by transaction_id,customer_id,transaction_timestamp,transaction_amount,
													 payment_method,device_type,location,merchant_category,is_international,
													 transaction_frequency_24h,avg_transaction_amount_7d,failed_transaction_count_24h,
													 account_age_days,previous_fraud_flag,unusual_amount_flag,unusual_location_flag,
													 multiple_transactions_short_time,high_risk_device_flag,velocity_flag,fraud_flag,fraud_risk order by customer_id)
as row_num
from retail_fraud_staging)
select *
from cte_duplicates 
where row_num > 1
order by row_num desc;

-- Standardize the data

select *
from retail_fraud_staging rfs; 

select distinct payment_method
from retail_fraud_staging rfs ;

select distinct device_type
from retail_fraud_staging rfs ;

select distinct location
from retail_fraud_staging rfs ;

select distinct merchant_category
from retail_fraud_staging rfs ;

-- Remove the nulls and blanks

select *
from retail_fraud_staging rfs;

select
    sum(case when transaction_id is null or trim(transaction_id) = '' then 1 else 0 end) as null_tx_id,
    sum(case when customer_id is null or trim(customer_id) = '' then 1 else 0 end) as null_cust_id,
    sum(case when transaction_timestamp is null then 1 else 0 end) as null_timestamp,
    sum(case when payment_method is null or trim(payment_method) = '' then 1 else 0 end) as blank_payment,
    sum(case when device_type is null or trim(device_type) = '' then 1 else 0 end) as blank_device,
    sum(case when location is null or trim(location) = '' then 1 else 0 end) as blank_location,
    sum(case when merchant_category is null or trim(merchant_category) = '' then 1 else 0 end) as blank_merchant
from retail_fraud_staging;

select
    sum(case when transaction_amount is null then 1 else 0 end) as null_amount,
    sum(case when transaction_frequency_24h is null then 1 else 0 end) as null_freq_24h,
    sum(case when avg_transaction_amount_7d is null then 1 else 0 end) as null_avg_7d,
    sum(case when failed_transaction_count_24h is null then 1 else 0 end) as null_failed_24h,
    sum(case when account_age_days is null then 1 else 0 end) as null_account_age
from retail_fraud_staging;

select
    sum(case when is_international is null then 1 else 0 end) as null_international,
    sum(case when previous_fraud_flag is null then 1 else 0 end) as null_prev_fraud,
    sum(case when unusual_amount_flag is null then 1 else 0 end) as null_unusual_amt,
    sum(case when unusual_location_flag is null then 1 else 0 end) as null_unusual_loc,
    sum(case when multiple_transactions_short_time is null then 1 else 0 end) as null_multi_tx,
    sum(case when high_risk_device_flag is null then 1 else 0 end) as null_high_risk_dev,
    sum(case when velocity_flag is null then 1 else 0 end) as null_velocity,
    sum(case when fraud_flag is null then 1 else 0 end) as null_fraud_flag,
    sum(case when fraud_risk is null then 1 else 0 end) as null_fraud_risk
from retail_fraud_staging;







