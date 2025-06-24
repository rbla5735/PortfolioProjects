SELECT *
FROM GlobalCybersecurityThreats20

-- Fix column headers


EXEC sp_rename 'GlobalCybersecurityThreats20.[Country]', 'country', 'Column';
EXEC sp_rename 'GlobalCybersecurityThreats20.[Year]', 'year', 'Column';
EXEC sp_rename 'GlobalCybersecurityThreats20.[Attack Type]', 'attack_type', 'Column';
EXEC sp_rename 'GlobalCybersecurityThreats20.[Target Industry]', 'target_industry', 'Column';
EXEC sp_rename 'GlobalCybersecurityThreats20.[financial_loss_in_million_$]', 'financial_loss_in_million_usd', 'Column';
EXEC sp_rename 'GlobalCybersecurityThreats20.[Number of Affected Users]', 'number_of_affected_users', 'Column';
EXEC sp_rename 'GlobalCybersecurityThreats20.[Attack Source]', 'attack_source', 'Column';
EXEC sp_rename 'GlobalCybersecurityThreats20.[Security Vulnerability Type]', 'security_vulnerability_type', 'Column';
EXEC sp_rename 'GlobalCybersecurityThreats20.[Defense Mechanism Used]', 'defense_mechanism_used', 'Column';
EXEC sp_rename 'GlobalCybersecurityThreats20.[Incident Resolution Time (in Hours)]', 'incident_resolution_time_in_hours', 'Column';


-- ===========================
-- BEGINNER LEVEL ANALYSIS
-- ===========================


-- How many cyber attacks were recorded each year?


SELECT year, COUNT(*) as total_attacks
FROM GlobalCybersecurityThreats20
GROUP BY year


-- Which 5 countries reported the most incidents overall?


SELECT TOP (5) country, COUNT(*) as total_attacks
FROM GlobalCybersecurityThreats20
GROUP BY country
ORDER BY total_attacks DESC


-- What are the most common attack types?


SELECT attack_type, COUNT(*) as attack_count
FROM GlobalCybersecurityThreats20
GROUP BY attack_type
ORDER BY attack_count DESC


-- How many unique industries have been targeted?


SELECT COUNT(DISTINCT target_industry) as unique_industries
FROM GlobalCybersecurityThreats20


-- Which years had the highest total financial losses?


SELECT year, SUM(financial_loss_in_million_usd) as total_loss
FROM GlobalCybersecurityThreats20
GROUP BY year
ORDER BY total_loss DESC


-- ===========================
-- INTERMEDIATE LEVEL ANALYSIS
-- ===========================


-- What is the average resolution time across all incidents?


SELECT defense_mechanism_used, AVG(incident_resolution_time_in_hours) as avg_resolution_time
FROM GlobalCybersecurityThreats20
GROUP BY defense_mechanism_used


-- Which attack types result in the highest average financial loss?


SELECT attack_type, ROUND(AVG(financial_loss_in_million_usd),2) AS avg_financial_loss
FROM GlobalCybersecurityThreats20
GROUP BY attack_type
ORDER BY avg_financial_loss DESC


--  Which defense mechanisms resolve incidents the fastest (on average)?

SELECT defense_mechanism_used, ROUND(AVG(incident_resolution_time_in_hours),2) AS avg_response_time_hours
FROM GlobalCybersecurityThreats20
GROUP BY defense_mechanism_used
ORDER BY avg_response_time_hours


-- What’s the trend in affected users per year?

SELECT year, CAST(AVG(number_of_affected_users) AS int) as avg_affected_users
FROM GlobalCybersecurityThreats20
GROUP BY year
ORDER BY year


-- Which industries experience the highest average number of affected users per attack?

SELECT target_industry, CAST(AVG(number_of_affected_users) AS int) as avg_affected_users
FROM GlobalCybersecurityThreats20
GROUP BY target_industry
ORDER BY avg_affected_users DESC


-- Do certain countries experience specific types of attacks more often?

SELECT country, attack_type, COUNT(*) as count
FROM GlobalCybersecurityThreats20
GROUP BY country, attack_type
HAVING COUNT(*) > 50
ORDER BY count DESC





