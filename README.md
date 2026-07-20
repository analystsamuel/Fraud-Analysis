# Fraud Analysis

An end-to-end fraud analytics project — cleaning 100,000 raw retail transaction records in SQL, then building an interactive 3-page Power BI dashboard to surface fraud patterns and support risk management decisions.

## The Problem
Retail businesses lose money two ways with fraud: letting real fraud slip through, and flagging too many legitimate transactions by mistake. This project set out to understand where fraud actually happens — which payment methods, merchant categories, and locations carry the most risk — and turn that into recommendations someone could act on, not just a wall of charts.

## Files in This Repo
| File | Description |
|---|---|
| `retail_fraud_detection_100k.csv` | Raw dataset — 100,000 retail transactions with customer, transaction, payment, location, device, and fraud outcome data |
| `Fraud Queries.sql` | SQL script used to clean the raw data — deduplication, standardization, and null/blank handling |
| `Fraud Analysis.pbix` | Final Power BI dashboard file |
| `Screenshot (415/416/417).png` | Dashboard pages — Executive Overview, Fraud Analysis, Risk & Recommendations |

## Data Cleaning (SQL)
The raw dataset needed real work before any analysis could start:
- Removed duplicate transaction records
- Standardized inconsistent formatting across fields
- Identified and handled nulls/blanks in key columns

Full script: `Fraud Queries.sql`

## Data Quality Issues Found
Two problems turned up during profiling, both worth solving properly rather than papering
