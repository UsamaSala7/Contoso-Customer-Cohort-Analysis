# Contoso Customer Retention: Cohort Analysis
**Tech Stack:** PostgreSQL (SQL) + Power BI + DAX  
**Dataset:** Microsoft Contoso Retail

##  Project Objective
The goal of this project is to analyze customer loyalty and retention patterns within the **Contoso Retail dataset**. By grouping customers into "Cohorts" based on their first purchase month, we can track how effectively the business retains customers over a 24-month period.

##  Data Engineering & Transformation
### 1. PostgreSQL Extraction
I used **PostgreSQL** to perform a self-join on the sales data. This allowed me to calculate the `period_offset`—the number of months elapsed between a customer's first purchase and every subsequent transaction.

### 2. Data Formatting
To ensure the visualization is clean and sorted correctly, I transformed the data:
- **Month Formatting:** Converted the cohort month into a clean string format (e.g., `202401`) for better readability and logical sorting.
- **Aggregation:** Grouped distinct customers to create a streamlined "Cohort Table" ready for Power BI.

##  Data Visualization (Power BI)
The challenge with Cohort Heatmaps is the **"Month 0 Bias"**, where the initial high acquisition numbers (e.g., 160k) overshadow the retention trends in later months (e.g., 20k), making the entire heatmap look red.

### The "Row-Level Normalization" Solution
To make the Heatmap actionable, I created a custom **DAX Measure**. This measure calculates the retention percentage relative to each specific cohort's starting size (Month 0), ensuring that each row is colored based on its own performance.

**The DAX Measure:**
```dax
Retention_Heatmap_Scale = 
VAR CurrentCustomers = SUM('cohort'[customers])
VAR MonthZeroCustomers = 
    CALCULATE(
        SUM('cohort'[customers]), 
        'cohort'[period_offset] = 0, 
        ALL('cohort'[period_offset])
    )
RETURN
    DIVIDE(CurrentCustomers, MonthZeroCustomers)

 Final Dashboard

<img width="1081" height="463" alt="image" src="https://github.com/user-attachments/assets/4b8537c7-7d20-4c97-84ad-e5bd23b26499" />

The heatmap highlighting the stability of customer groups and identifying periods of high engagement.
