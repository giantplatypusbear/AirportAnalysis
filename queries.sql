/*============================================================================
 * Write only ONE query (SELECT statement) for each Query # prompt below
 *
 * Hints and caveats are not repeated in each prompt but apply where relevant
 *============================================================================
 */




/* Query 1: Show the DelayRate per Year and AirlineCode, sorted by Year then AirlineCode */
--HINT: Use strftime('%Y', ...)
--CAVEAT: Rates are not additive; they are ratios of sums (not sums of ratios)
--CAVEAT: Rates are REAL numbers; you may multiply the numerator by 1.0

SELECT strftime('%Y', DepartureDate) AS Year, AirlineCode, 1.0 * SUM(DelayMinutes) / SUM(Departures) AS DelayRate
FROM Consolidated
GROUP BY Year, AirlineCode
ORDER BY Year, AirlineCode;


/* Query 2: Show the DelayRate per Year and AirportCode from 2012 to 2017 (inclusive), sorted by Year then AirportCode */
--CAVEAT: Function strftime(...) returns TEXT

SELECT strftime('%Y', DepartureDate) AS Year, AirportCode, 1.0 * SUM(DelayMinutes) / SUM(Departures) AS DelayRate
FROM Consolidated
WHERE DepartureDate >= '2012-01-01' AND DepartureDate <= '2017-12-31'
GROUP BY Year, AirportCode
ORDER BY Year, AirportCode;


/* Query 3: Show the AirlineCode (i.e., only the AirlineCode) with the least Liability with respect to their DelayRate after 2020-07-31 */

SELECT 
  AirlineCode
FROM Consolidated
WHERE DepartureDate > '2020-07-31' AND AirlineCode IS NOT NULL
GROUP BY AirlineCode
ORDER BY 1.0*SUM(DelayMinutes)/SUM(Departures) ASC
LIMIT 1;


/* Query 4: Show the DelayRate per Quarter, sorted by DelayRate largest to smallest */

SELECT 
  Quarter, 
  1.0*SUM(DelayMinutes)/SUM(Departures) AS DelayRate
FROM Consolidated
WHERE Quarter IS NOT NULL
GROUP BY Quarter
ORDER BY DelayRate DESC;



/* Query 5: Display a cross-tab of DelayRates with AirlineCode (rows) and Quarters (columns), both sorted smallest to largest */

SELECT AirlineCode,
SUM(CASE WHEN Quarter = 'Q1'  THEN DelayMinutes ELSE 0 END) / SUM(CASE WHEN Quarter = 'Q1' THEN Departures * 1.0 ELSE 0 END) AS Q1_Delays,
SUM(CASE WHEN Quarter = 'Q2' THEN DelayMinutes ELSE 0 END) / SUM(CASE WHEN Quarter = 'Q2' THEN Departures * 1.0 ELSE 0 END) AS Q2_Delays,
SUM(CASE WHEN Quarter = 'Q3'  THEN DelayMinutes ELSE 0 END) / SUM(CASE WHEN Quarter = 'Q3' THEN Departures * 1.0 ELSE 0 END) AS Q3_Delays,
SUM(CASE WHEN Quarter = 'Q4'  THEN DelayMinutes ELSE 0 END) / SUM(CASE WHEN Quarter = 'Q4' THEN Departures * 1.0 ELSE 0 END) AS Q4_Delays
FROM Consolidated
GROUP BY AirlineCode
ORDER BY AirlineCode ASC;



/* Query 6: Display a cross-tab of Weather-induced DelayRates with AirportCode (rows) and Quarters (columns), both sorted smallest to largest */

SELECT AirportCode,
SUM(CASE WHEN Quarter = 'Q1' AND DelaySource = 'Weather' THEN DelayMinutes ELSE 0 END) / SUM(CASE WHEN Quarter = 'Q1' THEN Departures * 1.0 ELSE 0 END) AS Q1_Weather_Delays,
SUM(CASE WHEN Quarter = 'Q2' AND DelaySource = 'Weather' THEN DelayMinutes ELSE 0 END) / SUM(CASE WHEN Quarter = 'Q2' THEN Departures * 1.0 ELSE 0 END) AS Q2_Weather_Delays,
SUM(CASE WHEN Quarter = 'Q3' AND DelaySource = 'Weather' THEN DelayMinutes ELSE 0 END) / SUM(CASE WHEN Quarter = 'Q3' THEN Departures * 1.0 ELSE 0 END) AS Q3_Weather_Delays,
SUM(CASE WHEN Quarter = 'Q4' AND DelaySource = 'Weather' THEN DelayMinutes ELSE 0 END) / SUM(CASE WHEN Quarter = 'Q4' THEN Departures * 1.0 ELSE 0 END) AS Q4_Weather_Delays
FROM Consolidated
GROUP BY AirportCode
ORDER BY AirlineCode ASC;



