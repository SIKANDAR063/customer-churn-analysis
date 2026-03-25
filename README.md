# 📊 Customer Churn Analysis — RoaDo Assignment

## 👤 Candidate
Sikandar Ali

---

## 🚀 Project Overview
This project analyzes customer churn for a SaaS company (NimbusAI) using SQL and MongoDB. The objective is to identify key churn drivers, analyze customer behavior, and provide actionable business insights.

The project simulates a real-world data analyst workflow involving data extraction, cleaning, analysis, and visualization.

---

## 🎯 Objective
- Identify key factors causing customer churn  
- Analyze customer segments (company size, acquisition source)  
- Evaluate the effectiveness of signup channels  
- Compare NPS vs actual user behavior  
- Provide data-driven business recommendations  

---

## 🗂️ Data Sources

### 1. PostgreSQL (nimbus_core)
- Customer data  
- Subscription details  
- Billing and plans  
- Support-related information  

### 2. MongoDB (nimbus_events)
- User activity logs  
- NPS survey responses  
- Onboarding events  

---

## 🧹 Data Cleaning

Handled real-world data issues:

- Missing values  
- Duplicate records  
- Mixed data types  
- Inconsistent field names (`customer_id`, `customerId`, `customerID`)  
- Boolean conversion:
  - `t → Active`
  - `f → Churned`  
- Inconsistent timestamps  

---

## 📊 Analysis

### 🔹 SQL Analysis (PostgreSQL)

Performed:
- Overall churn rate calculation  
- Churn segmentation by company size  
- Churn analysis by signup source  
- NPS-based segmentation  

👉 **Churn Rate ≈ 22%**

---

### 🔹 MongoDB Analysis

Used aggregation to analyze user engagement:

```js
db.user_activity_logs.aggregate([
  {
    $group: {
      _id: "$customer_id",
      total_activity: { $sum: 1 }
    }
  },
  { $sort: { total_activity: 1 } }
])