# dataco-supply-chain-analysis

Overview
This project analyzes 180,000+ supply chain orders from DataCo to investigate where money is being lost and identify areas that can be improved to increase profits. The analysis was completed using MySQL.

Dataset: https://www.kaggle.com/datasets/shashwatwork/dataco-smart-supply-chain-for-big-data-analysis

Business Questions
1. What percentage of orders are Late, On Time and Excellent?
2. Which markets and departments generate the highest total profit?
3. Where are we losing money?
4. Which shipping mode has the worst late delivery rate?
5. Are high profits driven by high order volume or high profit per order?

Key Findings

57% of all orders are late based on actual vs scheduled shipping days.

First Class shipping has a 95% late delivery rate. Customers are paying premium for the worst performing shipping mode.

$3.88M in hidden losses across 33,784 individual orders, masked by profitable departments overall.

Europe leads in total profit driven by both the highest order volume and highest profit per order.

Africa has growth potential. Its profit per order is competitive with other markets, meaning low total profit is a volume problem not a profit per order problem.

Fan Shop dominates department profit, generating more than double any other department.

Recommendations
Investigate the logistics operation. Over half of all orders arriving late points to a systematic issue that needs immediate attention.
Discontinue or switch carriers for First Class shipping. Customers are paying more for the worst service and this needs to be fixed.
Look into the 33,784 loss making orders to understand the reasons behind them. Discounts, specific products, or regions may be driving the losses.
Explore growth strategies for Africa. The profit per order is there but the volume is not.
Fan Shop should be a priority. It is the company's strongest performing department.

Tools Used
MySQL / MySQL Workbench
Dataset: DataCo Smart Supply Chain (Kaggle)
