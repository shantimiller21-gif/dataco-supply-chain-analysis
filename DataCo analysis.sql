USE supply_chain;

-- What percentage of orders are Late, On Time and Excellent?
WITH shipping_performance AS (
SELECT 
`Order Id`,
`Days for shipping (real)`,
`Days for shipment (scheduled)`,
CASE 
WHEN `Days for shipping (real)` = `Days for shipment (scheduled)` THEN 'On Time'
WHEN `Days for shipping (real)` < `Days for shipment (scheduled)` THEN 'Excellent'
ELSE 'Late'
END AS performance_label
FROM supply_data
)
SELECT 
performance_label, 
COUNT(*) AS order_count, 
ROUND(COUNT(*) * 100 / SUM(COUNT(*)) OVER(), 2) AS percentage
FROM shipping_performance
GROUP BY performance_label
ORDER BY percentage DESC;

-- Which markets and departments generate the highest total profit?
SELECT 
`Market`, 
ROUND(SUM(`Order Profit Per Order`), 2) AS total_profit
FROM supply_data
GROUP BY `Market`
ORDER BY total_profit DESC;

SELECT 
`Department Name`, 
ROUND(SUM(`Order Profit Per Order`), 2) AS total_profit
FROM supply_data
GROUP BY `Department Name`
ORDER BY total_profit DESC;

-- Where are we losing money? Which markets or departments have negative profit?
SELECT 
COUNT(*) AS loss_orders, 
ROUND(SUM(`Order Profit Per Order`), 2) AS total_loss
FROM supply_data
WHERE `Order Profit Per Order` < 0;

-- Which shipping mode has the worst late delivery rate?
SELECT 
`Shipping Mode`,
COUNT(*) AS total_orders,
SUM(CASE WHEN `Delivery Status` = 'Late delivery' THEN 1 ELSE 0 END) AS late_orders,
ROUND(SUM(CASE WHEN `Delivery Status` = 'Late delivery' THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS late_pct
FROM supply_data
GROUP BY `Shipping Mode`
ORDER BY late_pct DESC;

-- For the top markets, are high profits driven by high order volume or high profit per order?
SELECT 
`Market`, 
ROUND(SUM(`Order Profit Per Order`), 2) AS total_profit, 
ROUND(AVG(`Order Profit Per Order`), 2) AS avg_profit, 
COUNT(*) AS total_orders
FROM supply_data
GROUP BY `Market`
ORDER BY total_profit DESC;

-- Which orders beat their market average sales?
WITH market_avg AS (
SELECT `Market`, AVG(`Sales`) AS avg_sales
FROM supply_data
GROUP BY `Market`
)
SELECT 
s.`Order Id`, 
s.`Market`, 
s.`Sales`, 
ROUND(m.avg_sales, 2) AS avg_sales
FROM supply_data AS s
JOIN market_avg AS m ON s.`Market` = m.`Market`
WHERE s.`Sales` > m.avg_sales;

-- Which regions have the highest average profit per order?
SELECT 
`Order Region`, 
ROUND(AVG(`Order Profit Per Order`), 2) AS avg_profit_per_order
FROM supply_data
GROUP BY `Order Region`
ORDER BY avg_profit_per_order DESC;

-- Ranking orders within each market by profit. 
SELECT 
`Order Id`, 
`Market`, 
`Order Profit Per Order`, 
ROUND(AVG(`Order Profit Per Order`) OVER(PARTITION BY `Market`), 2) AS avg_profit,
RANK() OVER(PARTITION BY `Market` ORDER BY `Order Profit Per Order` DESC) AS order_rank
FROM supply_data;