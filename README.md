# Bellabeta-Wellness-Project

## Table of Contents
- [Project Overview](#project-overview)
- [Business Task](#business-task)
- [How This Project Solves the Business Task](#how-this-project-solves-the-business-task)
- [Tools Used](#tools-used)
- [Dataset Description](#dataset-description)
- [Dashboard Features](#dashboard-features)
- [Steps to Recreate the Dashboard](#steps-to-recreate-the-dashboard)
- [Key Insights](#key-insights)
- [Future Enhancements](#future-enhancements)

## Project Overview
This project is part of the **Google Data Analytics Capstone** and focuses on analyzing smart device usage data to gain insights into consumer behavior. The goal is to provide data-driven recommendations for Bellabeat’s marketing strategy. The dataset used is the **FitBit Fitness Tracker Dataset**.

## Business Task
Bellabeat, a health-focused company, wants to understand how consumers use non-Bellabeat smart devices to track their fitness and wellness. The objective is to analyze fitness trends, activity levels, and sleep patterns to make data-driven recommendations that enhance Bellabeat’s product offerings and marketing strategies.

## How This Project Solves the Business Task
- Conducted a detailed analysis of user activity, sleep, and calorie burn trends using SQL and MySQL Workbench.
- Created an interactive **Tableau dashboard** that allows stakeholders to explore fitness behavior trends visually.
- Provided **key insights** on activity levels, sedentary behavior, and sleep patterns, helping Bellabeat refine its product features.
- Identified potential user groups who may benefit from Bellabeat’s wellness devices and features, aiding in targeted marketing strategies.

## Tools Used
- **SQL (MySQL Workbench)**: Data cleaning and analysis
- **Tableau**: Interactive dashboard creation
- **Excel**: Used only for formatting data according to MySQL Workbench requirements

## Dataset Description
The dataset contains multiple CSV files tracking users' daily activities, sleep, calories burned, and other fitness metrics. Key files used:
- `dailyActivity.csv`
- `sleepDay.csv`
- `weightLogInfo.csv`

## Dashboard Features
The interactive **Bellabeat Wellness Dashboard** includes:
- **KPIs**: Total Steps, Total Calories Burned, Total Active Minutes
- **Line Chart**: Calories vs. Steps trend over time
- **Bar Chart**: Activity Breakdown (Sedentary, Light, Moderate, Intense)
- **Pie Chart**: Sleep Distribution (Hours per Night)
- **Interactive Filters**: User ID & Date

## Steps to Recreate the Dashboard
- **Data Cleaning & Preparation**
  - Import CSV files into MySQL Workbench and perform data cleaning (handling duplicates, missing values, standardizing formats).
  - Format data as needed using Excel to ensure compatibility with MySQL Workbench.
  
- **Tableau Visualization**
  - Connect cleaned dataset from MySQL to Tableau.
  - Create individual sheets for KPIs, charts, and filters.
  - Combine sheets into a single interactive dashboard.
  
- **Interactivity & Insights**
  - Add filters to enable user-specific data exploration.
  - Format visualizations for clarity and professional presentation.

## Key Insights
- Users with higher step counts tend to burn more calories.
- Most users spend a significant portion of their day in sedentary activity.
- Sleep patterns vary, with some users not meeting recommended sleep durations.

## Future Enhancements
- Integrate additional fitness metrics for deeper insights.
- Automate data updates using Python or SQL scripts.
- Expand the dashboard with more user engagement statistics.


