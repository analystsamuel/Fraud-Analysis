# Fraud Analysis

An end-to-end fraud analytics project — cleaning 100,000 raw retail transaction records in SQL, then building an interactive 3-page Power BI dashboard to surface fraud patterns and support risk management decisions.

## The Problem
Retail businesses lose money two ways with fraud: letting real fraud slip through, and flagging too many legitimate transactions by mistake. This project set out to understand where fraud actually happens — which payment methods, merchant categories, and locations carry the most risk — and turn that into recommendations someone could act on, not just a wall of charts.

## Data Cleaning (SQL)
The raw dataset needed real work before any analysis could start:
- Removed duplicate transaction records
- Standardized inconsistent formatting across fields
- Identified and handled nulls/blanks in key columns

Full script: `Fraud Queries.sql`

## Data Quality Issues Found
Two problems turned up during profiling, both worth solving properly rather than papering over:

- The dataset's native `fraud_risk` score field was completely corrupted — flatlined at 0.0 for all 100,000 records, so it couldn't be used for any real risk segmentation.
- `is_international` and `unusual_location_flag` turned out to be 100% duplicate fields, so only one was kept to avoid redundant reporting.

Instead of faking or simulating a risk score, a transparent **Risk Level** classification was built from the number of legitimate security flags each transaction actually triggered (velocity, proxy/VPN, high-risk device, etc.):
- **Low Risk:** 0-1 flags triggered
- **Medium Risk:** 2-3 flags triggered
- **High Risk:** 4-5 flags triggered

That methodology is disclosed directly on the dashboard, so it's never mistaken for an original data field.

Worth noting: this is a synthetic/training dataset (fraud rate ~47.5%), not representative of real-world fraud levels — also flagged clearly on the dashboard itself.

## Dashboard Pages

### 1. Executive Overview
Revenue KPIs, fraud by country, risk level financial exposure, transaction type split (domestic vs international).

![Executive Overview](Screenshot%20(415).png)

### 2. Fraud Analysis
Fraud by merchant category, payment method, account age, and transaction velocity/frequency.

![Fraud Analysis](Screenshot%20(416).png)

### 3. Risk & Recommendations
Full fraud indicator breakdown, executive summary, and actionable recommendations.

![Risk & Recommendations](Screenshot%20(417).png)

## Key Insights
- Medium Risk transactions carry the highest financial exposure ($7.1M), ahead of High Risk ($3.3M) — the risk scoring may need a second look, since exposure isn't sitting where you'd typically expect it
- Fraud is spread almost evenly across the top 6 countries ($1.13M-$1.18M each), pointing to a global pattern rather than a regional one
- Domestic transactions make up 66.8% of fraud activity, though international transactions still carry a notable 33.2% share
- Fraud cases drop off sharply as transaction amount rises — most fraud clusters in the Low and Medium amount brackets ($0-$500), not large transactions

## Recommendations
1. Strengthen monitoring of medium-risk transactions, given their outsized financial exposure
2. Review payment methods with elevated fraud activity, particularly Google Pay and Debit Card
3. Increase verification steps for international transactions despite being the minority transaction type
4. Monitor accounts showing multiple triggered fraud indicators simultaneously

## Files in This Repo
- `retail_fraud_detection_100k.csv` — raw dataset
- `Fraud Queries.sql` — SQL cleaning script
- `Fraud Analysis.pbix` — Power BI dashboard file
- Screenshots of all 3 dashboard pages

## Tools Used
SQL · Power Query · Power BI · DAX
